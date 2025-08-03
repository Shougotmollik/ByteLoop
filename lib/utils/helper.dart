import 'dart:io';

import 'package:byteloop/constant/app_colors.dart';
import 'package:byteloop/model/BottomSheetItemModel.dart';
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
void showConfirmDialog({
  required String title,
  required String text,
  required VoidCallback onTap,
}) {
  Get.dialog(ConfirmDialog(title: title, text: text, onTap: onTap));
}

//* Bottom sheet
void showCustomBottomSheet({required List<BottomSheetItemModel> items}) {
  Get.bottomSheet(
    Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
      decoration: const BoxDecoration(
        color: AppColors.bgColor,
        borderRadius: BorderRadius.vertical(top: Radius.circular(14)),
      ),
      child: Wrap(
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          const SizedBox(height: 10),
          Center(
            child: Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey[400],
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          ),
          const SizedBox(height: 18),
          for (var item in items)
            Card(
              color: AppColors.authBgColor,
              elevation: 4,
              child: ListTile(
                trailing: item.icon != null
                    ? Icon(item.icon, color: item.iconColor)
                    : null,
                title: Text(
                  item.title,
                  style: TextStyle(color: item.titleColor),
                ),
                onTap: () {
                  Get.back();
                  item.onTap();
                },
                titleAlignment: ListTileTitleAlignment.center,
              ),
            ),
        ],
      ),
    ),
    backgroundColor: Colors.transparent,
    isScrollControlled: true,
  );
}
