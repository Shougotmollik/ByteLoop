import 'package:byteloop/model/user_model.dart';
import 'package:byteloop/utils/styles/button_styles.dart';
import 'package:byteloop/views/widgets/nav_bar/profile/custom_circle_avatar.dart';
import 'package:flutter/material.dart';

class UserTile extends StatelessWidget {
  final UserModel user;
  const UserTile({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Padding(
        padding: const EdgeInsets.only(top: 5.0),
        child: CustomCircleAvatar(url: user.metadata?.image),
      ),
      title: Text(user.metadata!.name!),
      titleAlignment: ListTileTitleAlignment.top,
      subtitle: Text(user.metadata!.description!),
      trailing: OutlinedButton(
        style: customOutlineStyle(),
        onPressed: () {},
        child: const Text('View Profile'),
      ),
    );
  }
}
