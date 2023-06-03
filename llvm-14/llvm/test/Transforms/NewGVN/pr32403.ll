; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt -passes=newgvn -S < %s | FileCheck %s
target datalayout = "e-m:o-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-apple-macosx10.12.0"

; Function Attrs: nounwind ssp uwtable
define void @reorder_ref_pic_list() local_unnamed_addr {
; CHECK-LABEL: @reorder_ref_pic_list(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    br i1 undef, label [[FOR_END:%.*]], label [[FOR_BODY_PREHEADER:%.*]]
; CHECK:       for.body.preheader:
; CHECK-NEXT:    br label [[FOR_BODY:%.*]]
; CHECK:       for.body:
; CHECK-NEXT:    [[REFIDXLX_0:%.*]] = phi i32 [ [[INC_I51:%.*]], [[IF_ELSE58:%.*]] ], [ 0, [[FOR_BODY_PREHEADER]] ]
; CHECK-NEXT:    br i1 undef, label [[IF_THEN13:%.*]], label [[IF_ELSE58]]
; CHECK:       if.then13:
; CHECK-NEXT:    [[INC_I:%.*]] = add nsw i32 [[REFIDXLX_0]], 1
; CHECK-NEXT:    br label [[FOR_BODY8_I:%.*]]
; CHECK:       for.body8.i:
; CHECK-NEXT:    br i1 undef, label [[FOR_INC24_I:%.*]], label [[IF_THEN17_I:%.*]]
; CHECK:       if.then17.i:
; CHECK-NEXT:    br label [[FOR_INC24_I]]
; CHECK:       for.inc24.i:
; CHECK-NEXT:    br label [[FOR_BODY8_I]]
; CHECK:       if.else58:
; CHECK-NEXT:    [[INC_I51]] = add nsw i32 [[REFIDXLX_0]], 1
; CHECK-NEXT:    br label [[FOR_BODY]]
; CHECK:       for.end:
; CHECK-NEXT:    ret void
;
entry:
  br i1 undef, label %for.end, label %for.body.preheader

for.body.preheader:                               ; preds = %entry
  br label %for.body

for.body:                                         ; preds = %if.else58, %for.body.preheader
  %refIdxLX.0 = phi i32 [ %inc.i51, %if.else58 ], [ 0, %for.body.preheader ]
  br i1 undef, label %if.then13, label %if.else58

if.then13:                                        ; preds = %for.body
  %inc.i = add nsw i32 %refIdxLX.0, 1
  br label %for.body8.i

for.body8.i:                                      ; preds = %for.inc24.i, %if.then13
  %nIdx.052.i = phi i32 [ %inc.i, %if.then13 ], [ %nIdx.1.i, %for.inc24.i ]
  br i1 undef, label %for.inc24.i, label %if.then17.i

if.then17.i:                                      ; preds = %for.body8.i
  br label %for.inc24.i

for.inc24.i:                                      ; preds = %if.then17.i, %for.body8.i
  %nIdx.1.i = phi i32 [ poison, %if.then17.i ], [ %nIdx.052.i, %for.body8.i ]
  br label %for.body8.i

if.else58:                                        ; preds = %for.body
  %inc.i51 = add nsw i32 %refIdxLX.0, 1
  br label %for.body

for.end:                                          ; preds = %entry
  ret void
}



