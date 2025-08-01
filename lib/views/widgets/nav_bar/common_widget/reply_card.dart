import 'package:byteloop/controllers/reply_controller.dart';
import 'package:byteloop/views/widgets/nav_bar/profile/custom_circle_avatar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:timeago/timeago.dart' as timeago;

class ReplyCard extends StatelessWidget {
  final int postId;

  ReplyCard({super.key, required this.postId});

  final ReplyController replyController = Get.find<ReplyController>();

  @override
  Widget build(BuildContext context) {
    replyController.fetchReplies(postId);

    return Obx(() {
      if (replyController.loading.value) {
        return const Center(child: CircularProgressIndicator());
      }

      if (replyController.replies.isEmpty) {
        return const Center(child: Text("No replies yet."));
      }

      return ListView.builder(
        itemCount: replyController.replies.length,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          final reply = replyController.replies[index];
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 4.0,
                  vertical: 18.0,
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomCircleAvatar(url: reply.userAvatarUrl, radius: 20),
                    const SizedBox(width: 12),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: 4,
                      children: [
                        Text(
                          reply.username ?? 'Unknown',
                          style: const TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                          ),
                        ),
                        Text(
                          reply.reply,
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.white60,
                          ),
                        ),
                      ],
                    ),
                    const Spacer(),
                    Text(
                      timeago.format(reply.createdAt),
                      style: const TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                  ],
                ),
              ),
              const Divider(color: Color(0xff242424)),
            ],
          );
        },
      );
    });
  }
}
