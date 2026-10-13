# Copyright (c) 2026 OceanBase. SPDX-License-Identifier: Apache-2.0
set(SEEKDB_WASM_RUST_DIR "${SEEKDB_ROOT}/build_wasm_rust_runtime" CACHE PATH
  "Directory built by tools/wasm/build-rust-nio.sh")
set(SEEKDB_WASM_NIO_ARCHIVE
  "${SEEKDB_WASM_RUST_DIR}/exports/libsql_nio.a")
if(NOT EXISTS "${SEEKDB_WASM_NIO_ARCHIVE}")
  message(FATAL_ERROR "Build Rust memory NIO with tools/wasm/build-rust-nio.sh ${SEEKDB_WASM_RUST_DIR}")
endif()
add_library(seekdb_wasm_nio STATIC IMPORTED GLOBAL)
add_custom_target(seekdb_wasm_nio_check
  COMMAND "${Python3_EXECUTABLE}" "${SEEKDB_ROOT}/tools/wasm/rust-nio-manifest.py"
    "${SEEKDB_WASM_RUST_DIR}"
  VERBATIM)
add_dependencies(seekdb_wasm_nio seekdb_wasm_nio_check)
set_target_properties(seekdb_wasm_nio PROPERTIES
  IMPORTED_LOCATION "${SEEKDB_WASM_NIO_ARCHIVE}"
  INTERFACE_INCLUDE_DIRECTORIES "${SEEKDB_ROOT}/rust/sql-nio/include")
list(APPEND seekdb_wasm_engine_libraries seekdb_wasm_nio)

# rust/build.py also exports the config and local crates; config uses local.
foreach(crate config local)
  set(archive "${SEEKDB_WASM_RUST_DIR}/exports/lib${crate}.a")
  if(NOT EXISTS "${archive}")
    message(FATAL_ERROR "Build the Rust crates with tools/wasm/build-rust-nio.sh ${SEEKDB_WASM_RUST_DIR}")
  endif()
  add_library(seekdb_wasm_${crate} STATIC IMPORTED GLOBAL)
  add_dependencies(seekdb_wasm_${crate} seekdb_wasm_nio_check)
  set_target_properties(seekdb_wasm_${crate} PROPERTIES IMPORTED_LOCATION "${archive}")
  list(APPEND seekdb_wasm_engine_libraries seekdb_wasm_${crate})
endforeach()
