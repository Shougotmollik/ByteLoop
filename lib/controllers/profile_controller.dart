import 'dart:io';

import 'package:byteloop/model/query_model.dart';
import 'package:byteloop/model/user_reply_model.dart';
import 'package:byteloop/services/supabase_service.dart';
import 'package:byteloop/utils/env.dart';
import 'package:byteloop/utils/helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ProfileController extends GetxController {
  var loading = false.obs;
  Rx<File?> image = Rx<File?>(null);

  var queryLoading = false.obs;
  RxList<QueryModel> queries = RxList<QueryModel>();

  var replyLoading = false.obs;
  RxList<UserReplyModel> replies = RxList<UserReplyModel>();

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

  // Fetch user-specific queries with user info joined
  void fetchUserQuery(String userId) async {
    try {
      queryLoading.value = true;
      final List<dynamic> response = await SupabaseService.client
          .from('posts')
          .select('''
          id, content, assets, type, created_at, comment_count, like_count, user_id,
          user:user_id(email, metadata)
        ''')
          .eq('user_id', userId)
          .order('id', ascending: false)
          .limit(30); // optional: limits to latest 30 posts
      if (response.isNotEmpty) {
        queries.value = [for (var item in response) QueryModel.fromJson(item)];
      } else {
        queries.clear();
      }
    } catch (e, stackTrace) {
      debugPrint('Error in fetchUserQuery: $e');
      debugPrintStack(stackTrace: stackTrace);
      showSnackBar('Failed', 'Something went wrong!');
    } finally {
      queryLoading.value = false;
    }
  }

  //** Fetch user replies
  void fetchUserReplies(String userId) async {
    try {
      replyLoading.value = true;
      final List<dynamic> response = await SupabaseService.client
          .from("comments")
          .select('''
      user_id,post_id,reply,created_at,user:user_id(email,metadata)
      ''')
          .eq("user_id", userId)
          .order("id", ascending: false);
      replyLoading.value = false;
      if (response.isNotEmpty) {
        replies.value = [
          for (var item in response) UserReplyModel.fromJson(item),
        ];
      }
    } catch (e) {
      replyLoading.value = false;
      showSnackBar('Failed', 'Somethings went wrong');
    }
  }
}
