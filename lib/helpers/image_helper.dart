import 'dart:io';

import 'package:image_picker/image_picker.dart';

class ImageHelper {
  static final ImagePicker picker = ImagePicker();

  static Future<File?> pickImage() async {
    final XFile? pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 50,
    );

    return pickedFile != null ? File(pickedFile.path) : null;
  }
}
