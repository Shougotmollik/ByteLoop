import 'dart:io';

import 'package:byteloop/utils/helper.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController {
  var loading = false.obs;
  Rx<File?> image = Rx<File?>(null);

  // * pick the image
  Future<void> pickImage() async {
    File? file = await pickImageFromGallery();
    if (file != null) image.value = file;
  }
}
