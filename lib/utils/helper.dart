import 'dart:io';

import 'package:byteloop/utils/env.dart';
import 'package:byteloop/views/widgets/nav_bar/common_widget/confirm_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

// * image picker and uuid instance
const uuid = Uuid();
final ImagePicker picker = ImagePicker();

void showSnackBar(String title, String message) {
  Get.snackbar(
    title,
    message,
    snackPosition: SnackPosition.BOTTOM,
    colorText: Colors.white,
    backgroundColor: const Color(0xff252526),
    padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
    snackStyle: SnackStyle.GROUNDED,
    margin: const EdgeInsets.all(0.0),
  );
}

//* pick Image from gallery
Future<File?> pickImageFromGallery() async {
  final XFile? file = await picker.pickImage(source: ImageSource.gallery);
  if (file == null) return null;

  final dir = Directory.systemTemp;
  final targetPath = "${dir.absolute.path}/${uuid.v8()}.jpg";

  File image = await compressImage(File(file.path), targetPath);
  return image;
}

// * pick video from gallery
Future<File?> pickVideoFromGallery() async {
  final XFile? file = await picker.pickVideo(source: ImageSource.gallery);
  if (file == null) return null;

  // copy video to temporary directory
  final dir = Directory.systemTemp;
  final targetPath = "${dir.absolute.path}/${uuid.v8()}.mp4";

  File video = await File(file.path).copy(targetPath);
  return video;
}

//* Compress image file
Future<File> compressImage(File file, String targetPath) async {
  var result = await FlutterImageCompress.compressAndGetFile(
    file.path,
    targetPath,
    quality: 70,
  );
  return File(result!.path);
}

//* to get s3 url image
String getS3Url(String path) {
  return "${Env.supabaseUrl}/storage/v1/object/public/$path";
}

// * confirm dialog
void confirmDialog({
  required String title,
  required String text,
  required VoidCallback onTap,
}) {
  Get.dialog(ConfirmDialog(title: title, text: text, onTap: onTap));
}
