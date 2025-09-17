//! summary: トラッキングAPI（FRB v2対応）。モデル選択とJSON出力、配線確認用タグを提供
//! path: example/rust/src/api/tracking.rs

use flutter_rust_bridge::frb;
use std::time::{SystemTime, UNIX_EPOCH};

/// Dart 側にはハンドルとして渡すだけなので `opaque` にする
#[frb(opaque)]
#[derive(Debug)]
pub struct Tracker {
    /// 実装時にモデルロードのパスやIDなどをここで保持
    _model: Option<String>,
}

/// UIのドロップダウンと1対1で対応する列挙
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

/// トラッカー生成（MVPではモデルは未ロード）
pub fn tracking_init(model_path: Option<String>) -> Tracker {
    Tracker { _model: model_path }
}

/// モデルを選択（MVPでは文字列保持のみ。後に実モデルのロード/切替処理へ差し替え）
pub fn tracking_select_model(tr: &mut Tracker, id: ModelId) {
    tr._model = Some(format!("{id:?}"));
}

/// 最新の推定結果を JSON で返す（MVP: ダミーの角度値）
///
/// - UI側は `{"joints":{...}}` または `{"angle":{r,p,y}}` のいずれにも対応しているため、
///   まずは軽量な `angle` 形式を返す。
pub fn tracking_latest_json(_tr: &Tracker) -> Vec<u8> {
    let ms = SystemTime::now()
        .duration_since(UNIX_EPOCH)
        .unwrap()
        .as_millis() as f32;

    let r = (ms % 3600.0) / 10.0;
    let p = ((ms / 2.0) % 3600.0) / 10.0;
    let y = ((ms / 3.0) % 3600.0) / 10.0;

    // 角度（度単位）を返す
    format!(
        "{{\"ver\":1,\"ts\":{},\"angle\":{{\"r\":{r:.2},\"p\":{p:.2},\"y\":{y:.2}}}}}",
        ms as u64
    )
    .into_bytes()
}
