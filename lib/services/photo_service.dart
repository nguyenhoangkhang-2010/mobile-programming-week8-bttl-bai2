import 'package:image_picker/image_picker.dart';

class PhotoService {
  final ImagePicker _picker = ImagePicker();

  Future<XFile?> pickImage(ImageSource source) async {
    try {
      return await _picker.pickImage(
        source: source,
        maxWidth: 1080,
        imageQuality: 85,
      );
    } catch (e) {
      print("Lỗi PhotoService: $e");
      return null;
    }
  }
}