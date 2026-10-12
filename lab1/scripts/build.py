"""Build independently authored SysY, LLVM IR and RV64 assembly variants."""
import json
from common import *

def build():
    BUILD.mkdir(exist_ok=True)
    RESULTS.mkdir(exist_ok=True)
    (RESULTS / 'commands.log').write_text('')
    versions = {}
    for name, cmd in [('clang', CLANG), ('llvm-opt', OPT), ('rv-linux-gcc', RV_GCC),
                      ('rv-elf-as', RV_AS), ('qemu', QEMU)]:
        versions[name] = run([cmd, '--version']).stdout.decode().splitlines()[0]
    (RESULTS / 'environment.json').write_text(json.dumps({
        'versions': versions, 'sysroot': str(SYSROOT), 'architecture': 'RV64GC / LP64D',
        'qemu': QEMU, 'runtime': 'original lab1/runtime/sylib.c',
    }, indent=2, ensure_ascii=False) + '\n')
    if '7.0.0' not in versions['qemu']:
        raise RuntimeError('Lab1 requires QEMU 7.0.0; set QEMU to its executable.')
    runtime = LAB / 'runtime/sylib.c'
    run([CLANG, '-std=c11', '-O2', '-Wall', '-Wextra', '-Werror', '-c', runtime,
         '-o', BUILD / 'runtime_native.o'])
    run([RV_GCC, *LINK_FLAGS, '-std=c11', '-O2', '-Wall', '-Wextra', '-Werror',
         '-c', runtime, '-o', BUILD / 'runtime_rv64.o'])
    run([LLVM_AS, LAB / 'src/features.ll', '-o', BUILD / 'features.bc'])
    run([OPT, '-verify', '-disable-output', BUILD / 'features.bc'])
    for level in ['0', '2']:
        for kind, source in [('sysy', 'features.sy'), ('ir', 'features.ll')]:
            extra = ['-x', 'c', '-std=c11', '-Wall', '-Wextra', '-Werror',
                     '-include', LAB / 'runtime/sylib.h'] if kind == 'sysy' else []
            common = ['-ffp-contract=off', f'-O{level}', *extra, LAB / 'src' / source]
            run([CLANG, *common, '-c', '-o', BUILD / f'{kind}_native_O{level}.o'],
                error=BUILD / f'{kind}_native_O{level}.compile.log')
            run([CLANG, BUILD / f'{kind}_native_O{level}.o', BUILD / 'runtime_native.o',
                 '-o', BUILD / f'{kind}_native_O{level}'])
            run([CLANG, *RV_FLAGS, *common, '-c', '-o', BUILD / f'{kind}_rv64_O{level}.o'],
                error=BUILD / f'{kind}_rv64_O{level}.compile.log')
            run([RV_GCC, *LINK_FLAGS, BUILD / f'{kind}_rv64_O{level}.o', BUILD / 'runtime_rv64.o',
                 '-o', BUILD / f'{kind}_rv64_O{level}'])
    run([RV_AS, '-march=rv64gc', '-mabi=lp64d', LAB / 'src/features_rv64.s',
         '-o', BUILD / 'asm_rv64.o'])
    run([RV_GCC, *LINK_FLAGS, BUILD / 'asm_rv64.o', BUILD / 'runtime_rv64.o',
         '-Wl,-Map=' + str(BUILD / 'asm_rv64.map'), '-o', BUILD / 'asm_rv64'])
    run([RV_READELF, '-h', '-A', BUILD / 'asm_rv64'], output=RESULTS / 'asm_elf.txt')
    run([RV_OBJDUMP, '-dr', BUILD / 'asm_rv64.o'], output=RESULTS / 'asm_disassembly.txt')
    print('Built 9 executable variants; LLVM verifier passed.')

if __name__ == '__main__':
    build()
