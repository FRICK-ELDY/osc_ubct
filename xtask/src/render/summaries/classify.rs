//! summary: パスから Section を分類するユーティリティ
//! path: xtask/src/render/summaries/classify.rs

use super::model::Section;

/// relative path の先頭から Section を分類
pub fn classify_section(rel: &str) -> Option<Section> {
    if rel.starts_with("example/lib/") {
        Some(Section::Dart)
    } else if rel.starts_with("lib/") {
        Some(Section::Lib)
    } else if rel.starts_with("windows/") {
        Some(Section::Windows)
    } else {
        None
    }
}
