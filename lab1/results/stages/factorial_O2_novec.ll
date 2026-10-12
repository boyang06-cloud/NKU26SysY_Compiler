; ModuleID = '/home/oliver/Compile_sys_work/BIG_project/lab1/src/factorial.c'
source_filename = "/home/oliver/Compile_sys_work/BIG_project/lab1/src/factorial.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

; Function Attrs: nofree norecurse nosync nounwind readnone uwtable
define dso_local i32 @factorial(i32 noundef %0) local_unnamed_addr #0 {
  %2 = icmp slt i32 %0, 2
  br i1 %2, label %45, label %3

3:                                                ; preds = %1
  %4 = add i32 %0, -1
  %5 = add i32 %0, -2
  %6 = and i32 %4, 7
  %7 = icmp ult i32 %5, 7
  br i1 %7, label %32, label %8

8:                                                ; preds = %3
  %9 = and i32 %4, -8
  br label %10

10:                                               ; preds = %10, %8
  %11 = phi i32 [ 1, %8 ], [ %28, %10 ]
  %12 = phi i32 [ 2, %8 ], [ %29, %10 ]
  %13 = phi i32 [ 0, %8 ], [ %30, %10 ]
  %14 = mul nsw i32 %11, %12
  %15 = or i32 %12, 1
  %16 = mul nsw i32 %14, %15
  %17 = add nuw nsw i32 %12, 2
  %18 = mul nsw i32 %16, %17
  %19 = add nuw nsw i32 %12, 3
  %20 = mul nsw i32 %18, %19
  %21 = add nuw nsw i32 %12, 4
  %22 = mul nsw i32 %20, %21
  %23 = add nuw nsw i32 %12, 5
  %24 = mul nsw i32 %22, %23
  %25 = add nuw i32 %12, 6
  %26 = mul nsw i32 %24, %25
  %27 = add nuw i32 %12, 7
  %28 = mul nsw i32 %26, %27
  %29 = add nuw i32 %12, 8
  %30 = add i32 %13, 8
  %31 = icmp eq i32 %30, %9
  br i1 %31, label %32, label %10, !llvm.loop !5

32:                                               ; preds = %10, %3
  %33 = phi i32 [ undef, %3 ], [ %28, %10 ]
  %34 = phi i32 [ 1, %3 ], [ %28, %10 ]
  %35 = phi i32 [ 2, %3 ], [ %29, %10 ]
  %36 = icmp eq i32 %6, 0
  br i1 %36, label %45, label %37

37:                                               ; preds = %32, %37
  %38 = phi i32 [ %41, %37 ], [ %34, %32 ]
  %39 = phi i32 [ %42, %37 ], [ %35, %32 ]
  %40 = phi i32 [ %43, %37 ], [ 0, %32 ]
  %41 = mul nsw i32 %38, %39
  %42 = add nuw i32 %39, 1
  %43 = add i32 %40, 1
  %44 = icmp eq i32 %43, %6
  br i1 %44, label %45, label %37, !llvm.loop !7

45:                                               ; preds = %32, %37, %1
  %46 = phi i32 [ 1, %1 ], [ %33, %32 ], [ %41, %37 ]
  ret i32 %46
}

; Function Attrs: nounwind uwtable
define dso_local i32 @main() local_unnamed_addr #1 {
  %1 = tail call i32 @getint() #3
  %2 = icmp ugt i32 %1, 12
  br i1 %2, label %49, label %3

3:                                                ; preds = %0
  %4 = icmp ult i32 %1, 2
  br i1 %4, label %47, label %5

5:                                                ; preds = %3
  %6 = add i32 %1, -1
  %7 = add i32 %1, -2
  %8 = and i32 %6, 7
  %9 = icmp ult i32 %7, 7
  br i1 %9, label %34, label %10

10:                                               ; preds = %5
  %11 = and i32 %6, -8
  br label %12

12:                                               ; preds = %12, %10
  %13 = phi i32 [ 1, %10 ], [ %30, %12 ]
  %14 = phi i32 [ 2, %10 ], [ %31, %12 ]
  %15 = phi i32 [ 0, %10 ], [ %32, %12 ]
  %16 = mul nsw i32 %14, %13
  %17 = or i32 %14, 1
  %18 = mul nsw i32 %17, %16
  %19 = add nuw nsw i32 %14, 2
  %20 = mul nsw i32 %19, %18
  %21 = add nuw nsw i32 %14, 3
  %22 = mul nsw i32 %21, %20
  %23 = add nuw nsw i32 %14, 4
  %24 = mul nsw i32 %23, %22
  %25 = add nuw nsw i32 %14, 5
  %26 = mul nsw i32 %25, %24
  %27 = add nuw nsw i32 %14, 6
  %28 = mul nsw i32 %27, %26
  %29 = add nuw nsw i32 %14, 7
  %30 = mul nsw i32 %29, %28
  %31 = add nuw nsw i32 %14, 8
  %32 = add i32 %15, 8
  %33 = icmp eq i32 %32, %11
  br i1 %33, label %34, label %12, !llvm.loop !5

34:                                               ; preds = %12, %5
  %35 = phi i32 [ undef, %5 ], [ %30, %12 ]
  %36 = phi i32 [ 1, %5 ], [ %30, %12 ]
  %37 = phi i32 [ 2, %5 ], [ %31, %12 ]
  %38 = icmp eq i32 %8, 0
  br i1 %38, label %47, label %39

39:                                               ; preds = %34, %39
  %40 = phi i32 [ %43, %39 ], [ %36, %34 ]
  %41 = phi i32 [ %44, %39 ], [ %37, %34 ]
  %42 = phi i32 [ %45, %39 ], [ 0, %34 ]
  %43 = mul nsw i32 %41, %40
  %44 = add nuw nsw i32 %41, 1
  %45 = add i32 %42, 1
  %46 = icmp eq i32 %45, %8
  br i1 %46, label %47, label %39, !llvm.loop !9

47:                                               ; preds = %34, %39, %3
  %48 = phi i32 [ 1, %3 ], [ %35, %34 ], [ %43, %39 ]
  tail call void @putint(i32 noundef %48) #3
  tail call void @putch(i32 noundef 10) #3
  br label %49

49:                                               ; preds = %0, %47
  %50 = phi i32 [ 0, %47 ], [ 1, %0 ]
  ret i32 %50
}

declare i32 @getint() local_unnamed_addr #2

declare void @putint(i32 noundef) local_unnamed_addr #2

declare void @putch(i32 noundef) local_unnamed_addr #2

attributes #0 = { nofree norecurse nosync nounwind readnone uwtable "frame-pointer"="none" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #1 = { nounwind uwtable "frame-pointer"="none" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #2 = { "frame-pointer"="none" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #3 = { nounwind }

!llvm.module.flags = !{!0, !1, !2, !3}
!llvm.ident = !{!4}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{i32 7, !"PIC Level", i32 2}
!2 = !{i32 7, !"PIE Level", i32 2}
!3 = !{i32 7, !"uwtable", i32 1}
!4 = !{!"Ubuntu clang version 14.0.0-1ubuntu1.1"}
!5 = distinct !{!5, !6}
!6 = !{!"llvm.loop.mustprogress"}
!7 = distinct !{!7, !8}
!8 = !{!"llvm.loop.unroll.disable"}
!9 = distinct !{!9, !8}
