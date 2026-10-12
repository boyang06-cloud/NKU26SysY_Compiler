"""Capture one C program's pipeline and controlled option/source changes."""
import json
import re
from common import *

def main():
    dst = RESULTS / 'stages'
    dst.mkdir(exist_ok=True)
    src = LAB / 'src/factorial.c'
    flags = ['-I', LAB / 'runtime', '-ffp-contract=off', '-fno-addrsig', src]
    run([CLANG, '-E', *flags], output=dst / 'factorial.i')
    run([CLANG, '-E', '-DEXTRA=1', *flags], output=dst / 'factorial_extra.i')
    run([CLANG, '-###', *flags, '-o', BUILD / 'factorial'], error=dst / 'driver.txt')
    run([CLANG, '-fsyntax-only', '-Xclang', '-dump-tokens', *flags], error=dst / 'tokens.txt')
    run([CLANG, '-fsyntax-only', '-Xclang', '-ast-dump', *flags], output=dst / 'ast.txt')
    run([CLANG, '-S', '-emit-llvm', '-O0', '-Xclang', '-disable-O0-optnone', *flags,
         '-o', dst / 'factorial_raw.ll'])
    run([OPT, '-S', '-mem2reg', '-verify', dst / 'factorial_raw.ll',
         '-o', dst / 'factorial_ssa.ll'])
    run([CLANG, '-O2', '-fno-vectorize', '-fno-slp-vectorize', '-S', '-emit-llvm',
         *flags, '-o', dst / 'factorial_O2_novec.ll'])
    run([CLANG, '-O2', '-Rpass=loop-vectorize', '-S', '-emit-llvm', *flags,
         '-o', BUILD / 'factorial_vector_remark.ll'], error=dst / 'vectorization_remarks.txt')
    measurements = {}
    for level in ['0', '2']:
        run([CLANG, '-O' + level, '-S', '-emit-llvm', *flags,
             '-o', dst / f'factorial_O{level}.ll'])
        run([CLANG, '-O' + level, '-g', '-S', '-emit-llvm', *flags,
             '-o', dst / f'factorial_O{level}_g.ll'])
        run([CLANG, *RV_FLAGS, '-O' + level, '-S', *flags,
             '-o', dst / f'factorial_rv64_O{level}.s'])
        obj = BUILD / f'factorial_O{level}.o'
        run([RV_AS, '-march=rv64gc', '-mabi=lp64d', dst / f'factorial_rv64_O{level}.s', '-o', obj])
        run([RV_READELF, '-h', '-S', '-s', '-r', obj], output=dst / f'object_O{level}.txt')
        run([RV_OBJDUMP, '-dr', obj], output=dst / f'object_O{level}.dis')
        # Demonstrate the linker's responsibility with a deliberately missing runtime.
        p = subprocess.run(list(map(str, [RV_GCC, *LINK_FLAGS, obj,
                '-o', BUILD / 'missing_runtime'])), capture_output=True, timeout=60)
        assert p.returncode != 0 and b'getint' in p.stderr
        (dst / f'missing_runtime_O{level}.txt').write_bytes(p.stderr)
        exe = BUILD / f'factorial_O{level}'
        run([RV_GCC, *LINK_FLAGS, obj, BUILD / 'runtime_rv64.o',
             '-Wl,-Map=' + str(dst / f'factorial_O{level}.map'), '-o', exe])
        outputs = {}
        for n in range(13):
            import math
            result = run([QEMU, exe], input=f'{n}\n'.encode())
            assert result.stdout == f'{math.factorial(n)}\n'.encode()
            outputs[n] = result.stdout.decode().strip()
        for n in [-1, 13]:
            assert run([QEMU, exe], input=f'{n}\n'.encode(), expected=1).stdout == b''
        text = (dst / f'factorial_O{level}.ll').read_text()
        fun = re.search(r'define .*?@factorial\(.*?^}', text, re.M | re.S).group()
        size = run(['riscv64-unknown-elf-size', obj]).stdout.decode().splitlines()[-1].split()
        measurements['O' + level] = {
            'object_text_bytes': int(size[0]), 'alloca': len(re.findall(r'\balloca\b', fun)),
            'load': len(re.findall(r'\bload\b', fun)), 'store': len(re.findall(r'\bstore\b', fun)),
            'phi': len(re.findall(r'\bphi\b', fun)), 'outputs': outputs,
        }
    # Controlled preprocessor modification, also executed (not just diffed).
    run([CLANG, *RV_FLAGS, '-O0', '-DEXTRA=1', '-c', *flags,
         '-o', BUILD / 'factorial_extra.o'])
    run([RV_GCC, *LINK_FLAGS, BUILD / 'factorial_extra.o', BUILD / 'runtime_rv64.o',
         '-o', BUILD / 'factorial_extra'])
    assert run([QEMU, BUILD / 'factorial_extra'], input=b'5\n').stdout == b'121\n'
    run([RV_READELF, '-h', '-l', '-s', BUILD / 'factorial_O0'], output=dst / 'executable.txt')
    run(['readelf', '--debug-dump=decodedline', BUILD / 'sysy_native_O0.o'],
        output=dst / 'no_debug_lines.txt')
    run([CLANG, '-g', '-O0', '-c', *flags, '-o', BUILD / 'factorial_debug.o'])
    run(['readelf', '-S', '--debug-dump=decodedline', BUILD / 'factorial_debug.o'],
        output=dst / 'debug_lines.txt')
    (RESULTS / 'stages.json').write_text(json.dumps(measurements, indent=2) + '\n')
    print('Pipeline captured: preprocessing, tokens, AST, raw/SSA/optimized IR, assembly, ELF and linking.')
    print('Factorial: 26 valid runs + 4 invalid-input runs + 1 macro-variant run passed.')

if __name__ == '__main__':
    main()
