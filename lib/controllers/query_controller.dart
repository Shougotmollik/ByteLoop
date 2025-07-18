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
  Rx<File?> image = Rx<File?>(null);
  Rx<File?> video = Rx<File?>(null);

  @override
  void dispose() {
    queryTEController.dispose();
    super.dispose();
  }

  // pick image
  void pickImage() async {
    File? file = await pickImageFromGallery();
    if (file != null) {
      image.value = file;
    }
  }

  //  pick video
  void pickVideo() async {
    File? file = await pickVideoFromGallery();
    if (file != null) {
      video.value = file;
    }
  }

  // post store
  void store(String userId) async {
    try {
      loading.value = true;
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
