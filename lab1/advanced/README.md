# VecAdd 与逐层 lowering 探索

课程指定参考：[AscendNPU IR VecAdd](https://ascendnpu-ir.gitcode.com/zh_cn/sources/introduction/quick_start/examples_zh.html)、[CANN 毕昇编译器](https://www.hiascend.com/cann/bisheng)。本目录只有 VecAdd 输入和本地实验，不包含他人的 SysY 编译器实现。

## 本机实测

`vecadd_linalg.mlir` 独立表达 16 个 i16 元素相加。MLIR14 中函数语法是 `func`，控制流在 Standard dialect；新版本文档的 `func.func`、`cf` 和部分 pass 名称不能直接照抄。

```bash
make -C lab1 advanced
```

输出保存在 `../results/mlir/`：

| 输出 | 层级及变化 |
| --- | --- |
| `00_linalg.mlir` | 索引映射和 parallel 迭代器表达逐元素运算 |
| `01_scf.mlir` | `-convert-linalg-to-loops` 产生结构化循环与显式 load/store |
| `02_cfg.mlir` | `-convert-scf-to-std` 产生块参数、分支与循环回边 |
| `03_llvm.mlir` | memref/arith/std 降到 LLVM dialect，memref 显式为描述符 |
| `04_vecadd.ll` | `mlir-translate --mlir-to-llvmir` 导出真实 LLVM IR |
| `pass_trace.txt` | 实际运行的各 pass 输出 |
| `execution_O0.txt`、`execution_O2.txt` | 每个版本 16 个普通 + 16 个 i16 回绕结果 |

C 驱动传入 ranked memref 描述符，而非三个普通指针。两个优化级别共 64 个元素检查通过。这是 CPU 的 lowering 观察；输入已有 memref，因此没有宣称实际运行 tensor bufferization。

## AscendNPU 方言分析

`vecadd_hivm.mlir` 按官方示例重新命名、组织，文件内有来源注释。它已经从 HIVM 层开始，不能当作观察到 HFusion lowering 的证据。

| 表达 | 含义与后续工作 |
| --- | --- |
| `hacc.entry`、DEVICE 属性 | 标记设备入口与函数种类，不是线性降低链中独立的一站 |
| `memref<16xi16, #hivm.address_space<gm>>` | 输入和输出位于全局存储 |
| UB 中的三个临时 memref | 输入 tile 与结果 tile；逻辑数据各32字节，实际对齐与复用依编译结果 |
| `hivm.hir.load` ×2 | 从 GM 搬入片上 UB；不能直接等同于 CPU 标量 load |
| `hivm.hir.vadd` | 保留 tile 计算语义，可在目标映射时选择底层向量指令 |
| `hivm.hir.store` | 结果搬回 GM；同步需确保搬运与计算的依赖 |

依据[官方架构](https://ascendnpu-ir.gitcode.com/zh_cn/sources/introduction/architecture_zh.html)，更高层 HFusion 可保留算子语义并进行融合；HIVM 进行存储资源、核内单元及同步映射，再与低层编译路径对接。具体 pass 顺序依入口、选项与目标而定。社区 MLIR CPU 路径没有模拟这些硬件资源。

实测限制记录在 `../results/advanced.json`。直接用 MLIR14 解析该输入先遇到现代函数语法不兼容（`modern_syntax_rejection.txt`）；只调整函数语法后，遇到未注册 `hivm.address_space` 属性（`hivm_upstream_rejection.txt`）。`-allow-unregistered-dialect` 不是方言实现，不能提供专用验证器、优化或目标代码生成。

## 配备专用环境后的观测方法

按[官方构建安装说明](https://ascendnpu-ir.gitcode.com/zh_cn/sources/introduction/quick_start/installing_guide_zh.html) 安装 BiShengIR 和 CANN；端到端执行还需要匹配设备和 runtime。先记录版本及 `bishengir-compile --help` 的输出，再确认当前版本支持的 IR 打印选项，不能假定与 MLIR14 的选项完全一致。

官方编译命令形式为：

```bash
bishengir-compile vecadd_hivm.mlir -enable-hivm-compile -o kernel.o
```

本机未执行此命令、未生成 NPU kernel.o、未上板。若环境齐全，应保存各层 IR 并追踪：GM/UB类型怎样变化、临时缓冲区是否复用、同步在哪里加入、vadd最终如何映射。之后使用 CANN runtime 注册算子，申请和拷贝输入、launch、同步并取回数据，检查全部16项。官方普通输入 `0..15` 加全1的期望为 `1..16`；单有二进制文件不算完成运行验证。
