import 'package:image_picker/image_picker.dart';

class ImageSelector {
  /// Get image from photo library
  Future<PickedFile> selectImageGallery() async {
    return await ImagePicker().getImage(source: ImageSource.gallery);
  }

  /// Get image from camera
  Future<PickedFile> selectImageCamera() async {
    return await ImagePicker().getImage(source: ImageSource.camera);
  }
}
