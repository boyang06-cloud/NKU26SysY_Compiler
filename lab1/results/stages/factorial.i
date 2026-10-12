# 1 "/home/oliver/Compile_sys_work/BIG_project/lab1/src/factorial.c"
# 1 "<built-in>" 1
# 1 "<built-in>" 3
# 361 "<built-in>" 3
# 1 "<command line>" 1
# 1 "<built-in>" 2
# 1 "/home/oliver/Compile_sys_work/BIG_project/lab1/src/factorial.c" 2
# 1 "/home/oliver/Compile_sys_work/BIG_project/lab1/runtime/sylib.h" 1



int getint(void);
int getch(void);
float getfloat(void);
int getarray(int a[]);
int getfarray(float a[]);
void putint(int a);
void putch(int a);
void putfloat(float a);
void putarray(int n, int a[]);
void putfarray(int n, float a[]);
void putf(char format[], ...);
void _sysy_starttime(int line);
void _sysy_stoptime(int line);
# 2 "/home/oliver/Compile_sys_work/BIG_project/lab1/src/factorial.c" 2





int factorial(int n) {
    int i = 2;
    int f = 1;
    while (i <= n) {
        f = f * i;
        i = i + 1;
    }
    return f + 0;
}
int main(void) {
    int n = getint();
    if (n < 0 || n > 12) return 1;
    putint(factorial(n));
    putch(10);
    return 0;
}
