import 'package:byteloop/model/user_model.dart';
import 'package:byteloop/routes/route_names.dart';
import 'package:byteloop/services/nav_bar_service.dart';
import 'package:byteloop/utils/styles/button_styles.dart';
import 'package:byteloop/views/widgets/nav_bar/profile/custom_circle_avatar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class UserTile extends StatelessWidget {
  final UserModel user;
  const UserTile({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    final currentUserId = Supabase.instance.client.auth.currentUser!.id;
    final NavBarService navBarService = Get.find<NavBarService>();
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
        onPressed: () {
          if (user.metadata?.sub == currentUserId) {
            navBarService.backToProfileScreen();
          } else {
            Get.toNamed(
              RouteNames.showUserProfile,
              arguments: user.metadata?.sub,
            );
          }
        },
        child: const Text('View Profile'),
      ),
    );
  }
}
