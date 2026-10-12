"""Bundle the PDF, authoring sources and experiment evidence for review."""
from pathlib import Path
import zipfile

LAB = Path(__file__).resolve().parents[1]
REPO = LAB.parent

def main():
    target = LAB / 'lab1_submission.zip'
    skipped = {'.aux', '.log', '.out', '.toc', '.pyc', '.synctex.gz'}
    with zipfile.ZipFile(target, 'w', zipfile.ZIP_DEFLATED) as archive:
        for file in sorted(LAB.rglob('*')):
            if not file.is_file() or file == target:
                continue
            rel = file.relative_to(LAB)
            if 'build' in rel.parts or '__pycache__' in rel.parts:
                continue
            if rel.parts[0] == 'report' and (file.suffix in skipped or file.name.startswith('build-pass-')):
                continue
            archive.write(file, file.relative_to(REPO))
        # Preserve the template dependency required by the report's cover page.
        archive.write(REPO / 'LaTeX_template/NKU.png', 'LaTeX_template/NKU.png')
    print(f'Submission bundle ready: {target}')

if __name__ == '__main__':
    main()
