#include <stdint.h>
#include <stdio.h>
#include <string.h>

/* MLIR's ranked memref C wrapper descriptor: allocated, aligned, offset,
 * size[rank], stride[rank]. It is not an ordinary pointer-only C ABI. */
typedef struct {
    int16_t *allocated;
    int16_t *aligned;
    int64_t offset;
    int64_t sizes[1];
    int64_t strides[1];
} MemRef1D;
extern void _mlir_ciface_vecadd(MemRef1D *, MemRef1D *, MemRef1D *);

int main(void) {
    int16_t a[16], b[16], c[16];
    MemRef1D ma = {a, a, 0, {16}, {1}};
    MemRef1D mb = {b, b, 0, {16}, {1}};
    MemRef1D mc = {c, c, 0, {16}, {1}};
    for (int trial = 0; trial < 2; ++trial) {
        for (int i = 0; i < 16; ++i) {
            a[i] = trial == 0 ? i : (i % 2 ? -32768 : 32767);
            b[i] = trial == 0 ? 1 : (i % 2 ? -1 : 1);
            c[i] = 0;
        }
        _mlir_ciface_vecadd(&ma, &mb, &mc);
        for (int i = 0; i < 16; ++i) {
            uint16_t expected = (uint16_t)((int32_t)a[i] + b[i]);
            uint16_t actual;
            memcpy(&actual, &c[i], sizeof(actual));
            if (actual != expected) {
                fprintf(stderr, "FAIL: trial=%d i=%d expected=%u actual=%u\n",
                        trial, i, expected, actual);
                return 1;
            }
            printf("trial=%d i=%d result=%d PASS\n", trial, i, c[i]);
        }
    }
    puts("PASS: 32 element checks (ordinary + i16 wraparound).");
    return 0;
}
