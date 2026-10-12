// Rewritten for this lab from the official AscendNPU IR VecAdd example:
// https://ascendnpu-ir.gitcode.com/zh_cn/sources/introduction/quick_start/examples_zh.html
// A reference input for BiShengIR, NOT output from a local NPU compilation.
module {
  func.func @vecadd_device(
      %left: memref<16xi16, #hivm.address_space<gm>>,
      %right: memref<16xi16, #hivm.address_space<gm>>,
      %result: memref<16xi16, #hivm.address_space<gm>>)
      attributes {hacc.entry, hacc.function_kind = #hacc.function_kind<DEVICE>} {
    %left_tile = memref.alloc() : memref<16xi16, #hivm.address_space<ub>>
    %right_tile = memref.alloc() : memref<16xi16, #hivm.address_space<ub>>
    %result_tile = memref.alloc() : memref<16xi16, #hivm.address_space<ub>>
    hivm.hir.load ins(%left : memref<16xi16, #hivm.address_space<gm>>) outs(%left_tile : memref<16xi16, #hivm.address_space<ub>>)
    hivm.hir.load ins(%right : memref<16xi16, #hivm.address_space<gm>>) outs(%right_tile : memref<16xi16, #hivm.address_space<ub>>)
    hivm.hir.vadd ins(%left_tile, %right_tile : memref<16xi16, #hivm.address_space<ub>>, memref<16xi16, #hivm.address_space<ub>>) outs(%result_tile : memref<16xi16, #hivm.address_space<ub>>)
    hivm.hir.store ins(%result_tile : memref<16xi16, #hivm.address_space<ub>>) outs(%result : memref<16xi16, #hivm.address_space<gm>>)
    return
  }
}
