; ModuleID = '/home/oliver/Compile_sys_work/BIG_project/lab1/src/factorial.c'
source_filename = "/home/oliver/Compile_sys_work/BIG_project/lab1/src/factorial.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @factorial(i32 noundef %0) #0 !dbg !10 {
  %2 = alloca i32, align 4
  %3 = alloca i32, align 4
  %4 = alloca i32, align 4
  store i32 %0, i32* %2, align 4
  call void @llvm.dbg.declare(metadata i32* %2, metadata !16, metadata !DIExpression()), !dbg !17
  call void @llvm.dbg.declare(metadata i32* %3, metadata !18, metadata !DIExpression()), !dbg !19
  store i32 2, i32* %3, align 4, !dbg !19
  call void @llvm.dbg.declare(metadata i32* %4, metadata !20, metadata !DIExpression()), !dbg !21
  store i32 1, i32* %4, align 4, !dbg !21
  br label %5, !dbg !22

5:                                                ; preds = %9, %1
  %6 = load i32, i32* %3, align 4, !dbg !23
  %7 = load i32, i32* %2, align 4, !dbg !24
  %8 = icmp sle i32 %6, %7, !dbg !25
  br i1 %8, label %9, label %15, !dbg !22

9:                                                ; preds = %5
  %10 = load i32, i32* %4, align 4, !dbg !26
  %11 = load i32, i32* %3, align 4, !dbg !28
  %12 = mul nsw i32 %10, %11, !dbg !29
  store i32 %12, i32* %4, align 4, !dbg !30
  %13 = load i32, i32* %3, align 4, !dbg !31
  %14 = add nsw i32 %13, 1, !dbg !32
  store i32 %14, i32* %3, align 4, !dbg !33
  br label %5, !dbg !22, !llvm.loop !34

15:                                               ; preds = %5
  %16 = load i32, i32* %4, align 4, !dbg !37
  %17 = add nsw i32 %16, 0, !dbg !38
  ret i32 %17, !dbg !39
}

; Function Attrs: nofree nosync nounwind readnone speculatable willreturn
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @main() #0 !dbg !40 {
  %1 = alloca i32, align 4
  %2 = alloca i32, align 4
  store i32 0, i32* %1, align 4
  call void @llvm.dbg.declare(metadata i32* %2, metadata !43, metadata !DIExpression()), !dbg !44
  %3 = call i32 @getint(), !dbg !45
  store i32 %3, i32* %2, align 4, !dbg !44
  %4 = load i32, i32* %2, align 4, !dbg !46
  %5 = icmp slt i32 %4, 0, !dbg !48
  br i1 %5, label %9, label %6, !dbg !49

6:                                                ; preds = %0
  %7 = load i32, i32* %2, align 4, !dbg !50
  %8 = icmp sgt i32 %7, 12, !dbg !51
  br i1 %8, label %9, label %10, !dbg !52

9:                                                ; preds = %6, %0
  store i32 1, i32* %1, align 4, !dbg !53
  br label %13, !dbg !53

10:                                               ; preds = %6
  %11 = load i32, i32* %2, align 4, !dbg !54
  %12 = call i32 @factorial(i32 noundef %11), !dbg !55
  call void @putint(i32 noundef %12), !dbg !56
  call void @putch(i32 noundef 10), !dbg !57
  store i32 0, i32* %1, align 4, !dbg !58
  br label %13, !dbg !58

13:                                               ; preds = %10, %9
  %14 = load i32, i32* %1, align 4, !dbg !59
  ret i32 %14, !dbg !59
}

declare i32 @getint() #2

declare void @putint(i32 noundef) #2

declare void @putch(i32 noundef) #2

attributes #0 = { noinline nounwind optnone uwtable "frame-pointer"="all" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #1 = { nofree nosync nounwind readnone speculatable willreturn }
attributes #2 = { "frame-pointer"="all" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!2, !3, !4, !5, !6, !7, !8}
!llvm.ident = !{!9}

