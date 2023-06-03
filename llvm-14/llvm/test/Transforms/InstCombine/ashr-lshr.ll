; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt < %s -instcombine -S | FileCheck %s

define i32 @ashr_lshr_exact_ashr_only(i32 %x, i32 %y) {
; CHECK-LABEL: @ashr_lshr_exact_ashr_only(
; CHECK-NEXT:    [[CMP12:%.*]] = ashr i32 [[X:%.*]], [[Y:%.*]]
; CHECK-NEXT:    ret i32 [[CMP12]]
;
  %cmp = icmp sgt i32 %x, -1
  %l = lshr i32 %x, %y
  %r = ashr exact i32 %x, %y
  %ret = select i1 %cmp, i32 %l, i32 %r
  ret i32 %ret
}

define i32 @ashr_lshr_no_exact(i32 %x, i32 %y) {
; CHECK-LABEL: @ashr_lshr_no_exact(
; CHECK-NEXT:    [[CMP12:%.*]] = ashr i32 [[X:%.*]], [[Y:%.*]]
; CHECK-NEXT:    ret i32 [[CMP12]]
;
  %cmp = icmp sgt i32 %x, -1
  %l = lshr i32 %x, %y
  %r = ashr i32 %x, %y
  %ret = select i1 %cmp, i32 %l, i32 %r
  ret i32 %ret
}

define i32 @ashr_lshr_exact_both(i32 %x, i32 %y) {
; CHECK-LABEL: @ashr_lshr_exact_both(
; CHECK-NEXT:    [[CMP12:%.*]] = ashr exact i32 [[X:%.*]], [[Y:%.*]]
; CHECK-NEXT:    ret i32 [[CMP12]]
;
  %cmp = icmp sgt i32 %x, -1
  %l = lshr exact i32 %x, %y
  %r = ashr exact i32 %x, %y
  %ret = select i1 %cmp, i32 %l, i32 %r
  ret i32 %ret
}

define i32 @ashr_lshr_exact_lshr_only(i32 %x, i32 %y) {
; CHECK-LABEL: @ashr_lshr_exact_lshr_only(
; CHECK-NEXT:    [[CMP12:%.*]] = ashr i32 [[X:%.*]], [[Y:%.*]]
; CHECK-NEXT:    ret i32 [[CMP12]]
;
  %cmp = icmp sgt i32 %x, -1
  %l = lshr exact i32 %x, %y
  %r = ashr i32 %x, %y
  %ret = select i1 %cmp, i32 %l, i32 %r
  ret i32 %ret
}

define i32 @ashr_lshr2(i32 %x, i32 %y) {
; CHECK-LABEL: @ashr_lshr2(
; CHECK-NEXT:    [[CMP1:%.*]] = ashr i32 [[X:%.*]], [[Y:%.*]]
; CHECK-NEXT:    ret i32 [[CMP1]]
;
  %cmp = icmp sgt i32 %x, 5
  %l = lshr i32 %x, %y
  %r = ashr exact i32 %x, %y
  %ret = select i1 %cmp, i32 %l, i32 %r
  ret i32 %ret
}

define <2 x i32> @ashr_lshr_splat_vec(<2 x i32> %x, <2 x i32> %y) {
; CHECK-LABEL: @ashr_lshr_splat_vec(
; CHECK-NEXT:    [[CMP12:%.*]] = ashr <2 x i32> [[X:%.*]], [[Y:%.*]]
; CHECK-NEXT:    ret <2 x i32> [[CMP12]]
;
  %cmp = icmp sgt <2 x i32> %x, <i32 -1, i32 -1>
  %l = lshr <2 x i32> %x, %y
  %r = ashr <2 x i32> %x, %y
  %ret = select <2 x i1> %cmp, <2 x i32> %l, <2 x i32> %r
  ret <2 x i32> %ret
}

define <2 x i32> @ashr_lshr_splat_vec2(<2 x i32> %x, <2 x i32> %y) {
; CHECK-LABEL: @ashr_lshr_splat_vec2(
; CHECK-NEXT:    [[CMP12:%.*]] = ashr exact <2 x i32> [[X:%.*]], [[Y:%.*]]
; CHECK-NEXT:    ret <2 x i32> [[CMP12]]
;
  %cmp = icmp sgt <2 x i32> %x, <i32 -1, i32 -1>
  %l = lshr exact <2 x i32> %x, %y
  %r = ashr exact <2 x i32> %x, %y
  %ret = select <2 x i1> %cmp, <2 x i32> %l, <2 x i32> %r
  ret <2 x i32> %ret
}

define <2 x i32> @ashr_lshr_splat_vec3(<2 x i32> %x, <2 x i32> %y) {
; CHECK-LABEL: @ashr_lshr_splat_vec3(
; CHECK-NEXT:    [[CMP12:%.*]] = ashr <2 x i32> [[X:%.*]], [[Y:%.*]]
; CHECK-NEXT:    ret <2 x i32> [[CMP12]]
;
  %cmp = icmp sgt <2 x i32> %x, <i32 -1, i32 -1>
  %l = lshr exact <2 x i32> %x, %y
  %r = ashr <2 x i32> %x, %y
  %ret = select <2 x i1> %cmp, <2 x i32> %l, <2 x i32> %r
  ret <2 x i32> %ret
}

define <2 x i32> @ashr_lshr_splat_vec4(<2 x i32> %x, <2 x i32> %y) {
; CHECK-LABEL: @ashr_lshr_splat_vec4(
; CHECK-NEXT:    [[CMP12:%.*]] = ashr <2 x i32> [[X:%.*]], [[Y:%.*]]
; CHECK-NEXT:    ret <2 x i32> [[CMP12]]
;
  %cmp = icmp sgt <2 x i32> %x, <i32 -1, i32 -1>
  %l = lshr <2 x i32> %x, %y
  %r = ashr exact <2 x i32> %x, %y
  %ret = select <2 x i1> %cmp, <2 x i32> %l, <2 x i32> %r
  ret <2 x i32> %ret
}

define <2 x i32> @ashr_lshr_nonsplat_vec(<2 x i32> %x, <2 x i32> %y) {
; CHECK-LABEL: @ashr_lshr_nonsplat_vec(
; CHECK-NEXT:    [[CMP1:%.*]] = ashr <2 x i32> [[X:%.*]], [[Y:%.*]]
; CHECK-NEXT:    ret <2 x i32> [[CMP1]]
;
  %cmp = icmp sgt <2 x i32> %x, <i32 -1, i32 1>
  %l = lshr <2 x i32> %x, %y
  %r = ashr <2 x i32> %x, %y
  %ret = select <2 x i1> %cmp, <2 x i32> %l, <2 x i32> %r
  ret <2 x i32> %ret
}

define <2 x i32> @ashr_lshr_nonsplat_vec2(<2 x i32> %x, <2 x i32> %y) {
; CHECK-LABEL: @ashr_lshr_nonsplat_vec2(
; CHECK-NEXT:    [[CMP1:%.*]] = ashr exact <2 x i32> [[X:%.*]], [[Y:%.*]]
; CHECK-NEXT:    ret <2 x i32> [[CMP1]]
;
  %cmp = icmp sgt <2 x i32> %x, <i32 2, i32 4>
  %l = lshr exact <2 x i32> %x, %y
  %r = ashr exact <2 x i32> %x, %y
  %ret = select <2 x i1> %cmp, <2 x i32> %l, <2 x i32> %r
  ret <2 x i32> %ret
}

define <2 x i32> @ashr_lshr_nonsplat_vec3(<2 x i32> %x, <2 x i32> %y) {
; CHECK-LABEL: @ashr_lshr_nonsplat_vec3(
; CHECK-NEXT:    [[CMP1:%.*]] = ashr <2 x i32> [[X:%.*]], [[Y:%.*]]
; CHECK-NEXT:    ret <2 x i32> [[CMP1]]
;
  %cmp = icmp sgt <2 x i32> %x, <i32 5, i32 6>
  %l = lshr exact <2 x i32> %x, %y
  %r = ashr <2 x i32> %x, %y
  %ret = select <2 x i1> %cmp, <2 x i32> %l, <2 x i32> %r
  ret <2 x i32> %ret
}

define <2 x i32> @ashr_lshr_nonsplat_vec4(<2 x i32> %x, <2 x i32> %y) {
; CHECK-LABEL: @ashr_lshr_nonsplat_vec4(
; CHECK-NEXT:    [[CMP1:%.*]] = ashr <2 x i32> [[X:%.*]], [[Y:%.*]]
; CHECK-NEXT:    ret <2 x i32> [[CMP1]]
;
  %cmp = icmp sgt <2 x i32> %x, <i32 8, i32 7>
  %l = lshr <2 x i32> %x, %y
  %r = ashr exact <2 x i32> %x, %y
  %ret = select <2 x i1> %cmp, <2 x i32> %l, <2 x i32> %r
  ret <2 x i32> %ret
}

define i32 @ashr_lshr_cst(i32 %x, i32 %y) {
; CHECK-LABEL: @ashr_lshr_cst(
; CHECK-NEXT:    [[CMP1:%.*]] = ashr i32 [[X:%.*]], 8
; CHECK-NEXT:    ret i32 [[CMP1]]
;
  %cmp = icmp slt i32 %x, 1
  %l = lshr i32 %x, 8
  %r = ashr exact i32 %x, 8
  %ret = select i1 %cmp, i32 %r, i32 %l
  ret i32 %ret
}

define i32 @ashr_lshr_cst2(i32 %x, i32 %y) {
; CHECK-LABEL: @ashr_lshr_cst2(
; CHECK-NEXT:    [[CMP12:%.*]] = ashr i32 [[X:%.*]], 8
; CHECK-NEXT:    ret i32 [[CMP12]]
;
  %cmp = icmp sgt i32 %x, -1
  %l = lshr i32 %x, 8
  %r = ashr exact i32 %x, 8
  %ret = select i1 %cmp, i32 %l, i32 %r
  ret i32 %ret
}

define i32 @ashr_lshr_inv(i32 %x, i32 %y) {
; CHECK-LABEL: @ashr_lshr_inv(
; CHECK-NEXT:    [[CMP1:%.*]] = ashr i32 [[X:%.*]], [[Y:%.*]]
; CHECK-NEXT:    ret i32 [[CMP1]]
;
  %cmp = icmp slt i32 %x, 1
  %l = lshr i32 %x, %y
  %r = ashr exact i32 %x, %y
  %ret = select i1 %cmp, i32 %r, i32 %l
  ret i32 %ret
}

define i32 @ashr_lshr_inv2(i32 %x, i32 %y) {
; CHECK-LABEL: @ashr_lshr_inv2(
; CHECK-NEXT:    [[CMP1:%.*]] = ashr i32 [[X:%.*]], [[Y:%.*]]
; CHECK-NEXT:    ret i32 [[CMP1]]
;
  %cmp = icmp slt i32 %x, 7
  %l = lshr i32 %x, %y
  %r = ashr exact i32 %x, %y
  %ret = select i1 %cmp, i32 %r, i32 %l
  ret i32 %ret
}

define <2 x i32> @ashr_lshr_inv_splat_vec(<2 x i32> %x, <2 x i32> %y) {
; CHECK-LABEL: @ashr_lshr_inv_splat_vec(
; CHECK-NEXT:    [[CMP1:%.*]] = ashr <2 x i32> [[X:%.*]], [[Y:%.*]]
; CHECK-NEXT:    ret <2 x i32> [[CMP1]]
;
  %cmp = icmp slt <2 x i32> %x, <i32 1, i32 1>
  %l = lshr <2 x i32> %x, %y
  %r = ashr exact <2 x i32> %x, %y
  %ret = select <2 x i1> %cmp, <2 x i32> %r, <2 x i32> %l
  ret <2 x i32> %ret
}

define <2 x i32> @ashr_lshr_inv_nonsplat_vec(<2 x i32> %x, <2 x i32> %y) {
; CHECK-LABEL: @ashr_lshr_inv_nonsplat_vec(
; CHECK-NEXT:    [[CMP1:%.*]] = ashr <2 x i32> [[X:%.*]], [[Y:%.*]]
; CHECK-NEXT:    ret <2 x i32> [[CMP1]]
;
  %cmp = icmp slt <2 x i32> %x, <i32 4, i32 5>
  %l = lshr <2 x i32> %x, %y
  %r = ashr exact <2 x i32> %x, %y
  %ret = select <2 x i1> %cmp, <2 x i32> %r, <2 x i32> %l
  ret <2 x i32> %ret
}

define <2 x i32> @ashr_lshr_vec_undef(<2 x i32> %x, <2 x i32> %y) {
; CHECK-LABEL: @ashr_lshr_vec_undef(
; CHECK-NEXT:    [[CMP12:%.*]] = ashr <2 x i32> [[X:%.*]], [[Y:%.*]]
; CHECK-NEXT:    ret <2 x i32> [[CMP12]]
;
  %cmp = icmp sgt <2 x i32> %x, <i32 undef, i32 -1>
  %l = lshr <2 x i32> %x, %y
  %r = ashr exact <2 x i32> %x, %y
  %ret = select <2 x i1> %cmp, <2 x i32> %l, <2 x i32> %r
  ret <2 x i32> %ret
}

define <2 x i32> @ashr_lshr_vec_undef2(<2 x i32> %x, <2 x i32> %y) {
; CHECK-LABEL: @ashr_lshr_vec_undef2(
; CHECK-NEXT:    [[CMP1:%.*]] = ashr exact <2 x i32> [[X:%.*]], [[Y:%.*]]
; CHECK-NEXT:    ret <2 x i32> [[CMP1]]
;
  %cmp = icmp slt <2 x i32> %x, <i32 1, i32 undef>
  %l = lshr exact <2 x i32> %x, %y
  %r = ashr exact <2 x i32> %x, %y
  %ret = select <2 x i1> %cmp, <2 x i32> %r, <2 x i32> %l
  ret <2 x i32> %ret
}

; Negative tests

define i32 @ashr_lshr_wrong_cst(i32 %x, i32 %y) {
; CHECK-LABEL: @ashr_lshr_wrong_cst(
; CHECK-NEXT:    [[CMP:%.*]] = icmp sgt i32 [[X:%.*]], -2
; CHECK-NEXT:    [[L:%.*]] = lshr i32 [[X]], [[Y:%.*]]
; CHECK-NEXT:    [[R:%.*]] = ashr exact i32 [[X]], [[Y]]
; CHECK-NEXT:    [[RET:%.*]] = select i1 [[CMP]], i32 [[L]], i32 [[R]]
; CHECK-NEXT:    ret i32 [[RET]]
;
  %cmp = icmp sgt i32 %x, -2
  %l = lshr i32 %x, %y
  %r = ashr exact i32 %x, %y
  %ret = select i1 %cmp, i32 %l, i32 %r
  ret i32 %ret
}

define i32 @ashr_lshr_wrong_cst2(i32 %x, i32 %y) {
; CHECK-LABEL: @ashr_lshr_wrong_cst2(
; CHECK-NEXT:    [[CMP:%.*]] = icmp slt i32 [[X:%.*]], -1
; CHECK-NEXT:    [[L:%.*]] = lshr i32 [[X]], [[Y:%.*]]
; CHECK-NEXT:    [[R:%.*]] = ashr exact i32 [[X]], [[Y]]
; CHECK-NEXT:    [[RET:%.*]] = select i1 [[CMP]], i32 [[R]], i32 [[L]]
; CHECK-NEXT:    ret i32 [[RET]]
;
  %cmp = icmp slt i32 %x, -1
  %l = lshr i32 %x, %y
  %r = ashr exact i32 %x, %y
  %ret = select i1 %cmp, i32 %r, i32 %l
  ret i32 %ret
}

define i32 @ashr_lshr_wrong_cond(i32 %x, i32 %y) {
; CHECK-LABEL: @ashr_lshr_wrong_cond(
; CHECK-NEXT:    [[CMP:%.*]] = icmp sgt i32 [[X:%.*]], -2
; CHECK-NEXT:    [[L:%.*]] = lshr i32 [[X]], [[Y:%.*]]
; CHECK-NEXT:    [[R:%.*]] = ashr i32 [[X]], [[Y]]
; CHECK-NEXT:    [[RET:%.*]] = select i1 [[CMP]], i32 [[L]], i32 [[R]]
; CHECK-NEXT:    ret i32 [[RET]]
;
  %cmp = icmp sge i32 %x, -1
  %l = lshr i32 %x, %y
  %r = ashr i32 %x, %y
  %ret = select i1 %cmp, i32 %l, i32 %r
  ret i32 %ret
}

define i32 @ashr_lshr_shift_wrong_pred(i32 %x, i32 %y, i32 %z) {
; CHECK-LABEL: @ashr_lshr_shift_wrong_pred(
; CHECK-NEXT:    [[CMP:%.*]] = icmp slt i32 [[X:%.*]], 1
; CHECK-NEXT:    [[L:%.*]] = lshr i32 [[X]], [[Y:%.*]]
; CHECK-NEXT:    [[R:%.*]] = ashr i32 [[X]], [[Y]]
; CHECK-NEXT:    [[RET:%.*]] = select i1 [[CMP]], i32 [[L]], i32 [[R]]
; CHECK-NEXT:    ret i32 [[RET]]
;
  %cmp = icmp sle i32 %x, 0
  %l = lshr i32 %x, %y
  %r = ashr i32 %x, %y
  %ret = select i1 %cmp, i32 %l, i32 %r
  ret i32 %ret
}

define i32 @ashr_lshr_shift_wrong_pred2(i32 %x, i32 %y, i32 %z) {
; CHECK-LABEL: @ashr_lshr_shift_wrong_pred2(
; CHECK-NEXT:    [[L:%.*]] = lshr i32 [[X:%.*]], [[Y:%.*]]
; CHECK-NEXT:    [[R:%.*]] = ashr i32 [[X]], [[Y]]
; CHECK-NEXT:    [[CMP1:%.*]] = icmp slt i32 [[Z:%.*]], 0
; CHECK-NEXT:    [[RET:%.*]] = select i1 [[CMP1]], i32 [[R]], i32 [[L]]
; CHECK-NEXT:    ret i32 [[RET]]
;
  %cmp = icmp sge i32 %z, 0
  %l = lshr i32 %x, %y
  %r = ashr i32 %x, %y
  %ret = select i1 %cmp, i32 %l, i32 %r
  ret i32 %ret
}

define i32 @ashr_lshr_wrong_operands(i32 %x, i32 %y) {
; CHECK-LABEL: @ashr_lshr_wrong_operands(
; CHECK-NEXT:    [[L:%.*]] = lshr i32 [[X:%.*]], [[Y:%.*]]
; CHECK-NEXT:    [[R:%.*]] = ashr i32 [[X]], [[Y]]
; CHECK-NEXT:    [[CMP1:%.*]] = icmp slt i32 [[X]], 0
; CHECK-NEXT:    [[RET:%.*]] = select i1 [[CMP1]], i32 [[L]], i32 [[R]]
; CHECK-NEXT:    ret i32 [[RET]]
;
  %cmp = icmp sge i32 %x, 0
  %l = lshr i32 %x, %y
  %r = ashr i32 %x, %y
  %ret = select i1 %cmp, i32 %r, i32 %l
  ret i32 %ret
}

define i32 @ashr_lshr_no_ashr(i32 %x, i32 %y) {
; CHECK-LABEL: @ashr_lshr_no_ashr(
; CHECK-NEXT:    [[L:%.*]] = lshr i32 [[X:%.*]], [[Y:%.*]]
; CHECK-NEXT:    [[R:%.*]] = xor i32 [[X]], [[Y]]
; CHECK-NEXT:    [[CMP1:%.*]] = icmp slt i32 [[X]], 0
; CHECK-NEXT:    [[RET:%.*]] = select i1 [[CMP1]], i32 [[R]], i32 [[L]]
; CHECK-NEXT:    ret i32 [[RET]]
;
  %cmp = icmp sge i32 %x, 0
  %l = lshr i32 %x, %y
  %r = xor i32 %x, %y
  %ret = select i1 %cmp, i32 %l, i32 %r
  ret i32 %ret
}

define i32 @ashr_lshr_shift_amt_mismatch(i32 %x, i32 %y, i32 %z) {
; CHECK-LABEL: @ashr_lshr_shift_amt_mismatch(
; CHECK-NEXT:    [[L:%.*]] = lshr i32 [[X:%.*]], [[Y:%.*]]
; CHECK-NEXT:    [[R:%.*]] = ashr i32 [[X]], [[Z:%.*]]
; CHECK-NEXT:    [[CMP1:%.*]] = icmp slt i32 [[X]], 0
; CHECK-NEXT:    [[RET:%.*]] = select i1 [[CMP1]], i32 [[R]], i32 [[L]]
; CHECK-NEXT:    ret i32 [[RET]]
;
  %cmp = icmp sge i32 %x, 0
  %l = lshr i32 %x, %y
  %r = ashr i32 %x, %z
  %ret = select i1 %cmp, i32 %l, i32 %r
  ret i32 %ret
}

define i32 @ashr_lshr_shift_base_mismatch(i32 %x, i32 %y, i32 %z) {
; CHECK-LABEL: @ashr_lshr_shift_base_mismatch(
; CHECK-NEXT:    [[L:%.*]] = lshr i32 [[X:%.*]], [[Y:%.*]]
; CHECK-NEXT:    [[R:%.*]] = ashr i32 [[Z:%.*]], [[Y]]
; CHECK-NEXT:    [[CMP1:%.*]] = icmp slt i32 [[X]], 0
; CHECK-NEXT:    [[RET:%.*]] = select i1 [[CMP1]], i32 [[R]], i32 [[L]]
; CHECK-NEXT:    ret i32 [[RET]]
;
  %cmp = icmp sge i32 %x, 0
  %l = lshr i32 %x, %y
  %r = ashr i32 %z, %y
  %ret = select i1 %cmp, i32 %l, i32 %r
  ret i32 %ret
}

define i32 @ashr_lshr_no_lshr(i32 %x, i32 %y) {
; CHECK-LABEL: @ashr_lshr_no_lshr(
; CHECK-NEXT:    [[L:%.*]] = add i32 [[X:%.*]], [[Y:%.*]]
; CHECK-NEXT:    [[R:%.*]] = ashr i32 [[X]], [[Y]]
; CHECK-NEXT:    [[CMP1:%.*]] = icmp slt i32 [[X]], 0
; CHECK-NEXT:    [[RET:%.*]] = select i1 [[CMP1]], i32 [[R]], i32 [[L]]
; CHECK-NEXT:    ret i32 [[RET]]
;
  %cmp = icmp sge i32 %x, 0
  %l = add i32 %x, %y
  %r = ashr i32 %x, %y
  %ret = select i1 %cmp, i32 %l, i32 %r
  ret i32 %ret
}

define <2 x i32> @ashr_lshr_vec_wrong_pred(<2 x i32> %x, <2 x i32> %y) {
; CHECK-LABEL: @ashr_lshr_vec_wrong_pred(
; CHECK-NEXT:    [[CMP:%.*]] = icmp slt <2 x i32> [[X:%.*]], <i32 1, i32 1>
; CHECK-NEXT:    [[L:%.*]] = lshr <2 x i32> [[X]], [[Y:%.*]]
; CHECK-NEXT:    [[R:%.*]] = ashr <2 x i32> [[X]], [[Y]]
; CHECK-NEXT:    [[RET:%.*]] = select <2 x i1> [[CMP]], <2 x i32> [[L]], <2 x i32> [[R]]
; CHECK-NEXT:    ret <2 x i32> [[RET]]
;
  %cmp = icmp sle <2 x i32> %x, zeroinitializer
  %l = lshr <2 x i32> %x, %y
  %r = ashr <2 x i32> %x, %y
  %ret = select <2 x i1> %cmp, <2 x i32> %l, <2 x i32> %r
  ret <2 x i32> %ret
}

define <2 x i32> @ashr_lshr_inv_vec_wrong_pred(<2 x i32> %x, <2 x i32> %y) {
; CHECK-LABEL: @ashr_lshr_inv_vec_wrong_pred(
; CHECK-NEXT:    [[L:%.*]] = lshr <2 x i32> [[X:%.*]], [[Y:%.*]]
; CHECK-NEXT:    [[R:%.*]] = ashr <2 x i32> [[X]], [[Y]]
; CHECK-NEXT:    [[CMP1:%.*]] = icmp slt <2 x i32> [[X]], zeroinitializer
; CHECK-NEXT:    [[RET:%.*]] = select <2 x i1> [[CMP1]], <2 x i32> [[L]], <2 x i32> [[R]]
; CHECK-NEXT:    ret <2 x i32> [[RET]]
;
  %cmp = icmp sge <2 x i32> %x, zeroinitializer
  %l = lshr <2 x i32> %x, %y
  %r = ashr <2 x i32> %x, %y
  %ret = select <2 x i1> %cmp, <2 x i32> %r, <2 x i32> %l
  ret <2 x i32> %ret
}

define i32 @lshr_sub_nsw(i32 %x, i32 %y) {
; CHECK-LABEL: @lshr_sub_nsw(
; CHECK-NEXT:    [[TMP1:%.*]] = icmp slt i32 [[X:%.*]], [[Y:%.*]]
; CHECK-NEXT:    [[SHR:%.*]] = zext i1 [[TMP1]] to i32
; CHECK-NEXT:    ret i32 [[SHR]]
;
  %sub = sub nsw i32 %x, %y
  %shr = lshr i32 %sub, 31
  ret i32 %shr
}

; negative test - must shift sign-bit

define i32 @lshr_sub_wrong_amount(i32 %x, i32 %y) {
; CHECK-LABEL: @lshr_sub_wrong_amount(
; CHECK-NEXT:    [[SUB:%.*]] = sub nsw i32 [[X:%.*]], [[Y:%.*]]
; CHECK-NEXT:    [[SHR:%.*]] = lshr i32 [[SUB]], 30
; CHECK-NEXT:    ret i32 [[SHR]]
;
  %sub = sub nsw i32 %x, %y
  %shr = lshr i32 %sub, 30
  ret i32 %shr
}

; negative test - must have nsw

define i32 @lshr_sub(i32 %x, i32 %y) {
; CHECK-LABEL: @lshr_sub(
; CHECK-NEXT:    [[SUB:%.*]] = sub i32 [[X:%.*]], [[Y:%.*]]
; CHECK-NEXT:    [[SHR:%.*]] = lshr i32 [[SUB]], 31
; CHECK-NEXT:    ret i32 [[SHR]]
;
  %sub = sub i32 %x, %y
  %shr = lshr i32 %sub, 31
  ret i32 %shr
}

; negative test - one-use

define i32 @lshr_sub_nsw_extra_use(i32 %x, i32 %y, i32* %p) {
; CHECK-LABEL: @lshr_sub_nsw_extra_use(
; CHECK-NEXT:    [[SUB:%.*]] = sub nsw i32 [[X:%.*]], [[Y:%.*]]
; CHECK-NEXT:    store i32 [[SUB]], i32* [[P:%.*]], align 4
; CHECK-NEXT:    [[SHR:%.*]] = lshr i32 [[SUB]], 31
; CHECK-NEXT:    ret i32 [[SHR]]
;
  %sub = sub nsw i32 %x, %y
  store i32 %sub, i32* %p
  %shr = lshr i32 %sub, 31
  ret i32 %shr
}

define <3 x i42> @lshr_sub_nsw_splat(<3 x i42> %x, <3 x i42> %y) {
; CHECK-LABEL: @lshr_sub_nsw_splat(
; CHECK-NEXT:    [[TMP1:%.*]] = icmp slt <3 x i42> [[X:%.*]], [[Y:%.*]]
; CHECK-NEXT:    [[SHR:%.*]] = zext <3 x i1> [[TMP1]] to <3 x i42>
; CHECK-NEXT:    ret <3 x i42> [[SHR]]
;
  %sub = sub nsw <3 x i42> %x, %y
  %shr = lshr <3 x i42> %sub, <i42 41, i42 41, i42 41>
  ret <3 x i42> %shr
}

define <3 x i42> @lshr_sub_nsw_splat_undef(<3 x i42> %x, <3 x i42> %y) {
; CHECK-LABEL: @lshr_sub_nsw_splat_undef(
; CHECK-NEXT:    [[SUB:%.*]] = sub nsw <3 x i42> [[X:%.*]], [[Y:%.*]]
; CHECK-NEXT:    [[SHR:%.*]] = lshr <3 x i42> [[SUB]], <i42 41, i42 undef, i42 41>
; CHECK-NEXT:    ret <3 x i42> [[SHR]]
;
  %sub = sub nsw <3 x i42> %x, %y
  %shr = lshr <3 x i42> %sub, <i42 41, i42 undef, i42 41>
  ret <3 x i42> %shr
}

define i17 @ashr_sub_nsw(i17 %x, i17 %y) {
; CHECK-LABEL: @ashr_sub_nsw(
; CHECK-NEXT:    [[TMP1:%.*]] = icmp slt i17 [[X:%.*]], [[Y:%.*]]
; CHECK-NEXT:    [[SHR:%.*]] = sext i1 [[TMP1]] to i17
; CHECK-NEXT:    ret i17 [[SHR]]
;
  %sub = sub nsw i17 %x, %y
  %shr = ashr i17 %sub, 16
  ret i17 %shr
}

; negative test - must shift sign-bit

define i17 @ashr_sub_wrong_amount(i17 %x, i17 %y) {
; CHECK-LABEL: @ashr_sub_wrong_amount(
; CHECK-NEXT:    [[SUB:%.*]] = sub nsw i17 [[X:%.*]], [[Y:%.*]]
; CHECK-NEXT:    [[SHR:%.*]] = ashr i17 [[SUB]], 15
; CHECK-NEXT:    ret i17 [[SHR]]
;
  %sub = sub nsw i17 %x, %y
  %shr = ashr i17 %sub, 15
  ret i17 %shr
}

; negative test - must have nsw

define i32 @ashr_sub(i32 %x, i32 %y) {
; CHECK-LABEL: @ashr_sub(
; CHECK-NEXT:    [[SUB:%.*]] = sub i32 [[X:%.*]], [[Y:%.*]]
; CHECK-NEXT:    [[SHR:%.*]] = ashr i32 [[SUB]], 31
; CHECK-NEXT:    ret i32 [[SHR]]
;
  %sub = sub i32 %x, %y
  %shr = ashr i32 %sub, 31
  ret i32 %shr
}

; negative test - one-use

define i32 @ashr_sub_nsw_extra_use(i32 %x, i32 %y, i32* %p) {
; CHECK-LABEL: @ashr_sub_nsw_extra_use(
; CHECK-NEXT:    [[SUB:%.*]] = sub nsw i32 [[X:%.*]], [[Y:%.*]]
; CHECK-NEXT:    store i32 [[SUB]], i32* [[P:%.*]], align 4
; CHECK-NEXT:    [[SHR:%.*]] = ashr i32 [[SUB]], 31
; CHECK-NEXT:    ret i32 [[SHR]]
;
  %sub = sub nsw i32 %x, %y
  store i32 %sub, i32* %p
  %shr = ashr i32 %sub, 31
  ret i32 %shr
}

define <3 x i43> @ashr_sub_nsw_splat(<3 x i43> %x, <3 x i43> %y) {
; CHECK-LABEL: @ashr_sub_nsw_splat(
; CHECK-NEXT:    [[TMP1:%.*]] = icmp slt <3 x i43> [[X:%.*]], [[Y:%.*]]
; CHECK-NEXT:    [[SHR:%.*]] = sext <3 x i1> [[TMP1]] to <3 x i43>
; CHECK-NEXT:    ret <3 x i43> [[SHR]]
;
  %sub = sub nsw <3 x i43> %x, %y
  %shr = ashr <3 x i43> %sub, <i43 42, i43 42, i43 42>
  ret <3 x i43> %shr
}

define <3 x i43> @ashr_sub_nsw_splat_undef(<3 x i43> %x, <3 x i43> %y) {
; CHECK-LABEL: @ashr_sub_nsw_splat_undef(
; CHECK-NEXT:    [[SUB:%.*]] = sub nsw <3 x i43> [[X:%.*]], [[Y:%.*]]
; CHECK-NEXT:    [[SHR:%.*]] = ashr <3 x i43> [[SUB]], <i43 42, i43 undef, i43 42>
; CHECK-NEXT:    ret <3 x i43> [[SHR]]
;
  %sub = sub nsw <3 x i43> %x, %y
  %shr = ashr <3 x i43> %sub, <i43 42, i43 undef, i43 42>
  ret <3 x i43> %shr
}
