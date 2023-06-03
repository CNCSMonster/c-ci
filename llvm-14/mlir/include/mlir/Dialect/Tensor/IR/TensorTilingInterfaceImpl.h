//===- TensorTilingOpInterfaceImpl.h - ------------------------------------===//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//
//
// This file implements Tiling interface for TensorOps with ExternalModel.
//
//===----------------------------------------------------------------------===//

#ifndef MLIR_DIALECT_TENSOR_IR_TENSORTILINGINTERFACEIMPL_H_
#define MLIR_DIALECT_TENSOR_IR_TENSORTILINGINTERFACEIMPL_H_

#include "mlir/IR/Dialect.h"

namespace mlir {
namespace tensor {

/// Registers external models for Tiling interface for tensor ops.
/// Currently, it registers:
///
/// * TilingInterface for `tensor.pad`.
///
/// Unfortunately, a "normal" internal registration is not possible at the
/// moment, because of the dependency of the interface implementation for these
/// ops on `affine.apply` and Affine dialect already depends on TensorOps. In
/// order to break the cyclic dependency (TensorOps->AffineOps->TensorOps) the
/// implementation is moved to a separate library.
void registerTilingOpInterfaceExternalModels(mlir::DialectRegistry &registry);

} // namespace tensor
} // namespace mlir

#endif // MLIR_DIALECT_TENSOR_IR_TENSORTILINGINTERFACEIMPL_H_
