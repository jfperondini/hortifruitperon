import 'dart:io';
import 'dart:typed_data';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/foundation.dart';

class GetImageGalleryUsecase {
  final ImagePicker picker;

  GetImageGalleryUsecase({required this.picker});

  Future<Uint8List?> call() async {
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      return File(image.path).readAsBytesSync();
    }
    return Uint8List.fromList([]);
  }
}
