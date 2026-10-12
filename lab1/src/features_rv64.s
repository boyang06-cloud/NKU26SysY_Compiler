# Hand-written RV64GC / LP64D implementation of features.sy.
# int operations use *w instructions; sp remains aligned to 16 bytes.
    .option nopic
    .text
    .globl tick
    .type tick, @function
tick:
    la t0, hits
    lw t1, 0(t0)
    addiw t1, t1, 1
    sw t1, 0(t0)
    li a0, 1
    ret
    .size tick, .-tick

    .globl fact
    .type fact, @function
fact:
    li t0, 1
    ble a0, t0, .Lfact_base
    addi sp, sp, -32
    sd ra, 24(sp)
    sd s0, 16(sp)
    mv s0, a0
    addiw a0, a0, -1
    call fact
    mulw a0, s0, a0
    ld s0, 16(sp)
    ld ra, 24(sp)
    addi sp, sp, 32
    ret
.Lfact_base:
    li a0, 1
    ret
    .size fact, .-fact

    .globl mix
    .type mix, @function
mix:
    addi sp, sp, -32
    sw a0, 0(sp)
    sw a1, 4(sp)
    addw t0, a0, a1
    sw t0, 8(sp)
    subw t0, a0, a1
    sw t0, 12(sp)
    li t0, 0                  # i
    li t1, 0                  # sum
.Lmix_loop:
    li t2, 4
    bge t0, t2, .Lmix_exit
    addiw t0, t0, 1
    li t2, 2
    beq t0, t2, .Lmix_loop    # continue
    li t2, 3
    bgt t0, t2, .Lmix_exit    # break
    addiw t2, t0, -1
    slli t2, t2, 2
    add t2, sp, t2
    lw t3, 0(t2)
    addw t1, t1, t3
    j .Lmix_loop
.Lmix_exit:
    mv a0, t1
    addi sp, sp, 32
    ret
    .size mix, .-mix

    .globl sumrow
    .type sumrow, @function
sumrow:
    li t0, 12                 # row stride = 3 * sizeof(int)
    mul t0, a1, t0
    add t0, a0, t0
    li t1, 0
    li a0, 0
.Lrow_loop:
    li t2, 3
    bge t1, t2, .Lrow_exit
    lw t2, 0(t0)
    addw a0, a0, t2
    addi t0, t0, 4
    addiw t1, t1, 1
    j .Lrow_loop
.Lrow_exit:
    ret
    .size sumrow, .-sumrow

    .globl compare
    .type compare, @function
compare:
    slt t0, a0, a1            # <, bit 0
    slt t1, a1, a0
    xori t1, t1, 1           # <=, bit 1
    slli t1, t1, 1
    addw t0, t0, t1
    slt t1, a1, a0           # >, bit 2
    slli t1, t1, 2
    addw t0, t0, t1
    slt t1, a0, a1
    xori t1, t1, 1           # >=, bit 3
    slli t1, t1, 3
    addw t0, t0, t1
    xor t2, a0, a1
    seqz t1, t2              # ==, bit 4
    slli t1, t1, 4
    addw t0, t0, t1
    snez t1, t2              # !=, bit 5
    slli t1, t1, 5
    addw t0, t0, t1
    seqz t1, a0              # !x, bit 6
    slli t1, t1, 6
    addw a0, t0, t1
    ret
    .size compare, .-compare

    .globl transform
    .type transform, @function
transform:
    la t0, .Lfconst
    flw ft0, 0(t0)
    fmul.s fa0, fa0, ft0, rne
    flw ft0, 4(t0)
    fadd.s fa0, fa0, ft0, rne
    flw ft0, 8(t0)
    fsub.s fa0, fa0, ft0, rne
    flw ft0, 12(t0)
    fdiv.s fa0, fa0, ft0, rne
    fcvt.s.w ft0, a0, rne     # LP64D mixed args: float in fa0, int in a0
    fadd.s fa0, fa0, ft0, rne
    ret
    .size transform, .-transform

    .globl printline
    .type printline, @function
printline:
    addi sp, sp, -16
    sd ra, 8(sp)
    call putint
    li a0, 10
    call putch
    ld ra, 8(sp)
    addi sp, sp, 16
    ret
    .size printline, .-printline

    .globl main
    .type main, @function
main:
    addi sp, sp, -64
    sd ra, 56(sp)
    sd s0, 48(sp)
    sd s1, 40(sp)
    sd s2, 32(sp)
    fsd fs0, 24(sp)
    call getint
    mv s0, a0                # input n, survives calls
    call getint
    mv s1, a0                # input d
    call getfloat
    fsgnj.s fs0, fa0, fa0
    mv a0, s0
    bgez a0, .Lbound_upper
    li a0, 0
.Lbound_upper:
    li t0, 8
    ble a0, t0, .Lbound_done
    li a0, 8
.Lbound_done:
    call fact
    call printline
    mv a0, s0
    mv a1, s1
    call mix
    call printline
    beqz s1, .Llogic_true    # || short circuit
    beqz s0, .Llogic_false   # && short circuit
    call tick
    snez a0, a0
    j .Llogic_end
.Llogic_true:
    li a0, 1
    j .Llogic_end
.Llogic_false:
    li a0, 0
.Llogic_end:
    call printline
    la t0, hits
    lw a0, 0(t0)
    call printline
    beqz s1, .Ldiv_zero
    divw a0, s0, s1
    remw s2, s0, s1         # preserve remainder across putint/putch
    j .Ldiv_end
.Ldiv_zero:
    li a0, 0
    li s2, 0
.Ldiv_end:
    call putint
    li a0, 32
    call putch
    mv a0, s2
    call printline
    mv a0, s0
    mv a1, s1
    call compare
    call printline
    la a0, grid
    li a1, 1
    call sumrow
    call printline
    li a0, 7               # shadowed constant is separate from s0
    call printline
    negw t0, s1
    addw a0, s0, t0
    call printline
    fsgnj.s fa0, fs0, fs0
    mv a0, s0
    call transform
    call putfloat
    li a0, 10
    call putch
    fcvt.w.s a0, fs0, rtz   # C/SysY float-to-int truncates toward zero
    call printline
    li a0, 0
    fld fs0, 24(sp)
    ld s2, 32(sp)
    ld s1, 40(sp)
    ld s0, 48(sp)
    ld ra, 56(sp)
    addi sp, sp, 64
    ret
    .size main, .-main

    .section .rodata
    .balign 4
.Lfconst:
    .float 0.5, 1.25, 0.25, 2.0
    .data
    .balign 4
    .globl grid
    .type grid, @object
grid:
    .word 1, 2, 3, 4, 5, 6
    .size grid, 24
    .bss
    .balign 4
    .globl hits
    .type hits, @object
hits:
    .zero 4
    .size hits, 4
    .section .note.GNU-stack,"",@progbits
