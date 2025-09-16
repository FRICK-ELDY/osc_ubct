//! summary: FRB v2用 lib.rs（余計なimportを排除）
//! path: example/rust/src/lib.rs

pub mod api;

// FRBの自動生成ファイル（integrate済みなら既に存在）
#[allow(non_snake_case, non_camel_case_types, non_upper_case_globals)]
mod frb_generated;
