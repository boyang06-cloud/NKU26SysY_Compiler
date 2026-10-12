/* Original lab runtime, implementing the SysY2022 I/O ABI over libc.
 * No compiler implementation or third-party runtime source is incorporated.
 * Floating output uses hexadecimal notation (%a), as in the SysY ABI.
 */
#include "sylib.h"
#include <stdarg.h>
#include <stdio.h>
#include <time.h>

static void input_error(void) {
    fputs("SysY runtime: invalid or incomplete input\n", stderr);
}
int getint(void) {
    int x = 0;
    if (scanf("%d", &x) != 1) input_error();
    return x;
}
int getch(void) { return getchar(); }
float getfloat(void) {
    float x = 0;
    if (scanf("%f", &x) != 1) input_error();
    return x;
}
int getarray(int a[]) {
    int n = getint();
    for (int i = 0; i < n; ++i) a[i] = getint();
    return n;
}
int getfarray(float a[]) {
    int n = getint();
    for (int i = 0; i < n; ++i) a[i] = getfloat();
    return n;
}
void putint(int x) { printf("%d", x); }
void putch(int x) { putchar(x); }
void putfloat(float x) { printf("%a", (double)x); }
void putarray(int n, int a[]) {
    printf("%d:", n);
    for (int i = 0; i < n; ++i) printf(" %d", a[i]);
    putchar('\n');
}
void putfarray(int n, float a[]) {
    printf("%d:", n);
    for (int i = 0; i < n; ++i) printf(" %a", (double)a[i]);
    putchar('\n');
}
void putf(char format[], ...) {
    va_list args;
    va_start(args, format);
    vprintf(format, args);
    va_end(args);
}
/* One timing region suffices for lab1; elapsed time goes to stderr. */
static clock_t start;
void _sysy_starttime(int line) { (void)line; start = clock(); }
void _sysy_stoptime(int line) {
    fprintf(stderr, "Timer@%d: %.6f s\n", line,
            (double)(clock() - start) / CLOCKS_PER_SEC);
}
