import 'package:byteloop/routes/route_names.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:byteloop/services/nav_bar_service.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final NavBarService navBarService = Get.find<NavBarService>();

    return Obx(() {
      return AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        height: navBarService.isAppBarVisible.value ? 76 : 68,
        child: AnimatedOpacity(
          duration: const Duration(milliseconds: 300),
          opacity: navBarService.isAppBarVisible.value ? 1.0 : 1.0,
          child: AppBar(
            title: Padding(
              padding: const EdgeInsets.only(bottom: 12.0, top: 12.0),
              child: Text(
                'Home',
                style: TextStyle(
                  fontSize: navBarService.isAppBarVisible.value ? 32 : 22,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            elevation: 4,
            actions: [
              IconButton(
                onPressed: () {
                  Get.toNamed(RouteNames.searchScreen);
                },
                icon: Icon(
                  Iconsax.user_search_copy,
                  size: navBarService.isAppBarVisible.value ? 22 : 18,
                ),
              ),
              IconButton(
                onPressed: () {
                  Get.toNamed(RouteNames.notificationScreen);
                },
                icon: Icon(
                  Iconsax.notification_copy,
                  size: navBarService.isAppBarVisible.value ? 22 : 18,
                ),
              ),
            ],
          ),
        ),
      );
    });
  }

  @override
  Size get preferredSize => const Size.fromHeight(76);
}
