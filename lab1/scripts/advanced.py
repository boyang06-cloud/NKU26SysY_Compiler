"""Execute community MLIR lowering; record NPU-specific environment limits."""
import json
from common import *

def main():
    mlir = tool('MLIR_OPT', LOCAL / 'bin/mlir-opt-14', 'mlir-opt-14')
    translate = tool('MLIR_TRANSLATE', LOCAL / 'bin/mlir-translate-14', 'mlir-translate-14')
    dst = RESULTS / 'mlir'
    dst.mkdir(exist_ok=True)
    BUILD.mkdir(exist_ok=True)
    src = LAB / 'advanced/vecadd_linalg.mlir'
    run([mlir, src], output=dst / '00_linalg.mlir')
    run([mlir, dst / '00_linalg.mlir', '-convert-linalg-to-loops'], output=dst / '01_scf.mlir')
    run([mlir, dst / '01_scf.mlir', '-convert-scf-to-std'], output=dst / '02_cfg.mlir')
    low = ['-convert-memref-to-llvm', '-convert-arith-to-llvm',
           '-convert-std-to-llvm', '-reconcile-unrealized-casts']
    run([mlir, dst / '02_cfg.mlir', *low], output=dst / '03_llvm.mlir')
    run([translate, '--mlir-to-llvmir', dst / '03_llvm.mlir'], output=dst / '04_vecadd.ll')
    run([mlir, src, '-convert-linalg-to-loops', '-convert-scf-to-std', *low,
         '--print-ir-after-all', '--print-ir-module-scope', '--mlir-disable-threading'],
        output=BUILD / 'vecadd_final.mlir', error=dst / 'pass_trace.txt')
    run([LLVM_AS, dst / '04_vecadd.ll', '-o', BUILD / 'vecadd.bc'])
    run([OPT, '-verify', '-disable-output', BUILD / 'vecadd.bc'])
    for level in ['0', '2']:
        exe = BUILD / f'vecadd_O{level}'
        run([CLANG, '-O' + level, dst / '04_vecadd.ll', LAB / 'advanced/vecadd_harness.c',
             '-o', exe], error=BUILD / f'vecadd_O{level}.compile.log')
        run([exe], output=dst / f'execution_O{level}.txt')
    # First separate modern func.func syntax from the actual missing NPU dialect.
    hivm = LAB / 'advanced/vecadd_hivm.mlir'
    p = subprocess.run([mlir, str(hivm)], capture_output=True)
    assert p.returncode != 0 and b"'func.func' is unknown" in p.stderr
    (dst / 'modern_syntax_rejection.txt').write_bytes(p.stderr)
    adapted = BUILD / 'hivm_mlir14_syntax.mlir'
    adapted.write_text(hivm.read_text().replace('func.func @', 'func @'))
    p = subprocess.run([mlir, str(adapted)], capture_output=True)
    assert p.returncode != 0 and b'hivm.address_space' in p.stderr
    (dst / 'hivm_upstream_rejection.txt').write_bytes(p.stderr)
    info = {
        'mlir_version': run([mlir, '--version']).stdout.decode().splitlines()[0],
        'bishengir_compile': shutil.which('bishengir-compile'),
        'cann_paths_present': {p: Path(p).exists() for p in
            ['/usr/local/Ascend/ascend-toolkit', '/usr/local/Ascend/cann', '/usr/Ascend/cann']},
        'npu_device_nodes': [str(p) for p in Path('/dev').glob('davinci*')],
        'npu_execution_performed': False,
        'cpu_element_checks': 64,
        'note': 'Community MLIR CPU lowering was executed. Ascend pipeline is documented, not locally executed.',
    }
    (RESULTS / 'advanced.json').write_text(json.dumps(info, indent=2) + '\n')
    print('MLIR: Linalg → SCF → CFG → LLVM dialect → LLVM IR; 64 CPU element checks passed.')
    print('AscendNPU: documented; CANN, BiShengIR and device availability recorded separately.')

if __name__ == '__main__':
    main()
