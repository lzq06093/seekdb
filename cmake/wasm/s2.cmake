# Copyright (c) 2026 OceanBase.
# SPDX-License-Identifier: Apache-2.0
if(NOT EXISTS "${SEEKDB_WASM_DEPS}/lib/libs2.a")
  message(FATAL_ERROR "Build S2 and Abseil with tools/wasm/build-s2.sh")
endif()
find_package(absl CONFIG REQUIRED PATHS "${SEEKDB_WASM_DEPS}/lib/cmake/absl"
  NO_DEFAULT_PATH NO_CMAKE_FIND_ROOT_PATH)
add_library(seekdb_wasm_s2 STATIC IMPORTED GLOBAL)
set_target_properties(seekdb_wasm_s2 PROPERTIES
  IMPORTED_LOCATION "${SEEKDB_WASM_DEPS}/lib/libs2.a"
  INTERFACE_INCLUDE_DIRECTORIES "${SEEKDB_WASM_DEPS}/include")
# Match the pinned upstream s2 target's Abseil dependency graph.
target_link_libraries(seekdb_wasm_s2 INTERFACE seekdb_wasm_crypto
  absl::base absl::btree absl::config absl::core_headers absl::dynamic_annotations
  absl::endian absl::fixed_array absl::flat_hash_map absl::flat_hash_set absl::hash
  absl::inlined_vector absl::int128 absl::log_severity absl::memory absl::span
  absl::str_format absl::strings absl::type_traits absl::utility)
list(APPEND seekdb_wasm_engine_libraries seekdb_wasm_s2)
