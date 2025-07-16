import 'dart:io';

import 'package:byteloop/services/supabase_service.dart';
import 'package:byteloop/utils/env.dart';
import 'package:byteloop/utils/helper.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ProfileController extends GetxController {
  var loading = false.obs;
  Rx<File?> image = Rx<File?>(null);

  // * pick the image
  Future<void> pickImage() async {
    File? file = await pickImageFromGallery();
    if (file != null) image.value = file;
  }

  // * update profile method
  Future<void> updateProfile(
    String userId,
    String name,
    String description,
  ) async {
    try {
      loading.value = true;
      var uploadedPath = '';
      if (image.value != null && image.value!.existsSync()) {
        final String dir = "$userId/profile.jpg";
        var path = await SupabaseService.client.storage
            .from(Env.s3Bucket)
            .upload(
              dir,
              image.value!,
              fileOptions: const FileOptions(upsert: true),
            );
        uploadedPath = path;
      }

      //* update Profile
      await SupabaseService.client.auth.updateUser(
        UserAttributes(
          data: {
            "name": name,
            "description": description,
            "image": uploadedPath.isNotEmpty ? uploadedPath : null,
          },
        ),
      );
      loading.value = false;
      Get.back();
      showSnackBar('success', 'profile updated successfully');
    } on StorageException catch (error) {
      loading.value = false;
      showSnackBar('Somethings went wrong!', error.message);
    } on AuthException catch (error) {
      showSnackBar('Somethings went wrong!', error.message);
    } catch (error) {
      showSnackBar('error', 'Something went wrong! Please try again!');
    }
  }
}
