import 'package:camera/camera.dart';
import 'package:google_ml_kit/google_ml_kit.dart';

class FaceDetectorService {
  late FaceDetector _faceDetector;
  FaceDetector get faceDetector => _faceDetector;

  List<Face> _faces = [];
  List<Face> get faces => _faces;
  bool get faceDetected => _faces.isNotEmpty;

  void initialize() {
    _faceDetector = GoogleMlKit.vision.faceDetector(
      const FaceDetectorOptions(
        mode: FaceDetectorMode.accurate,
      ),
    );
  }

  Future<void> detectFacesFromImage(XFile image) async {
    InputImage _firebaseVisionImage = InputImage.fromFilePath(image.path);

    _faces = await _faceDetector.processImage(_firebaseVisionImage);
  }

  dispose() {
    _faceDetector.close();
  }
}
