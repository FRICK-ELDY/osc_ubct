//! summary: トラッキングの型とモデル選択の足場（後で推論器に差し替え）
//! path: example/rust/src/api/tracking.rs

use std::time::{SystemTime, UNIX_EPOCH};
use flutter_rust_bridge::frb;

#[frb(opaque)]
#[derive(Debug)]
pub struct Tracker {
    _model: Option<String>,
}

// UIのモデル候補に対応するID（必要に応じて増減）
#[derive(Debug, Clone, Copy)]
pub enum ModelId {
    Auto,
    MediaPipeUpper,
    MoveNetLightning,
    MoveNetThunder,
    BlazePoseUpper,
    OpenPoseUpper,
    YoloV8Upper,
}

pub fn tracking_init(model_path: Option<String>) -> Tracker {
    Tracker { _model: model_path }
}

// 追加: モデル選択（当面は文字列保持。実装時に実モデルをロード）
pub fn tracking_select_model(tr: &mut Tracker, id: ModelId) {
    tr._model = Some(format!("{id:?}"));
}

// 既存: ダミーのJSON（UI側は joints / angle どちらにも対応）
pub fn tracking_latest_json(_tr: &Tracker) -> Vec<u8> {
    let ms = SystemTime::now().duration_since(UNIX_EPOCH).unwrap().as_millis() as f32;
    let r = (ms % 3600.0) / 10.0;
    let p = ((ms / 2.0) % 3600.0) / 10.0;
    let y = ((ms / 3.0) % 3600.0) / 10.0;
    format!(
        "{{\"ver\":1,\"ts\":{},\"angle\":{{\"r\":{r:.2},\"p\":{p:.2},\"y\":{y:.2}}}}}",
        ms as u64
    ).into_bytes()
}
