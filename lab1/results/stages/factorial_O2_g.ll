; ModuleID = '/home/oliver/Compile_sys_work/BIG_project/lab1/src/factorial.c'
source_filename = "/home/oliver/Compile_sys_work/BIG_project/lab1/src/factorial.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

; Function Attrs: nofree norecurse nosync nounwind readnone uwtable
define dso_local i32 @factorial(i32 noundef %0) local_unnamed_addr #0 !dbg !9 {
  call void @llvm.dbg.value(metadata i32 %0, metadata !15, metadata !DIExpression()), !dbg !18
  call void @llvm.dbg.value(metadata i32 2, metadata !16, metadata !DIExpression()), !dbg !18
  call void @llvm.dbg.value(metadata i32 1, metadata !17, metadata !DIExpression()), !dbg !18
  %2 = icmp slt i32 %0, 2, !dbg !19
  br i1 %2, label %72, label %3, !dbg !20

3:                                                ; preds = %1
  %4 = add i32 %0, -1, !dbg !20
  %5 = icmp ult i32 %4, 8, !dbg !20
  br i1 %5, label %63, label %6, !dbg !20

6:                                                ; preds = %3
  %7 = and i32 %4, -8, !dbg !20
  %8 = or i32 %7, 2, !dbg !20
  %9 = add i32 %7, -8, !dbg !20
  %10 = lshr exact i32 %9, 3, !dbg !20
  %11 = add nuw nsw i32 %10, 1, !dbg !20
  %12 = and i32 %11, 3, !dbg !20
  %13 = icmp ult i32 %9, 24, !dbg !20
  br i1 %13, label %39, label %14, !dbg !20

14:                                               ; preds = %6
  %15 = and i32 %11, 1073741820, !dbg !20
  br label %16, !dbg !20

16:                                               ; preds = %16, %14
  %17 = phi <4 x i32> [ <i32 1, i32 1, i32 1, i32 1>, %14 ], [ %34, %16 ]
  %18 = phi <4 x i32> [ <i32 1, i32 1, i32 1, i32 1>, %14 ], [ %35, %16 ]
  %19 = phi <4 x i32> [ <i32 2, i32 3, i32 4, i32 5>, %14 ], [ %36, %16 ]
  %20 = phi i32 [ 0, %14 ], [ %37, %16 ]
  %21 = add <4 x i32> %19, <i32 4, i32 4, i32 4, i32 4>
  %22 = mul <4 x i32> %17, %19, !dbg !21
  %23 = mul <4 x i32> %18, %21, !dbg !21
  %24 = add <4 x i32> %19, <i32 8, i32 8, i32 8, i32 8>
  %25 = add <4 x i32> %19, <i32 12, i32 12, i32 12, i32 12>
  %26 = mul <4 x i32> %22, %24, !dbg !21
  %27 = mul <4 x i32> %23, %25, !dbg !21
  %28 = add <4 x i32> %19, <i32 16, i32 16, i32 16, i32 16>
  %29 = add <4 x i32> %19, <i32 20, i32 20, i32 20, i32 20>
  %30 = mul <4 x i32> %26, %28, !dbg !21
  %31 = mul <4 x i32> %27, %29, !dbg !21
  %32 = add <4 x i32> %19, <i32 24, i32 24, i32 24, i32 24>
  %33 = add <4 x i32> %19, <i32 28, i32 28, i32 28, i32 28>
  %34 = mul <4 x i32> %30, %32, !dbg !21
  %35 = mul <4 x i32> %31, %33, !dbg !21
  %36 = add <4 x i32> %19, <i32 32, i32 32, i32 32, i32 32>
  %37 = add i32 %20, 4
  %38 = icmp eq i32 %37, %15
  br i1 %38, label %39, label %16, !llvm.loop !23

39:                                               ; preds = %16, %6
  %40 = phi <4 x i32> [ undef, %6 ], [ %34, %16 ]
  %41 = phi <4 x i32> [ undef, %6 ], [ %35, %16 ]
  %42 = phi <4 x i32> [ <i32 1, i32 1, i32 1, i32 1>, %6 ], [ %34, %16 ]
  %43 = phi <4 x i32> [ <i32 1, i32 1, i32 1, i32 1>, %6 ], [ %35, %16 ]
  %44 = phi <4 x i32> [ <i32 2, i32 3, i32 4, i32 5>, %6 ], [ %36, %16 ]
  %45 = icmp eq i32 %12, 0
  br i1 %45, label %57, label %46

