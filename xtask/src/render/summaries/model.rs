//! summary: Summaries表で使うデータ型（Section, Row）の定義
//! path: xtask/src/render/summaries/model.rs

#[derive(Debug, Clone, Eq, PartialEq, Ord, PartialOrd)]
pub enum Section {
    Dart,
    Camera,
    Tracking,
    Osc,
}

impl Section {
    pub fn title(&self) -> &'static str {
        match self {
            Section::Dart => "### Dart - Flutter UI",
            Section::Camera => "### Rust - Camera API",
            Section::Tracking => "### Rust - Tracking API",
            Section::Osc => "### Rust - Osc API",
        }
    }

    /// 出力順を固定
    pub fn order() -> &'static [Section] {
        &[
            Section::Dart,
            Section::Camera,
            Section::Tracking,
            Section::Osc,
        ]
    }
}

#[derive(Debug)]
pub struct Row {
    pub rel_path: String,
    pub lines: usize,
    pub status: &'static str,
    pub summary: Option<String>,
}
