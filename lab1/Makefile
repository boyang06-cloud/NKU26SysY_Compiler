.PHONY: all build test stages advanced report pdf package clean
.NOTPARALLEL:
all: report
build:
	python3 scripts/build.py
test: build
	python3 tests/verify.py
stages: build
	python3 scripts/stages.py
advanced:
	python3 scripts/advanced.py
report: test stages advanced
	python3 scripts/report.py
pdf:
	python3 scripts/report.py
package: report
	python3 scripts/package.py
clean:
	python3 -c "import shutil; shutil.rmtree('build', ignore_errors=True)"
