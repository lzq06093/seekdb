# Copyright (c) 2026 OceanBase.
# SPDX-License-Identifier: Apache-2.0
if(NOT EXISTS "${SEEKDB_WASM_DEPS}/lib/libprotobuf-c.a")
  message(FATAL_ERROR "Build protobuf-c with tools/wasm/build-protobuf-c.sh")
endif()
add_library(seekdb_wasm_protobuf STATIC IMPORTED GLOBAL)
set_target_properties(seekdb_wasm_protobuf PROPERTIES
  IMPORTED_LOCATION "${SEEKDB_WASM_DEPS}/lib/libprotobuf-c.a"
  INTERFACE_INCLUDE_DIRECTORIES "${SEEKDB_WASM_DEPS}/include")
list(APPEND seekdb_wasm_engine_libraries seekdb_wasm_protobuf)
