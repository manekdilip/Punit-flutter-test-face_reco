import 'dart:ui';

import 'package:camera/camera.dart';
import 'package:google_ml_kit/google_ml_kit.dart';

class CameraService {
  CameraController? _cameraController;
  CameraController? get cameraController => _cameraController;

  late InputImageRotation _cameraRotation;
  InputImageRotation get cameraRotation => _cameraRotation;

  late String _imagePath;
  String get imagePath => _imagePath;

  Future<void> initialize(bool isBack) async {
    CameraDescription description = await _getCameraDescription(isBack);
    await _setupCameraController(description: description);
    _cameraRotation = rotationIntToImageRotation(
      description.sensorOrientation,
    );
  }

  Future<CameraDescription> _getCameraDescription(bool isBack) async {
    List<CameraDescription> cameras = await availableCameras();
    return !isBack ? cameras[1] : cameras[0];
  }

  Future _setupCameraController({
    required CameraDescription description,
  }) async {
    _cameraController = CameraController(
      description,
      ResolutionPreset.high,
      enableAudio: false,
    );
    await _cameraController!.initialize();
  }

  Future<XFile> takePicture() async {
    //await _cameraController!.stopImageStream();
    XFile file = await _cameraController!.takePicture();
    _imagePath = file.path;
    return file;
  }

  Size getImageSize() {
    assert(_cameraController != null, 'Camera controller not initialized');
    return Size(
      _cameraController!.value.previewSize!.height,
      _cameraController!.value.previewSize!.width,
    );
  }

  dispose() async {
    await _cameraController?.dispose();
    _cameraController = null;
  }
}
