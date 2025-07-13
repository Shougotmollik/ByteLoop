import 'package:byteloop/services/nav_bar_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class MainNavBarScreen extends StatefulWidget {
  const MainNavBarScreen({super.key});

  @override
  State<MainNavBarScreen> createState() => _MainNavBarScreenState();
}

class _MainNavBarScreenState extends State<MainNavBarScreen> {
  final NavBarService _navBarService = Get.put(NavBarService());

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        body: AnimatedSwitcher(
          duration: const Duration(milliseconds: 500),
          switchInCurve: Curves.ease,
          switchOutCurve: Curves.easeInOut,

          child: _navBarService.screens[_navBarService.currentIndex.value],
        ),

        bottomNavigationBar: NavigationBar(
          selectedIndex: _navBarService.currentIndex.value,
          onDestinationSelected: (value) => _navBarService.updateIndex(value),
          animationDuration: const Duration(milliseconds: 500),

          destinations: const [
            NavigationDestination(
              icon: Icon(Iconsax.home_1_copy),
              selectedIcon: Icon(Iconsax.home),
              label: 'home',
            ),
            NavigationDestination(
              icon: Icon(Iconsax.search_normal_1_copy),
              selectedIcon: Icon(Iconsax.search_normal_1),
              label: 'Search',
            ),
            NavigationDestination(
              icon: Icon(Iconsax.edit_copy),
              selectedIcon: Icon(Iconsax.edit_2),
              label: 'Query',
            ),
            NavigationDestination(
              icon: Icon(Iconsax.heart_copy),
              selectedIcon: Icon(Iconsax.heart),
              label: 'home',
            ),
            NavigationDestination(
              icon: Icon(Iconsax.profile_circle_copy),
              selectedIcon: Icon(Iconsax.profile_circle),
              label: 'home',
            ),
          ],
        ),
      ),
    );
  }
}
