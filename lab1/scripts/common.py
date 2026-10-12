"""Tool discovery and logged commands shared by the lab1 experiments."""
import os
from pathlib import Path
import shlex
import shutil
import subprocess

LAB = Path(__file__).resolve().parents[1]
REPO = LAB.parent
LOCAL = REPO / '.tools/root/usr'
BUILD = LAB / 'build'
RESULTS = LAB / 'results'
if (LOCAL / 'lib/x86_64-linux-gnu').exists():
    os.environ['LD_LIBRARY_PATH'] = str(LOCAL / 'lib/x86_64-linux-gnu') + ':' + os.environ.get('LD_LIBRARY_PATH', '')

def tool(env, *candidates):
    for name in (os.environ.get(env), *candidates):
        if name and (p := shutil.which(str(name))):
            return p
    raise RuntimeError(f'Missing {env}; candidates: {candidates}')

CLANG = tool('CLANG', 'clang-14', 'clang')
OPT = tool('OPT', 'opt-14', 'opt')
LLVM_AS = tool('LLVM_AS', 'llvm-as-14', 'llvm-as')
RV_GCC = tool('RV_GCC', LOCAL / 'bin/riscv64-linux-gnu-gcc-11',
              'riscv64-linux-gnu-gcc')
# Reuse the user's existing assembler and binary inspection tools.
RV_AS = tool('RV_AS', 'riscv64-unknown-elf-as', 'riscv64-linux-gnu-as')
RV_OBJDUMP = tool('RV_OBJDUMP', 'riscv64-unknown-elf-objdump', 'riscv64-linux-gnu-objdump')
RV_READELF = tool('RV_READELF', 'riscv64-unknown-elf-readelf', 'riscv64-linux-gnu-readelf')
QEMU = tool('QEMU', '/opt/qemu/bin/qemu-riscv64', 'qemu-riscv64')
SYSROOT = Path(os.environ.get('RV_SYSROOT', LOCAL / 'riscv64-linux-gnu'
                            if (LOCAL / 'riscv64-linux-gnu').exists()
                            else '/usr/riscv64-linux-gnu'))
RV_FLAGS = ['--target=riscv64-linux-gnu', '-march=rv64gc', '-mabi=lp64d']
LINK_FLAGS = ['-march=rv64gc', '-mabi=lp64d', '-static', '-no-pie',
              f'--sysroot={SYSROOT}']
if (LOCAL / 'lib/gcc-cross/riscv64-linux-gnu/11').exists():
    LINK_FLAGS += [f'-B{LOCAL}/lib/gcc-cross/riscv64-linux-gnu/11/',
                   f'-B{LOCAL}/bin/', f'-L{SYSROOT}/lib']

def run(args, *, output=None, error=None, expected=0, input=None, cwd=REPO):
    args = list(map(str, args))
    RESULTS.mkdir(exist_ok=True)
    with (RESULTS / 'commands.log').open('a') as f:
        f.write(f'$ {shlex.join(args)}\n')
    p = subprocess.run(args, input=input, capture_output=True, cwd=cwd, timeout=60)
    if output:
        Path(output).parent.mkdir(parents=True, exist_ok=True)
        Path(output).write_bytes(p.stdout)
    if error:
        Path(error).parent.mkdir(parents=True, exist_ok=True)
        Path(error).write_bytes(p.stderr)
    if p.returncode != expected:
        raise RuntimeError(f'{shlex.join(args)}\nexit={p.returncode}\n{p.stderr.decode(errors="replace")}')
    return p