46:                                               ; preds = %39, %46
  %47 = phi <4 x i32> [ %52, %46 ], [ %42, %39 ]
  %48 = phi <4 x i32> [ %53, %46 ], [ %43, %39 ]
  %49 = phi <4 x i32> [ %54, %46 ], [ %44, %39 ]
  %50 = phi i32 [ %55, %46 ], [ 0, %39 ]
  %51 = add <4 x i32> %49, <i32 4, i32 4, i32 4, i32 4>
  %52 = mul <4 x i32> %47, %49, !dbg !21
  %53 = mul <4 x i32> %48, %51, !dbg !21
  %54 = add <4 x i32> %49, <i32 8, i32 8, i32 8, i32 8>
  %55 = add i32 %50, 1
  %56 = icmp eq i32 %55, %12
  br i1 %56, label %57, label %46, !llvm.loop !27

57:                                               ; preds = %46, %39
  %58 = phi <4 x i32> [ %40, %39 ], [ %52, %46 ], !dbg !21
  %59 = phi <4 x i32> [ %41, %39 ], [ %53, %46 ], !dbg !21
  %60 = mul <4 x i32> %59, %58, !dbg !20
  %61 = call i32 @llvm.vector.reduce.mul.v4i32(<4 x i32> %60), !dbg !20
  %62 = icmp eq i32 %4, %7, !dbg !20
  br i1 %62, label %72, label %63, !dbg !20

63:                                               ; preds = %3, %57
  %64 = phi i32 [ 1, %3 ], [ %61, %57 ]
  %65 = phi i32 [ 2, %3 ], [ %8, %57 ]
  br label %66, !dbg !20

66:                                               ; preds = %63, %66
  %67 = phi i32 [ %69, %66 ], [ %64, %63 ]
  %68 = phi i32 [ %70, %66 ], [ %65, %63 ]
  call void @llvm.dbg.value(metadata i32 %67, metadata !17, metadata !DIExpression()), !dbg !18
  call void @llvm.dbg.value(metadata i32 %68, metadata !16, metadata !DIExpression()), !dbg !18
  %69 = mul nsw i32 %67, %68, !dbg !21
  call void @llvm.dbg.value(metadata i32 %69, metadata !17, metadata !DIExpression()), !dbg !18
  %70 = add nuw i32 %68, 1, !dbg !29
  call void @llvm.dbg.value(metadata i32 %70, metadata !16, metadata !DIExpression()), !dbg !18
  %71 = icmp eq i32 %68, %0, !dbg !19
  br i1 %71, label %72, label %66, !dbg !20, !llvm.loop !30

72:                                               ; preds = %66, %57, %1
  %73 = phi i32 [ 1, %1 ], [ %61, %57 ], [ %69, %66 ], !dbg !18
  ret i32 %73, !dbg !32
}

; Function Attrs: nounwind uwtable
define dso_local i32 @main() local_unnamed_addr #1 !dbg !33 {
  %1 = tail call i32 @getint() #5, !dbg !38
  call void @llvm.dbg.value(metadata i32 %1, metadata !37, metadata !DIExpression()), !dbg !39
  %2 = icmp ugt i32 %1, 12, !dbg !40
  br i1 %2, label %25, label %3, !dbg !40

3:                                                ; preds = %0
  call void @llvm.dbg.value(metadata i32 %1, metadata !15, metadata !DIExpression()), !dbg !42
  call void @llvm.dbg.value(metadata i32 2, metadata !16, metadata !DIExpression()), !dbg !42
  call void @llvm.dbg.value(metadata i32 1, metadata !17, metadata !DIExpression()), !dbg !42
  %4 = icmp ult i32 %1, 2, !dbg !44
  br i1 %4, label %23, label %5, !dbg !45

