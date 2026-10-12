#ifndef LAB1_SYLIB_H
#define LAB1_SYLIB_H
/* SysY runtime ABI. Injected with -include when Clang treats .sy as C. */
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
#define starttime() _sysy_starttime(__LINE__)
#define stoptime() _sysy_stoptime(__LINE__)
#endif
