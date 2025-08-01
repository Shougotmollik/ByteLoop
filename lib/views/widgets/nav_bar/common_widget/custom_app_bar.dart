import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:byteloop/services/nav_bar_service.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final NavBarService navBarService = Get.find<NavBarService>();

    return Obx(() {
      return AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        height: navBarService.isAppBarVisible.value ? 76 : 0,
        child: AnimatedOpacity(
          duration: const Duration(milliseconds: 300),
          opacity: navBarService.isAppBarVisible.value ? 1.0 : 0.0,
          child: AppBar(
            title: const Text(
              'Home',
              style: TextStyle(fontSize: 32, fontWeight: FontWeight.w500),
            ),
            elevation: 4,
          ),
        ),
      );
    });
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
