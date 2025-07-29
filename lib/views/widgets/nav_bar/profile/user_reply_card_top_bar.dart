import 'package:byteloop/model/user_reply_model.dart';
import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as timeago;

class UserReplyCardTopBar extends StatelessWidget {
  final UserReplyModel userReply;

  const UserReplyCardTopBar({super.key, required this.userReply});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          userReply.user!.metadata!.name!,
          style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 15),
        ),

        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 6,
          children: [
            Text(timeago.format(DateTime.parse(userReply.createdAt!))),
            const Icon(Icons.more_horiz),
          ],
        ),
      ],
    );
  }
}
