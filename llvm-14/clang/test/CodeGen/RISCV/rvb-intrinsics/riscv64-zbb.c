// NOTE: Assertions have been autogenerated by utils/update_cc_test_checks.py
// RUN: %clang_cc1 -triple riscv64 -target-feature +zbb -emit-llvm %s -o - \
// RUN:     | FileCheck %s  -check-prefix=RV64ZBB

// RV64ZBB-LABEL: @orc_b_32(
// RV64ZBB-NEXT:  entry:
// RV64ZBB-NEXT:    [[A_ADDR:%.*]] = alloca i32, align 4
// RV64ZBB-NEXT:    store i32 [[A:%.*]], i32* [[A_ADDR]], align 4
// RV64ZBB-NEXT:    [[TMP0:%.*]] = load i32, i32* [[A_ADDR]], align 4
// RV64ZBB-NEXT:    [[TMP1:%.*]] = call i32 @llvm.riscv.orc.b.i32(i32 [[TMP0]])
// RV64ZBB-NEXT:    ret i32 [[TMP1]]
//
int orc_b_32(int a) {
  return __builtin_riscv_orc_b_32(a);
}

// RV64ZBB-LABEL: @orc_b_64(
// RV64ZBB-NEXT:  entry:
// RV64ZBB-NEXT:    [[A_ADDR:%.*]] = alloca i64, align 8
// RV64ZBB-NEXT:    store i64 [[A:%.*]], i64* [[A_ADDR]], align 8
// RV64ZBB-NEXT:    [[TMP0:%.*]] = load i64, i64* [[A_ADDR]], align 8
// RV64ZBB-NEXT:    [[TMP1:%.*]] = call i64 @llvm.riscv.orc.b.i64(i64 [[TMP0]])
// RV64ZBB-NEXT:    ret i64 [[TMP1]]
//
long orc_b_64(long a) {
  return __builtin_riscv_orc_b_64(a);
}