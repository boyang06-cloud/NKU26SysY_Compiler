# Lab1：编译过程、手写 IR／汇编与 MLIR 探索

本目录完成 `lab1要求.txt` 的实验工作，为后续**自主实现 SysY 编译器**建立语义基线。这里没有引入他人的词法、语法、优化、代码生成或完整编译器实现。Clang 仅作为 lab1 的研究对象和对照工具。

## 查看成果

- `report/lab1_report.pdf`：实验报告；`report/main.tex`：LaTeX 源文件。
- `src/factorial.c`：编译阶段观察用的唯一 C 示例。
- `src/features.sy`：覆盖核心语言特性、数组和浮点的 SysY 示例。
- `src/features.ll`：独立手写的等价 LLVM IR。
- `src/features_rv64.s`：独立手写的等价 RV64GC／LP64D 汇编。
- `runtime/sylib.c`、`sylib.h`：独立编写的本地 SysY ABI 运行库及声明。
- `results/`：命令、版本、编译各阶段输出、验证记录及 MLIR 实测输出。
- `advanced/`：社区 MLIR 实验、AscendNPU 参考输入与探索说明。

**提交前要补全 `report/authors.tex` 的身份确认和实际分工。**目前姓名和学号沿用提供的模板，分工没有编造。两位成员都须按课程要求在小雅提交 PDF。

## 一键复现

从仓库根目录执行：

```bash
make -C lab1 all
```

分别执行：

```bash
make -C lab1 test       # 编译 + 100 × 9 = 900 次执行验证
make -C lab1 stages     # 保存编译各阶段及选项对比，验证阶乘
make -C lab1 advanced   # 实测 MLIR 降低与 CPU VecAdd
make -C lab1 report     # 重跑实验并编译 PDF
make -C lab1 pdf        # 仅利用已有结果重新编译 PDF，适合修改分工后
make -C lab1 package    # 生成报告、源码和证据的提交压缩包
```

Python 脚本只依赖标准库。当前补充工具在根目录 `.tools/` 中，不纳入源码与提交包；不修改系统包或原工具链。另一台 Ubuntu 22.04 机器可安装同名系统包，或运行：

```bash
python3 lab1/scripts/bootstrap.py
```

该脚本根据已有 APT 索引下载并解包依赖，需要网络，不需要 sudo。首次本地补充约需数百 MB 磁盘与下载空间。报告脚本自动创建本地 XeLaTeX 格式与字体配置。

## 已有工具链与目标 ABI

优先复用 `~/riscv-elf-toolchains/bin/riscv64-unknown-elf-as`、`objdump`、`readelf`。原工具链面向裸机，附带 newlib；本实验用补充的 Linux GCC 驱动和 glibc sysroot 做静态链接。汇编器生成的普通 RV64 ELF 可重定位对象可以参与 Linux 链接，但裸机的启动文件和 libc 不能直接当作 Linux 运行环境。

固定优先使用 `/opt/qemu/bin/qemu-riscv64`，并检查版本为 **7.0.0**。PATH 中旧版 QEMU 4.1.1 不用于实验。工具发现代码位于 `scripts/common.py`，可用 `CLANG`、`OPT`、`LLVM_AS`、`RV_GCC`、`RV_AS`、`RV_OBJDUMP`、`RV_READELF`、`RV_SYSROOT`、`QEMU`、`MLIR_OPT`、`MLIR_TRANSLATE` 覆盖路径。

源文件不写 `#include`，用以下方式由 Clang 读取 SysY 的共同 C 子集，并注入运行库声明。这只是实验对照，不是自主 SysY 前端：

```bash
clang -x c -std=c11 -ffp-contract=off \
  -include lab1/runtime/sylib.h -c lab1/src/features.sy -o features.o
```

## 验证判据

`tests/verify.py` 包含 12 组定向测试与 88 组固定种子随机测试，检查 11 行输出、退出状态、stderr 和九个变体的字节一致性；同时用闭式计算和逐步 binary32 舍入形成独立数学期望。覆盖短路副作用、负数除余、相等比较、阶乘夹取、数组步长、作用域遮蔽、浮点调用约定及向零截断。测试范围与局限记录在 `results/verification.json` 和报告中；没有声称对所有整数输入完成形式证明。

`runtime/sylib.c` 是本地独立实现的 SysY ABI 库，实验实际调用五个 I/O 接口。数组 I/O 等额外接口未纳入本次特性程序的覆盖；计时仅支持单个活动区间。若课程提供正式运行库，可在保持 ABI 和目标架构一致的前提下替换运行库对象进行再验证。本仓库尚未提供单独的《SysY语言定义》《SysY运行时库》，报告已说明这一点。

## 进阶要求的完成方式

当前没有 BiShengIR、CANN 或昇腾设备。按题目允许的方式，分析指定官方 VecAdd，保留真实配置检查和解析失败记录；另外执行社区 MLIR14 的 `Linalg → SCF → Standard CFG → LLVM dialect → LLVM IR` 管线，验证 O0/O2 共 64 个元素。**CPU 实验不是 NPU lowering 或上板运行。**参考输入的官方来源在文件注释、探索说明与报告中标注。

后续实验继续自主实现各模块；本次生成的 Clang/MLIR 输出是观察材料，不应当作自研编译器源码提交。
