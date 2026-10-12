; ModuleID = '/home/oliver/Compile_sys_work/BIG_project/lab1/src/factorial.c'
source_filename = "/home/oliver/Compile_sys_work/BIG_project/lab1/src/factorial.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

; Function Attrs: nofree norecurse nosync nounwind readnone uwtable
define dso_local i32 @factorial(i32 noundef %0) local_unnamed_addr #0 {
  %2 = icmp slt i32 %0, 2
  br i1 %2, label %72, label %3

3:                                                ; preds = %1
  %4 = add i32 %0, -1
  %5 = icmp ult i32 %4, 8
  br i1 %5, label %63, label %6

6:                                                ; preds = %3
  %7 = and i32 %4, -8
  %8 = or i32 %7, 2
  %9 = add i32 %7, -8
  %10 = lshr exact i32 %9, 3
  %11 = add nuw nsw i32 %10, 1
  %12 = and i32 %11, 3
  %13 = icmp ult i32 %9, 24
  br i1 %13, label %39, label %14

14:                                               ; preds = %6
  %15 = and i32 %11, 1073741820
  br label %16

16:                                               ; preds = %16, %14
  %17 = phi <4 x i32> [ <i32 1, i32 1, i32 1, i32 1>, %14 ], [ %34, %16 ]
  %18 = phi <4 x i32> [ <i32 1, i32 1, i32 1, i32 1>, %14 ], [ %35, %16 ]
  %19 = phi <4 x i32> [ <i32 2, i32 3, i32 4, i32 5>, %14 ], [ %36, %16 ]
  %20 = phi i32 [ 0, %14 ], [ %37, %16 ]
  %21 = add <4 x i32> %19, <i32 4, i32 4, i32 4, i32 4>
  %22 = mul <4 x i32> %17, %19
  %23 = mul <4 x i32> %18, %21
  %24 = add <4 x i32> %19, <i32 8, i32 8, i32 8, i32 8>
  %25 = add <4 x i32> %19, <i32 12, i32 12, i32 12, i32 12>
  %26 = mul <4 x i32> %22, %24
  %27 = mul <4 x i32> %23, %25
  %28 = add <4 x i32> %19, <i32 16, i32 16, i32 16, i32 16>
  %29 = add <4 x i32> %19, <i32 20, i32 20, i32 20, i32 20>
  %30 = mul <4 x i32> %26, %28
  %31 = mul <4 x i32> %27, %29
  %32 = add <4 x i32> %19, <i32 24, i32 24, i32 24, i32 24>
  %33 = add <4 x i32> %19, <i32 28, i32 28, i32 28, i32 28>
  %34 = mul <4 x i32> %30, %32
  %35 = mul <4 x i32> %31, %33
  %36 = add <4 x i32> %19, <i32 32, i32 32, i32 32, i32 32>
  %37 = add i32 %20, 4
  %38 = icmp eq i32 %37, %15
  br i1 %38, label %39, label %16, !llvm.loop !5

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
  %52 = mul <4 x i32> %47, %49
  %53 = mul <4 x i32> %48, %51
  %54 = add <4 x i32> %49, <i32 8, i32 8, i32 8, i32 8>
  %55 = add i32 %50, 1
  %56 = icmp eq i32 %55, %12
  br i1 %56, label %57, label %46, !llvm.loop !8

57:                                               ; preds = %46, %39
  %58 = phi <4 x i32> [ %40, %39 ], [ %52, %46 ]
  %59 = phi <4 x i32> [ %41, %39 ], [ %53, %46 ]
  %60 = mul <4 x i32> %59, %58
  %61 = call i32 @llvm.vector.reduce.mul.v4i32(<4 x i32> %60)
  %62 = icmp eq i32 %4, %7
  br i1 %62, label %72, label %63

63:                                               ; preds = %3, %57
  %64 = phi i32 [ 1, %3 ], [ %61, %57 ]
  %65 = phi i32 [ 2, %3 ], [ %8, %57 ]
  br label %66