5:                                                ; preds = %3
  %6 = add i32 %1, 2, !dbg !45
  %7 = and i32 %6, -4, !dbg !45
  %8 = add i32 %1, -2, !dbg !45
  %9 = insertelement <4 x i32> poison, i32 %8, i64 0, !dbg !45
  %10 = shufflevector <4 x i32> %9, <4 x i32> poison, <4 x i32> zeroinitializer, !dbg !45
  switch i32 %7, label %11 [
    i32 4, label %13
    i32 8, label %12
  ]

11:                                               ; preds = %5
  br label %13

12:                                               ; preds = %5
  br label %13

13:                                               ; preds = %5, %12, %11
  %14 = phi i32 [ 0, %5 ], [ 8, %11 ], [ 4, %12 ]
  %15 = phi <4 x i32> [ <i32 1, i32 1, i32 1, i32 1>, %5 ], [ <i32 12, i32 21, i32 32, i32 45>, %11 ], [ <i32 2, i32 3, i32 4, i32 5>, %12 ]
  %16 = phi <4 x i32> [ <i32 2, i32 3, i32 4, i32 5>, %5 ], [ <i32 120, i32 231, i32 384, i32 585>, %11 ], [ <i32 12, i32 21, i32 32, i32 45>, %12 ], !dbg !46
  %17 = insertelement <4 x i32> poison, i32 %14, i64 0
  %18 = shufflevector <4 x i32> %17, <4 x i32> poison, <4 x i32> zeroinitializer
  %19 = or <4 x i32> %18, <i32 0, i32 1, i32 2, i32 3>
  %20 = icmp ugt <4 x i32> %19, %10
  %21 = select <4 x i1> %20, <4 x i32> %15, <4 x i32> %16
  %22 = call i32 @llvm.vector.reduce.mul.v4i32(<4 x i32> %21), !dbg !45
  br label %23, !dbg !47

23:                                               ; preds = %13, %3
  %24 = phi i32 [ 1, %3 ], [ %22, %13 ], !dbg !42
  tail call void @putint(i32 noundef %24) #5, !dbg !47
  tail call void @putch(i32 noundef 10) #5, !dbg !48
  br label %25, !dbg !49

25:                                               ; preds = %0, %23
  %26 = phi i32 [ 0, %23 ], [ 1, %0 ], !dbg !39
  ret i32 %26, !dbg !50
}

declare !dbg !51 i32 @getint() local_unnamed_addr #2

declare !dbg !54 void @putint(i32 noundef) local_unnamed_addr #2

declare !dbg !57 void @putch(i32 noundef) local_unnamed_addr #2

; Function Attrs: nofree nosync nounwind readnone speculatable willreturn
declare void @llvm.dbg.value(metadata, metadata, metadata) #3

; Function Attrs: nofree nosync nounwind readnone willreturn
declare i32 @llvm.vector.reduce.mul.v4i32(<4 x i32>) #4

attributes #0 = { nofree norecurse nosync nounwind readnone uwtable "frame-pointer"="none" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #1 = { nounwind uwtable "frame-pointer"="none" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #2 = { "frame-pointer"="none" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #3 = { nofree nosync nounwind readnone speculatable willreturn }
attributes #4 = { nofree nosync nounwind readnone willreturn }
attributes #5 = { nounwind }

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!2, !3, !4, !5, !6, !7}
!llvm.ident = !{!8}

