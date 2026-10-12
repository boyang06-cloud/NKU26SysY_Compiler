"""Download/extract missing Ubuntu packages locally, without sudo or apt install.

Uses the machine's configured APT package indices. Existing compiler and QEMU
installations are retained; this is a fallback for the original lab environment.
"""
from pathlib import Path
import subprocess

ROOT = Path(__file__).resolve().parents[2] / '.tools'
PACKAGES = '''antiword mlir-14-tools gcc-11-riscv64-linux-gnu cpp-11-riscv64-linux-gnu
binutils-riscv64-linux-gnu libgcc-11-dev-riscv64-cross libgcc-s1-riscv64-cross
libc6-riscv64-cross libc6-dev-riscv64-cross linux-libc-dev-riscv64-cross
texlive-binaries texlive-base texlive-latex-base texlive-latex-recommended
texlive-latex-extra texlive-fonts-recommended texlive-pictures texlive-xetex
texlive-lang-chinese fonts-noto-cjk fonts-lmodern libkpathsea6 libptexenc1
libsynctex2 libteckit0 libtexlua53 libtexluajit2 libzzip-0-13 libpaper1 libxt6
libxaw7 libxmu6 libsm6 libice6 poppler-utils libpoppler118 libopenjp2-7
libnss3 libnspr4'''.split()

def main():
    debs = ROOT / 'debs'
    debs.mkdir(parents=True, exist_ok=True)
    missing = [p for p in PACKAGES if not list(debs.glob(p + '_*.deb'))]
    if missing:
        subprocess.run(['apt-get', 'download', *missing], cwd=debs, check=True)
    for deb in sorted(debs.glob('*.deb')):
        subprocess.run(['dpkg-deb', '-x', str(deb), str(ROOT / 'root')], check=True)
    print(f'Dependencies available in {ROOT}; system packages unchanged.')

if __name__ == '__main__':
    main()
