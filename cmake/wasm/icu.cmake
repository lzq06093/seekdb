# Copyright (c) 2026 OceanBase.
# SPDX-License-Identifier: Apache-2.0
foreach(component common i18n data)
  if(NOT EXISTS "${SEEKDB_WASM_DEPS}/lib/libicu_${component}.a")
    message(FATAL_ERROR "Build ICU 69.1 with tools/wasm/build-icu.sh")
  endif()
  add_library(seekdb_wasm_icu_${component} STATIC IMPORTED GLOBAL)
  set_target_properties(seekdb_wasm_icu_${component} PROPERTIES
    IMPORTED_LOCATION "${SEEKDB_WASM_DEPS}/lib/libicu_${component}.a"
    INTERFACE_INCLUDE_DIRECTORIES "${SEEKDB_WASM_DEPS}/include")
endforeach()
target_link_libraries(seekdb_wasm_icu_i18n INTERFACE seekdb_wasm_icu_common)
target_link_libraries(seekdb_wasm_icu_common INTERFACE seekdb_wasm_icu_data)
list(APPEND seekdb_wasm_engine_libraries seekdb_wasm_icu_i18n)
