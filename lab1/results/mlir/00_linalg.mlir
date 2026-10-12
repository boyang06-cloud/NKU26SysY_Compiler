#map = affine_map<(d0) -> (d0)>
module {
  func @vecadd(%arg0: memref<16xi16>, %arg1: memref<16xi16>, %arg2: memref<16xi16>) attributes {llvm.emit_c_interface} {
    linalg.generic {indexing_maps = [#map, #map, #map], iterator_types = ["parallel"]} ins(%arg0, %arg1 : memref<16xi16>, memref<16xi16>) outs(%arg2 : memref<16xi16>) {
    ^bb0(%arg3: i16, %arg4: i16, %arg5: i16):
      %0 = arith.addi %arg3, %arg4 : i16
      linalg.yield %0 : i16
    }
    return
  }
}

