#!/bin/sh

set -ex

ROOT=$(dirname $(realpath $0))/..
. $ROOT/ci/ci-system-setup.sh

opset=onnx_"${1:-1_22_0}"

if [ "${2:-}" != "--opset-only" ]; then
    cargo -q test -p test-unit-core $CARGO_EXTRA -q
    cargo -q test -p test-nnef-cycle $CARGO_EXTRA -q --no-default-features
fi
cargo -q test -p test-onnx-core $CARGO_EXTRA -q --no-default-features --features $opset
