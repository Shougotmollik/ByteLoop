import 'dart:io';

import 'package:byteloop/services/nav_bar_service.dart';
import 'package:byteloop/services/supabase_service.dart';
import 'package:byteloop/utils/env.dart';
import 'package:byteloop/utils/helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:uuid/uuid.dart';

class QueryController extends GetxController {
  final TextEditingController queryTEController = TextEditingController();
  var content = ''.obs;
  var loading = false.obs;
  var isUploading = false.obs;
  var isPicking = false.obs;

  Rx<File?> image = Rx<File?>(null);
  Rx<File?> video = Rx<File?>(null);

  @override
  void dispose() {
    queryTEController.dispose();
    super.dispose();
  }

  // pick image
  void pickImage() async {
    if (isPicking.value) return;
    isPicking.value = true;

    try {
      File? file = await pickImageFromGallery();
      if (file != null) {
        image.value = file;
        video.value = null; // Clear video if image picked
      } else {
        showSnackBar('Info', 'Image selection cancelled');
      }
    } catch (e) {
      showSnackBar('Error', 'Failed to pick image');
    } finally {
      isPicking.value = false;
    }
  }

  //  pick video
  void pickVideo() async {
    if (isPicking.value) return;
    isPicking.value = true;

    try {
      File? file = await pickVideoFromGallery();

      if (file == null) {
        // user cancelled picker
        isPicking.value = false;
        return;
      }

      final int sizeInBytes = await file.length();
      final double sizeInMB = sizeInBytes / (1024 * 1024);

      if (sizeInMB > 200) {
        showSnackBar('Error', 'Video size exceeds 200 MB.');
        isPicking.value = false;
        return;
      }

      video.value = file;
      image.value = null; // if you want to clear image selection
    } catch (e) {
      showSnackBar('Error', 'Failed to pick video');
    } finally {
      isPicking.value = false;
    }
  }

  // post store
  void store(String userId) async {
    try {
      loading.value = true;
      isUploading.value = true;

      const Uuid uuid = Uuid();
      final dir = "$userId/${uuid.v8()}";
      var assetPath = "";

      // * upload image if selected
      if (image.value != null && image.value!.existsSync()) {
        assetPath = await SupabaseService.client.storage
            .from(Env.s3Bucket)
            .upload(dir, image.value!);
      }
      // * upload video if selected
      else if (video.value != null && video.value!.existsSync()) {
        assetPath = await SupabaseService.client.storage
            .from(Env.s3Bucket)
            .upload(dir, video.value!);
      }

      //   Add post in DB
      await SupabaseService.client.from('posts').insert({
        "user_id": userId,
        "content": content.value,
        "assets": assetPath.isNotEmpty ? assetPath : null,
        "type": image.value != null
            ? 'image'
            : video.value != null
            ? 'video'
            : null,
      });
      loading.value = false;
      clearMedia();
      Get.find<NavBarService>().currentIndex.value = 0;
      showSnackBar('Success', 'Query added successfully');
    } on StorageException catch (e) {
      loading.value = false;
      showSnackBar('Failed!', e.message);
    } catch (error) {
      loading.value = false;
      showSnackBar('Failed!', 'Something went wrong');
    } finally {
      loading.value = false;
      isUploading.value = false;
    }
  }

  // Clear selected media
  void clearMedia() {
    content.value = "";
    queryTEController.text = '';
    image.value = null;
    video.value = null;
  }
}
