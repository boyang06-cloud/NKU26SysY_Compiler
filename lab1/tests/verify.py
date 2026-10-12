"""Differential execution plus independent mathematical output expectations.

The oracle deliberately replaces source recursion/array loops with closed forms.
It rounds every float operation separately to IEEE binary32; no fast-math/FMA.
"""
import csv
import json
import math
from pathlib import Path
import random
import struct
import subprocess
import sys

sys.path.insert(0, str(Path(__file__).resolve().parents[1] / 'scripts'))
from common import BUILD, LAB, QEMU, RESULTS

def f32(x):
    return struct.unpack('f', struct.pack('f', x))[0]

def expected(n, d, f):
    q = (abs(n) // abs(d)) * (-1 if (n < 0) != (d < 0) else 1) if d else 0
    r = n - q * d if d else 0
    mask = sum(bit for bit, test in [(1, n < d), (2, n <= d), (4, n > d),
               (8, n >= d), (16, n == d), (32, n != d), (64, n == 0)] if test)
    p = f32(f32(f) * 0.5)
    a = f32(p + 1.25)
    s = f32(a - 0.25)
    transformed = f32(f32(s / 2.0) + f32(n))
    return [str(math.factorial(min(8, max(0, n)))), str(2 * n + d),
            str(int(d == 0 or n != 0)), str(int(d != 0 and n != 0)),
            f'{q} {r}', str(mask), '15', '7', str(n - d), transformed,
            str(math.trunc(f32(f)))]

FIXED = [
    ('ordinary', 5, 2, '3.5'), ('or_short_circuit', 5, 0, '-2.75'),
    ('and_short_circuit', 0, 3, '0.0'), ('both_zero', 0, 0, '-0.0'),
    ('negative_dividend', -7, 3, '-3.75'), ('negative_divisor', 7, -3, '4.25'),
    ('both_negative', -7, -3, '0.1'), ('equal', 3, 3, '1.5'),
    ('upper_bound', 8, 2, '100.25'), ('clamp_upper', 9, 2, '-100.25'),
    ('base_one', 1, 2, '0x1.000002p+0'),
    ('rounding_small', -1, 1, '0x1p-24'),
]

def main():
    rng = random.Random(20261011)
    cases = FIXED + [(f'random_{i:03}', rng.randint(-1000, 1000),
                     rng.randint(-20, 20), repr(rng.uniform(-100, 100))) for i in range(88)]
    variants = [f'{kind}_{arch}_O{level}' for kind in ['sysy', 'ir']
                for arch in ['native', 'rv64'] for level in ['0', '2']] + ['asm_rv64']
    rows = []
    samples = {}
    for name, n, d, fs in cases:
        f = float.fromhex(fs) if '0x' in fs else float(fs)
        want = expected(n, d, f)
        inp = f'{n} {d} {fs}\n'.encode()
        reference = None
        for variant in variants:
            cmd = ([QEMU] if 'rv64' in variant else []) + [str(BUILD / variant)]
            p = subprocess.run(cmd, input=inp, capture_output=True, timeout=10)
            got = p.stdout.decode().splitlines()
            assert p.returncode == 0, (name, variant, p.returncode, p.stderr)
            assert not p.stderr, (name, variant, p.stderr)
            assert len(got) == 11, (name, variant, got)
            assert got[:9] == want[:9], (name, variant, got, want)
            assert float.fromhex(got[9]) == want[9], (name, variant, got[9], want[9])
            assert got[10] == want[10], (name, variant, got[10], want[10])
            if reference is None:
                reference = p.stdout
            assert p.stdout == reference, (name, variant, 'cross-variant byte mismatch')
            rows.append([name, variant, 'PASS'])
        if name in [c[0] for c in FIXED]:
            samples[name] = {'input': inp.decode(), 'output': reference.decode()}
    with (RESULTS / 'verification.csv').open('w') as stream:
        writer = csv.writer(stream)
        writer.writerow(['case', 'variant', 'result'])
        writer.writerows(rows)
    summary = {'cases': len(cases), 'variants': len(variants), 'executions': len(rows),
               'passed': len(rows), 'seed': 20261011, 'fixed_cases': samples,
               'domain': 'n in [-1000,1000], d in [-20,20], finite binary32 f in [-101,101]; no signed overflow'}
    (RESULTS / 'verification.json').write_text(json.dumps(summary, indent=2) + '\n')
    print(f'PASS: {len(cases)} cases × {len(variants)} variants = {len(rows)} executions.')

if __name__ == '__main__':
    main()
