# Copyright (c) 2026 OceanBase.
# SPDX-License-Identifier: Apache-2.0
foreach(library vsag_kernels vsag_core vsag_hnsw vsag_blas vsag_antlr cpuinfo fmt)
  set(archive "${library}")
  if(library MATCHES "^vsag_")
    set(archive "seekdb_${library}")
  endif()
  if(NOT EXISTS "${SEEKDB_WASM_DEPS}/lib/lib${archive}.a")
    message(FATAL_ERROR "Build VSAG with tools/wasm/build-vsag.sh")
  endif()
  add_library(seekdb_wasm_${library} STATIC IMPORTED GLOBAL)
  set_target_properties(seekdb_wasm_${library} PROPERTIES
    IMPORTED_LOCATION "${SEEKDB_WASM_DEPS}/lib/lib${archive}.a"
    INTERFACE_INCLUDE_DIRECTORIES "${SEEKDB_WASM_DEPS}/include;${SEEKDB_WASM_DEPS}/include/seekdb-vsag")
endforeach()
target_link_libraries(seekdb_wasm_vsag_kernels INTERFACE seekdb_wasm_cpuinfo)
target_link_libraries(seekdb_wasm_vsag_core INTERFACE seekdb_wasm_vsag_kernels seekdb_wasm_fmt)
target_link_libraries(seekdb_wasm_vsag_hnsw INTERFACE seekdb_wasm_vsag_core seekdb_wasm_roaring seekdb_wasm_vsag_blas seekdb_wasm_vsag_antlr)
target_include_directories(seekdb_wasm_vsag_hnsw INTERFACE "${SEEKDB_WASM_DEPS}/include/roaring")
target_compile_definitions(seekdb_wasm_vsag_hnsw INTERFACE VSAG_DISABLE_STATIC_HNSW HAVE_LIBAIO=0)
list(APPEND seekdb_wasm_engine_libraries seekdb_wasm_vsag_hnsw)