!0 = distinct !DICompileUnit(language: DW_LANG_C99, file: !1, producer: "Ubuntu clang version 14.0.0-1ubuntu1.1", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, splitDebugInlining: false, nameTableKind: None)
!1 = !DIFile(filename: "/home/oliver/Compile_sys_work/BIG_project/lab1/src/factorial.c", directory: "/home/oliver/Compile_sys_work/BIG_project", checksumkind: CSK_MD5, checksum: "cb911e1368787c587ec76de0781e3b32")
!2 = !{i32 7, !"Dwarf Version", i32 5}
!3 = !{i32 2, !"Debug Info Version", i32 3}
!4 = !{i32 1, !"wchar_size", i32 4}
!5 = !{i32 7, !"PIC Level", i32 2}
!6 = !{i32 7, !"PIE Level", i32 2}
!7 = !{i32 7, !"uwtable", i32 1}
!8 = !{i32 7, !"frame-pointer", i32 2}
!9 = !{!"Ubuntu clang version 14.0.0-1ubuntu1.1"}
!10 = distinct !DISubprogram(name: "factorial", scope: !11, file: !11, line: 7, type: !12, scopeLine: 7, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !15)
!11 = !DIFile(filename: "lab1/src/factorial.c", directory: "/home/oliver/Compile_sys_work/BIG_project", checksumkind: CSK_MD5, checksum: "cb911e1368787c587ec76de0781e3b32")
!12 = !DISubroutineType(types: !13)
!13 = !{!14, !14}
!14 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!15 = !{}
!16 = !DILocalVariable(name: "n", arg: 1, scope: !10, file: !11, line: 7, type: !14)
!17 = !DILocation(line: 7, column: 19, scope: !10)
!18 = !DILocalVariable(name: "i", scope: !10, file: !11, line: 8, type: !14)
!19 = !DILocation(line: 8, column: 9, scope: !10)
!20 = !DILocalVariable(name: "f", scope: !10, file: !11, line: 9, type: !14)
!21 = !DILocation(line: 9, column: 9, scope: !10)
!22 = !DILocation(line: 10, column: 5, scope: !10)
!23 = !DILocation(line: 10, column: 12, scope: !10)
!24 = !DILocation(line: 10, column: 17, scope: !10)
!25 = !DILocation(line: 10, column: 14, scope: !10)
!26 = !DILocation(line: 11, column: 13, scope: !27)
!27 = distinct !DILexicalBlock(scope: !10, file: !11, line: 10, column: 20)
!28 = !DILocation(line: 11, column: 17, scope: !27)
!29 = !DILocation(line: 11, column: 15, scope: !27)
!30 = !DILocation(line: 11, column: 11, scope: !27)
!31 = !DILocation(line: 12, column: 13, scope: !27)
!32 = !DILocation(line: 12, column: 15, scope: !27)
!33 = !DILocation(line: 12, column: 11, scope: !27)
!34 = distinct !{!34, !22, !35, !36}
!35 = !DILocation(line: 13, column: 5, scope: !10)
!36 = !{!"llvm.loop.mustprogress"}
!37 = !DILocation(line: 14, column: 12, scope: !10)
!38 = !DILocation(line: 14, column: 14, scope: !10)
!39 = !DILocation(line: 14, column: 5, scope: !10)
!40 = distinct !DISubprogram(name: "main", scope: !11, file: !11, line: 16, type: !41, scopeLine: 16, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !15)
!41 = !DISubroutineType(types: !42)
!42 = !{!14}
!43 = !DILocalVariable(name: "n", scope: !40, file: !11, line: 17, type: !14)
!44 = !DILocation(line: 17, column: 9, scope: !40)
!45 = !DILocation(line: 17, column: 13, scope: !40)
!46 = !DILocation(line: 18, column: 9, scope: !47)
!47 = distinct !DILexicalBlock(scope: !40, file: !11, line: 18, column: 9)
!48 = !DILocation(line: 18, column: 11, scope: !47)
!49 = !DILocation(line: 18, column: 15, scope: !47)
!50 = !DILocation(line: 18, column: 18, scope: !47)
!51 = !DILocation(line: 18, column: 20, scope: !47)
!52 = !DILocation(line: 18, column: 9, scope: !40)
!53 = !DILocation(line: 18, column: 26, scope: !47)
!54 = !DILocation(line: 19, column: 22, scope: !40)
!55 = !DILocation(line: 19, column: 12, scope: !40)
!56 = !DILocation(line: 19, column: 5, scope: !40)
!57 = !DILocation(line: 20, column: 5, scope: !40)
!58 = !DILocation(line: 21, column: 5, scope: !40)
!59 = !DILocation(line: 22, column: 1, scope: !40)
