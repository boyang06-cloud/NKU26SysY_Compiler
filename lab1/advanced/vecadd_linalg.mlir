// Original CPU observation example: same 16 x i16 addition as official VecAdd.
// MLIR 14 uses `func` and the Standard dialect; modern syntax is `func.func`.
module {
  func @vecadd(%a: memref<16xi16>, %b: memref<16xi16>, %c: memref<16xi16>) attributes {llvm.emit_c_interface} {
    linalg.generic {
      indexing_maps = [affine_map<(i) -> (i)>, affine_map<(i) -> (i)>, affine_map<(i) -> (i)>],
      iterator_types = ["parallel"]
    } ins(%a, %b : memref<16xi16>, memref<16xi16>)
      outs(%c : memref<16xi16>) {
    ^bb0(%left: i16, %right: i16, %unused: i16):
      %sum = arith.addi %left, %right : i16
      linalg.yield %sum : i16
    }
    return
  }
}
