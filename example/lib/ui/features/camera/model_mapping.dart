//! summary: UIラベル→RustのModelId（FRB生成enum）に変換
//! path: example/lib/ui/features/camera/model_mapping.dart
import '../../../src/rust/api/tracking.dart' as tr_api;

tr_api.ModelId modelIdFromLabel(String label) {
  switch (label) {
    case 'MediaPipe Upper Body':
      return tr_api.ModelId.mediaPipeUpper;
    case 'MoveNet (Lightning)':
      return tr_api.ModelId.moveNetLightning;
    case 'MoveNet (Thunder)':
      return tr_api.ModelId.moveNetThunder;
    case 'BlazePose Upper':
      return tr_api.ModelId.blazePoseUpper;
    case 'OpenPose Upper':
      return tr_api.ModelId.openPoseUpper;
    case 'YOLOv8-Pose (Upper)':
      return tr_api.ModelId.yoloV8Upper;
    case 'Auto (Recommended)':
    default:
      return tr_api.ModelId.auto;
  }
}
