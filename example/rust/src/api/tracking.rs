//! path: example/rust/src/api/tracking.rs
use std::time::{SystemTime, UNIX_EPOCH};
use flutter_rust_bridge::frb;          // ← 追加

#[frb(opaque)]                          // ← 追加：不透明ハンドル化
#[derive(Debug)]
pub struct Tracker {
    _model: Option<String>,
}

pub fn tracking_init(model_path: Option<String>) -> Tracker {
    Tracker { _model: model_path }
}

pub fn tracking_latest_json(_tr: &Tracker) -> Vec<u8> {
    let ms = SystemTime::now().duration_since(UNIX_EPOCH).unwrap().as_millis() as f32;
    let r = (ms % 3600.0) / 10.0;
    let p = ((ms / 2.0) % 3600.0) / 10.0;
    let y = ((ms / 3.0) % 3600.0) / 10.0;
    format!("{{\"keypoints\":[],\"angle\":{{\"r\":{r:.2},\"p\":{p:.2},\"y\":{y:.2}}}}}")
        .into_bytes()
}
