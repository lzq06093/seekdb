#!/usr/bin/env bash
# Copyright (c) 2026 OceanBase. SPDX-License-Identifier: Apache-2.0
set -euo pipefail
seekdb_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"
seekdb_build_dir="${1:-${seekdb_root}/build_wasm_rust_runtime}"
source "${seekdb_root}/tools/wasm/rust-build-env.sh"
# rust/build.py builds the workspace and exports the static libraries and the
# generated C++ headers listed in rust/exports.json. The config and local cxx
# bridges compile with em++ and must share the engine's thread and exception model.
CXXFLAGS_wasm32_unknown_emscripten="-pthread -fexceptions" \
python3 "${seekdb_root}/rust/build.py" --target wasm32-unknown-emscripten \
  --target-dir "${CARGO_TARGET_DIR}" --output "${seekdb_build_dir}/exports" \
  -- --no-default-features --features sql-nio/memory-transport \
  -Zbuild-std=std,panic_abort
python3 "${seekdb_root}/tools/wasm/rust-nio-manifest.py" "${seekdb_build_dir}" --record
