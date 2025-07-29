import 'package:byteloop/model/user_reply_model.dart';
import 'package:byteloop/views/widgets/nav_bar/profile/custom_circle_avatar.dart';
import 'package:byteloop/views/widgets/nav_bar/profile/user_reply_card_top_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserReplyCard extends StatelessWidget {
  final UserReplyModel userReply;

  const UserReplyCard({super.key, required this.userReply});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              SizedBox(
                width: context.width * 0.12,
                child: CustomCircleAvatar(url: userReply.user!.metadata?.image),
              ),
              const SizedBox(width: 10),
              SizedBox(
                width: context.width * 0.75,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    UserReplyCardTopBar(userReply: userReply),
                    Text(userReply.reply!),
                  ],
                ),
              ),
            ],
          ),
        ),
        const Divider(color: Color(0xff242424)),
      ],
    );
  }
}
