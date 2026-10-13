# Copyright (c) 2026 OceanBase.
# SPDX-License-Identifier: Apache-2.0
if(NOT EXISTS "${SEEKDB_WASM_DEPS}/lib/libxml2.a")
  message(FATAL_ERROR "Build libxml2 with tools/wasm/build-libxml2.sh")
endif()
add_library(seekdb_wasm_xml STATIC IMPORTED GLOBAL)
set_target_properties(seekdb_wasm_xml PROPERTIES
  IMPORTED_LOCATION "${SEEKDB_WASM_DEPS}/lib/libxml2.a"
  INTERFACE_INCLUDE_DIRECTORIES "${SEEKDB_WASM_DEPS}/include/libxml2")
list(APPEND seekdb_wasm_engine_libraries seekdb_wasm_xml)
