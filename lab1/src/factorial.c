#include "sylib.h"
#define FIRST_FACTOR 2
#ifndef EXTRA
#define EXTRA 0
#endif
/* A single pipeline example; the macro variant adds one to the result. */
int factorial(int n) {
    int i = FIRST_FACTOR;
    int f = 1;
    while (i <= n) {
        f = f * i;
        i = i + 1;
    }
    return f + EXTRA;
}
int main(void) {
    int n = getint();
    if (n < 0 || n > 12) return 1;
    putint(factorial(n));
    putch(10);
    return 0;
}