66:                                               ; preds = %63, %66
  %67 = phi i32 [ %69, %66 ], [ %64, %63 ]
  %68 = phi i32 [ %70, %66 ], [ %65, %63 ]
  %69 = mul nsw i32 %67, %68
  %70 = add nuw i32 %68, 1
  %71 = icmp eq i32 %68, %0
  br i1 %71, label %72, label %66, !llvm.loop !10

72:                                               ; preds = %66, %57, %1
  %73 = phi i32 [ 1, %1 ], [ %61, %57 ], [ %69, %66 ]
  ret i32 %73
}

; Function Attrs: nounwind uwtable
define dso_local i32 @main() local_unnamed_addr #1 {
  %1 = tail call i32 @getint() #4
  %2 = icmp ugt i32 %1, 12
  br i1 %2, label %25, label %3

3:                                                ; preds = %0
  %4 = icmp ult i32 %1, 2
  br i1 %4, label %23, label %5

5:                                                ; preds = %3
  %6 = add i32 %1, 2
  %7 = and i32 %6, -4
  %8 = add i32 %1, -2
  %9 = insertelement <4 x i32> poison, i32 %8, i64 0
  %10 = shufflevector <4 x i32> %9, <4 x i32> poison, <4 x i32> zeroinitializer
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
  %16 = phi <4 x i32> [ <i32 2, i32 3, i32 4, i32 5>, %5 ], [ <i32 120, i32 231, i32 384, i32 585>, %11 ], [ <i32 12, i32 21, i32 32, i32 45>, %12 ]
  %17 = insertelement <4 x i32> poison, i32 %14, i64 0
  %18 = shufflevector <4 x i32> %17, <4 x i32> poison, <4 x i32> zeroinitializer
  %19 = or <4 x i32> %18, <i32 0, i32 1, i32 2, i32 3>
  %20 = icmp ugt <4 x i32> %19, %10
  %21 = select <4 x i1> %20, <4 x i32> %15, <4 x i32> %16
  %22 = call i32 @llvm.vector.reduce.mul.v4i32(<4 x i32> %21)
  br label %23

23:                                               ; preds = %13, %3
  %24 = phi i32 [ 1, %3 ], [ %22, %13 ]
  tail call void @putint(i32 noundef %24) #4
  tail call void @putch(i32 noundef 10) #4
  br label %25

25:                                               ; preds = %0, %23
  %26 = phi i32 [ 0, %23 ], [ 1, %0 ]
  ret i32 %26
}

declare i32 @getint() local_unnamed_addr #2

declare void @putint(i32 noundef) local_unnamed_addr #2

declare void @putch(i32 noundef) local_unnamed_addr #2

; Function Attrs: nofree nosync nounwind readnone willreturn
declare i32 @llvm.vector.reduce.mul.v4i32(<4 x i32>) #3

attributes #0 = { nofree norecurse nosync nounwind readnone uwtable "frame-pointer"="none" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #1 = { nounwind uwtable "frame-pointer"="none" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #2 = { "frame-pointer"="none" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #3 = { nofree nosync nounwind readnone willreturn }
attributes #4 = { nounwind }

!llvm.module.flags = !{!0, !1, !2, !3}
!llvm.ident = !{!4}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{i32 7, !"PIC Level", i32 2}
!2 = !{i32 7, !"PIE Level", i32 2}
!3 = !{i32 7, !"uwtable", i32 1}
!4 = !{!"Ubuntu clang version 14.0.0-1ubuntu1.1"}
!5 = distinct !{!5, !6, !7}
!6 = !{!"llvm.loop.mustprogress"}
!7 = !{!"llvm.loop.isvectorized", i32 1}
!8 = distinct !{!8, !9}
!9 = !{!"llvm.loop.unroll.disable"}
!10 = distinct !{!10, !6, !11, !7}
!11 = !{!"llvm.loop.unroll.runtime.disable"}
