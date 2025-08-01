import 'dart:io';

import 'package:byteloop/model/query_model.dart';
import 'package:byteloop/model/user_reply_model.dart';
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
  var showQueryLoading = false.obs;
  Rx<QueryModel> queries = Rx<QueryModel>(QueryModel());
  var showReplyLoading = false.obs;
  RxList<UserReplyModel> replies = RxList<UserReplyModel>();

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

  // To show query
  void showQuery(int postId) async {
    try {
      queries.value = QueryModel();
      replies.value = [];
      showQueryLoading.value = true;
      final response = await SupabaseService.client
          .from('posts')
          .select('''
      id,content,assets,type,created_at,comment_count,like_count,user_id,
      user:user_id(email,metadata)
      ''')
          .eq('id', postId)
          .single();
      showQueryLoading.value = false;
      queries.value = QueryModel.fromJson(response);
      fetchReply(postId);
    } catch (e) {
      showSnackBar('Failed', 'Somethings went wrong');
    } finally {
      showQueryLoading.value = false;
    }
  }

  // Fetch repiles
  void fetchReply(int postId) async {
    try {
      showReplyLoading.value = true;
      final List<dynamic> response = await SupabaseService.client
          .from("comments")
          .select('''
      user_id,post_id,reply,created_at,user:user_id(email,metadata)
      ''')
          .eq("post_id", postId)
          .order("id", ascending: false);
      showReplyLoading.value = false;
      if (response.isNotEmpty) {
        replies.value = [
          for (var item in response) UserReplyModel.fromJson(item),
        ];
      }
    } catch (error) {
      showReplyLoading.value = false;
      showSnackBar('Failed!', 'Something went wrong');
    } finally {
      showReplyLoading.value = false;
    }
  }

  // * to like and dislike
  Future<void> likeDislike(
    String status,
    int postId,
    String postUserId,
    String userId,
  ) async {
    if (status == '1') {
      await SupabaseService.client.from('likes').insert({
        "user_id": userId,
        "post_id": postId,
      });

      //   Add like notification
      await SupabaseService.client.from('notifications').insert({
        "user_id": userId,
        "notification": "Someone noticed your query and gave it a like",
        "to_user_id": postUserId,
        "post_id": postId,
      });
      // * Increment the like counter
      await SupabaseService.client.rpc(
        "like_increment",
        params: {"count": 1, "row_id": postId},
      );
    } else {
      //   * Delete entry from likes table
      await SupabaseService.client.from("likes").delete().match({
        "user_id": userId,
        "post_id": postId,
      });
      // * Decrement post count
      await SupabaseService.client.rpc(
        "like_decrement",
        params: {"count": 1, "row_id": postId},
      );
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
