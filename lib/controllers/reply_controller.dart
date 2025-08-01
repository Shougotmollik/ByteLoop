import 'package:byteloop/model/reply_model.dart';
import 'package:byteloop/services/supabase_service.dart';
import 'package:byteloop/utils/helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class ReplyController extends GetxController {
  var loading = false.obs;
  var reply = ''.obs;
  var replies = <ReplyModel>[].obs;
  final TextEditingController replyTEController = TextEditingController();

  @override
  void dispose() {
    replyTEController.dispose();
    super.dispose();
  }

  void addReply(String userId, int postId, String postUserId) async {
    try {
      loading.value = true;
      //  Increment post comment count
      await SupabaseService.client.rpc(
        "comment_increment",
        params: {"count": 1, "row_id": postId},
      );

      //   Add notification
      await SupabaseService.client.from('notifications').insert({
        "user_id": userId,
        "notification": "Your query got attention! Read the latest reply",
        "to_user_id": postUserId,
        "post_id": postId,
      });

      //   Add comment in table
      await SupabaseService.client.from('comments').insert({
        "post_id": postId,
        "user_id": userId,
        "reply": replyTEController.text,
      });
      Get.back();
      loading.value = false;
      replyTEController.clear();
      showSnackBar('Success', "Replied successfully!");
      await fetchReplies(postId);
    } catch (e) {
      loading.value = false;
      showSnackBar('Failed', "Something went wrong");
    }
  }

  Future<void> fetchReplies(int postId) async {
    try {
      final response = await SupabaseService.client
          .from('comments')
          .select('''
            id,
            post_id,
            user_id,
            reply,
            created_at,
            users:user_id (
              id,
              metadata
            )
          ''')
          .eq('post_id', postId)
          .order('created_at', ascending: false);

      replies.value = (response as List)
          .map((e) => ReplyModel.fromJson(e))
          .toList();
    } catch (e) {
      showSnackBar('Error', 'Failed to load replies');
    }
  }
}