!0 = distinct !DICompileUnit(language: DW_LANG_C99, file: !1, producer: "Ubuntu clang version 14.0.0-1ubuntu1.1", isOptimized: true, runtimeVersion: 0, emissionKind: FullDebug, splitDebugInlining: false, nameTableKind: None)
!1 = !DIFile(filename: "/home/oliver/Compile_sys_work/BIG_project/lab1/src/factorial.c", directory: "/home/oliver/Compile_sys_work/BIG_project", checksumkind: CSK_MD5, checksum: "cb911e1368787c587ec76de0781e3b32")
!2 = !{i32 7, !"Dwarf Version", i32 5}
!3 = !{i32 2, !"Debug Info Version", i32 3}
!4 = !{i32 1, !"wchar_size", i32 4}
!5 = !{i32 7, !"PIC Level", i32 2}
!6 = !{i32 7, !"PIE Level", i32 2}
!7 = !{i32 7, !"uwtable", i32 1}
!8 = !{!"Ubuntu clang version 14.0.0-1ubuntu1.1"}
!9 = distinct !DISubprogram(name: "factorial", scope: !10, file: !10, line: 7, type: !11, scopeLine: 7, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0, retainedNodes: !14)
!10 = !DIFile(filename: "lab1/src/factorial.c", directory: "/home/oliver/Compile_sys_work/BIG_project", checksumkind: CSK_MD5, checksum: "cb911e1368787c587ec76de0781e3b32")
!11 = !DISubroutineType(types: !12)
!12 = !{!13, !13}
!13 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!14 = !{!15, !16, !17}
!15 = !DILocalVariable(name: "n", arg: 1, scope: !9, file: !10, line: 7, type: !13)
!16 = !DILocalVariable(name: "i", scope: !9, file: !10, line: 8, type: !13)
!17 = !DILocalVariable(name: "f", scope: !9, file: !10, line: 9, type: !13)
!18 = !DILocation(line: 0, scope: !9)
!19 = !DILocation(line: 10, column: 14, scope: !9)
!20 = !DILocation(line: 10, column: 5, scope: !9)
!21 = !DILocation(line: 11, column: 15, scope: !22)
!22 = distinct !DILexicalBlock(scope: !9, file: !10, line: 10, column: 20)
!23 = distinct !{!23, !20, !24, !25, !26}
!24 = !DILocation(line: 13, column: 5, scope: !9)
!25 = !{!"llvm.loop.mustprogress"}
!26 = !{!"llvm.loop.isvectorized", i32 1}
!27 = distinct !{!27, !28}
!28 = !{!"llvm.loop.unroll.disable"}
!29 = !DILocation(line: 12, column: 15, scope: !22)
!30 = distinct !{!30, !20, !24, !25, !31, !26}
!31 = !{!"llvm.loop.unroll.runtime.disable"}
!32 = !DILocation(line: 14, column: 5, scope: !9)
!33 = distinct !DISubprogram(name: "main", scope: !10, file: !10, line: 16, type: !34, scopeLine: 16, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0, retainedNodes: !36)
!34 = !DISubroutineType(types: !35)
!35 = !{!13}
!36 = !{!37}
!37 = !DILocalVariable(name: "n", scope: !33, file: !10, line: 17, type: !13)
!38 = !DILocation(line: 17, column: 13, scope: !33)
!39 = !DILocation(line: 0, scope: !33)
!40 = !DILocation(line: 18, column: 15, scope: !41)
!41 = distinct !DILexicalBlock(scope: !33, file: !10, line: 18, column: 9)
!42 = !DILocation(line: 0, scope: !9, inlinedAt: !43)
!43 = distinct !DILocation(line: 19, column: 12, scope: !33)
!44 = !DILocation(line: 10, column: 14, scope: !9, inlinedAt: !43)
!45 = !DILocation(line: 10, column: 5, scope: !9, inlinedAt: !43)
!46 = !DILocation(line: 11, column: 15, scope: !22, inlinedAt: !43)
!47 = !DILocation(line: 19, column: 5, scope: !33)
!48 = !DILocation(line: 20, column: 5, scope: !33)
!49 = !DILocation(line: 21, column: 5, scope: !33)
!50 = !DILocation(line: 22, column: 1, scope: !33)
!51 = !DISubprogram(name: "getint", scope: !52, file: !52, line: 4, type: !34, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized, retainedNodes: !53)
!52 = !DIFile(filename: "lab1/runtime/sylib.h", directory: "/home/oliver/Compile_sys_work/BIG_project", checksumkind: CSK_MD5, checksum: "bd7cba7bbd7d4ac2c7ea08e7f5cfc0eb")
!53 = !{}
!54 = !DISubprogram(name: "putint", scope: !52, file: !52, line: 9, type: !55, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized, retainedNodes: !53)
!55 = !DISubroutineType(types: !56)
!56 = !{null, !13}
!57 = !DISubprogram(name: "putch", scope: !52, file: !52, line: 10, type: !55, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized, retainedNodes: !53)
