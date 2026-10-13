# Copyright (c) 2026 OceanBase.
# SPDX-License-Identifier: Apache-2.0
# Every library the complete engine links, in link order. The dependency
# modules included after this file append their imported libraries, and
# seekdb_wasm_database links the list as it stands.
set(seekdb_wasm_engine_libraries
  seekdb_wasm_engine_options
  seekdb_wasm_observer seekdb_wasm_sql seekdb_wasm_storage seekdb_wasm_share
  seekdb_wasm_logservice seekdb_wasm_rootserver seekdb_wasm_pl
  seekdb_wasm_query seekdb_wasm_data_plane seekdb_wasm_parser
  seekdb_wasm_oblib_common seekdb_wasm_oblib_lib seekdb_wasm_rpc
  seekdb_wasm_compression seekdb_wasm_restore seekdb_wasm_memory
  seekdb_wasm_crypto seekdb_wasm_startup_sources)
