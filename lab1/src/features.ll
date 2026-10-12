; Hand-written LLVM 14 typed-pointer IR, independently translating features.sy.
; No target triple: the same source is compiled for native x86-64 and RV64.
@hits = global i32 0, align 4
@grid = global [2 x [3 x i32]] [[3 x i32] [i32 1, i32 2, i32 3], [3 x i32] [i32 4, i32 5, i32 6]], align 4

declare i32 @getint()
declare float @getfloat()
declare void @putint(i32)
declare void @putch(i32)
declare void @putfloat(float)

define i32 @tick() {
entry:
  %old = load i32, i32* @hits, align 4
  %new = add i32 %old, 1
  store i32 %new, i32* @hits, align 4
  ret i32 1
}
define i32 @fact(i32 %n) {
entry:
  %base = icmp sle i32 %n, 1
  br i1 %base, label %done, label %recurse
done:
  ret i32 1
recurse:
  %prev = sub i32 %n, 1
  %f = call i32 @fact(i32 %prev)
  %result = mul i32 %n, %f
  ret i32 %result
}
define i32 @mix(i32 %x, i32 %y) {
entry:
  %a = alloca [4 x i32], align 16
  %p0 = getelementptr [4 x i32], [4 x i32]* %a, i64 0, i64 0
  %p1 = getelementptr [4 x i32], [4 x i32]* %a, i64 0, i64 1
  %p2 = getelementptr [4 x i32], [4 x i32]* %a, i64 0, i64 2
  %p3 = getelementptr [4 x i32], [4 x i32]* %a, i64 0, i64 3
  %plus = add i32 %x, %y
  %minus = sub i32 %x, %y
  store i32 %x, i32* %p0, align 4
  store i32 %y, i32* %p1, align 4
  store i32 %plus, i32* %p2, align 4
  store i32 %minus, i32* %p3, align 4
  br label %loop
loop:
  %i = phi i32 [0, %entry], [%next, %skip], [%next, %accumulate]
  %sum = phi i32 [0, %entry], [%sum, %skip], [%updated, %accumulate]
  %test = icmp slt i32 %i, 4
  br i1 %test, label %body, label %exit
body:
  %next = add i32 %i, 1
  %continue = icmp eq i32 %next, 2
  br i1 %continue, label %skip, label %checkbreak
skip:
  br label %loop
checkbreak:
  %break = icmp sgt i32 %next, 3
  br i1 %break, label %exit, label %accumulate
accumulate:
  %index = sext i32 %i to i64
  %p = getelementptr [4 x i32], [4 x i32]* %a, i64 0, i64 %index
  %value = load i32, i32* %p, align 4
  %updated = add i32 %sum, %value
  br label %loop
exit:
  ret i32 %sum
}
define i32 @sumrow([3 x i32]* %a, i32 %row) {
entry:
  %r = sext i32 %row to i64
  br label %loop
loop:
  %i = phi i64 [0, %entry], [%next, %body]
  %sum = phi i32 [0, %entry], [%updated, %body]
  %test = icmp slt i64 %i, 3
  br i1 %test, label %body, label %exit
body:
  %p = getelementptr [3 x i32], [3 x i32]* %a, i64 %r, i64 %i
  %v = load i32, i32* %p, align 4
  %updated = add i32 %sum, %v
  %next = add i64 %i, 1
  br label %loop
exit:
  ret i32 %sum
}
define i32 @compare(i32 %x, i32 %y) {
entry:
  %lt = icmp slt i32 %x, %y
  %le = icmp sle i32 %x, %y
  %gt = icmp sgt i32 %x, %y
  %ge = icmp sge i32 %x, %y
  %eq = icmp eq i32 %x, %y
  %ne = icmp ne i32 %x, %y
  %not = icmp eq i32 %x, 0
  %b0 = select i1 %lt, i32 1, i32 0
  %b1 = select i1 %le, i32 2, i32 0
  %b2 = select i1 %gt, i32 4, i32 0
  %b3 = select i1 %ge, i32 8, i32 0
  %b4 = select i1 %eq, i32 16, i32 0
  %b5 = select i1 %ne, i32 32, i32 0
  %b6 = select i1 %not, i32 64, i32 0
  %s1 = add i32 %b0, %b1
  %s2 = add i32 %s1, %b2
  %s3 = add i32 %s2, %b3
  %s4 = add i32 %s3, %b4
  %s5 = add i32 %s4, %b5
  %s6 = add i32 %s5, %b6
  ret i32 %s6
}
define float @transform(float %x, i32 %bias) {
entry:
  %p = fmul float %x, 5.000000e-01
  %a = fadd float %p, 1.250000e+00
  %s = fsub float %a, 2.500000e-01
  %d = fdiv float %s, 2.000000e+00
  %b = sitofp i32 %bias to float
  %result = fadd float %d, %b
  ret float %result
}
define void @printline(i32 %x) {
entry:
  call void @putint(i32 %x)
  call void @putch(i32 10)
  ret void
}
define i32 @main() {
entry:
  %n = call i32 @getint()
  %d = call i32 @getint()
  %f = call float @getfloat()
  %negative = icmp slt i32 %n, 0
  %lower = select i1 %negative, i32 0, i32 %n
  %large = icmp sgt i32 %lower, 8
  %bounded = select i1 %large, i32 8, i32 %lower
  %fac = call i32 @fact(i32 %bounded)
  call void @printline(i32 %fac)
  %mixed = call i32 @mix(i32 %n, i32 %d)
  call void @printline(i32 %mixed)
  ; OR's true edge bypasses the whole RHS; AND's false edge bypasses tick.
  %dzero = icmp eq i32 %d, 0
  br i1 %dzero, label %logicend, label %andleft
andleft:
  %nonzero = icmp ne i32 %n, 0
  br i1 %nonzero, label %andright, label %logicend
andright:
  %t = call i32 @tick()
  %truth = icmp ne i32 %t, 0
  %bool = zext i1 %truth to i32
  br label %logicend
logicend:
  %logical = phi i32 [1, %entry], [0, %andleft], [%bool, %andright]
  call void @printline(i32 %logical)
  %h = load i32, i32* @hits, align 4
  call void @printline(i32 %h)
  br i1 %dzero, label %divzero, label %divide
divide:
  %q = sdiv i32 %n, %d
  %r = srem i32 %n, %d
  br label %divend
divzero:
  br label %divend
divend:
  %quotient = phi i32 [%q, %divide], [0, %divzero]
  %remainder = phi i32 [%r, %divide], [0, %divzero]
  call void @putint(i32 %quotient)
  call void @putch(i32 32)
  call void @printline(i32 %remainder)
  %mask = call i32 @compare(i32 %n, i32 %d)
  call void @printline(i32 %mask)
  %base = getelementptr [2 x [3 x i32]], [2 x [3 x i32]]* @grid, i64 0, i64 0
  %row = call i32 @sumrow([3 x i32]* %base, i32 1)
  call void @printline(i32 %row)
  call void @printline(i32 7)
  %negd = sub i32 0, %d
  %unary = add i32 %n, %negd
  call void @printline(i32 %unary)
  %float = call float @transform(float %f, i32 %n)
  call void @putfloat(float %float)
  call void @putch(i32 10)
  %truncated = fptosi float %f to i32
  call void @printline(i32 %truncated)
  ret i32 0
}
