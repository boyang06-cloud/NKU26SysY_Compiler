"""Build the LaTeX PDF, including a relocatable, unprivileged TeX fallback."""
import json
import os
from pathlib import Path
import shutil
import subprocess

LAB = Path(__file__).resolve().parents[1]
REPO = LAB.parent
LOCAL = REPO / '.tools/root/usr'
REPORT = LAB / 'report'

def checked(cmd, cwd, log):
    p = subprocess.run(list(map(str, cmd)), cwd=cwd, capture_output=True, timeout=60)
    log.write_bytes(p.stdout + p.stderr)
    if p.returncode:
        raise RuntimeError(f'{cmd[0]} failed; see {log}\n' + p.stdout.decode(errors='replace')[-3500:])

def local_tex():
    root = REPO / '.tools'
    var = root / 'texmf-var'
    config = root / 'texmf-config'
    for path in [var / 'web2c/xetex', config / 'tex/generic/config', root / 'fontcache']:
        path.mkdir(parents=True, exist_ok=True)
    (config / 'tex/generic/config/language.dat').write_text('english hyphen.tex\n')
    os.environ.update({
        'PATH': str(LOCAL / 'bin') + ':' + os.environ['PATH'],
        'LD_LIBRARY_PATH': str(LOCAL / 'lib/x86_64-linux-gnu') + ':' + os.environ.get('LD_LIBRARY_PATH', ''),
        'TEXMFCNF': str(LOCAL / 'share/texlive/texmf-dist/web2c'),
        'TEXMFROOT': str(LOCAL / 'share/texlive'),
        'TEXMFDEBIAN': str(LOCAL / 'share/texmf'),
        'TEXMFVAR': str(var), 'TEXMFCONFIG': str(config),
        'TEXMFSYSVAR': str(var), 'TEXMFSYSCONFIG': str(config),
        'TEXMF': '{' + ','.join(map(str, [config, var, LOCAL / 'share/texmf', LOCAL / 'share/texlive/texmf-dist'])) + '}',
        'VARTEXFONTS': str(var / 'fonts'),
    })
    fc = root / 'fonts.conf'
    fc.write_text(f'''<?xml version="1.0"?>
<!DOCTYPE fontconfig SYSTEM "fonts.dtd">
<fontconfig><dir>/usr/share/fonts</dir><dir>{LOCAL}/share/fonts</dir>
<dir>{LOCAL}/share/texmf/fonts/opentype</dir><cachedir>{root}/fontcache</cachedir></fontconfig>
''')
    os.environ['FONTCONFIG_FILE'] = str(fc)
    if not (var / 'web2c/xetex/xelatex.fmt').exists():
        checked([LOCAL / 'bin/xetex', '-ini', '-etex', '-jobname=xelatex', '-progname=xelatex',
                 '-interaction=nonstopmode', 'xelatex.ini'], var / 'web2c/xetex', root / 'latex-format.log')
    return LOCAL / 'bin/xelatex'

def main():
    for file in ['verification.json', 'stages.json', 'advanced.json']:
        if not (LAB / 'results' / file).exists():
            raise RuntimeError(f'Run experiments first: missing results/{file}')
    stats = json.loads((LAB / 'results/stages.json').read_text())
    verify = json.loads((LAB / 'results/verification.json').read_text())
    generated = [f'\\newcommand{{\\TestCases}}{{{verify["cases"]}}}',
                 f'\\newcommand{{\\TestRuns}}{{{verify["passed"]}}}']
    for key, name in [('O0', 'Zero'), ('O2', 'Two')]:
        for field, macro in [('object_text_bytes', 'TextBytes'), ('alloca', 'Alloca'),
                             ('load', 'Loads'), ('store', 'Stores'), ('phi', 'Phis')]:
            generated.append(f'\\newcommand{{\\{name}{macro}}}{{{stats[key][field]}}}')
    (REPORT / 'measurements.tex').write_text('\n'.join(generated) + '\n')
    xelatex = shutil.which('xelatex') or local_tex()
    for i in range(3):
        checked([xelatex, '-halt-on-error', '-interaction=nonstopmode', '-no-shell-escape',
                 '-jobname=lab1_report', 'main.tex'], REPORT, REPORT / f'build-pass-{i+1}.log')
    print(f'PDF ready: {REPORT / "lab1_report.pdf"}')

if __name__ == '__main__':
    main()
