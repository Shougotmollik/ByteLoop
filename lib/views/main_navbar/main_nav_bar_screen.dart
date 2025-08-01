import 'package:byteloop/services/nav_bar_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (!didPop) {
          if (_navBarService.currentIndex.value != 0) {
            _navBarService.backToHomeScreenAndClearStack();
          } else {
            showDialog(
              context: context,
              builder: (_) => AlertDialog(
                title: const Text('Exit App'),
                content: const Text('Do you want to exit the app?'),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Cancel'),
                  ),
                  TextButton(
                    onPressed: () => SystemNavigator.pop(),
                    child: const Text('Exit'),
                  ),
                ],
              ),
            );
          }
        }
      },
      child: Obx(
        () => Scaffold(
          body: AnimatedSwitcher(
            duration: const Duration(milliseconds: 500),
            switchInCurve: Curves.ease,
            switchOutCurve: Curves.easeInOut,
            child: _navBarService.screens[_navBarService.currentIndex.value],
          ),
          bottomNavigationBar: Obx(() {
            return AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              height: _navBarService.isNavBarVisible.value
                  ? kBottomNavigationBarHeight
                  : 0,
              child: Wrap(
                children: [
                  NavigationBar(
                    selectedIndex: _navBarService.currentIndex.value,
                    onDestinationSelected: _navBarService.updateIndex,
                    animationDuration: const Duration(milliseconds: 500),
                    destinations: const [
                      NavigationDestination(
                        icon: Icon(Iconsax.home_1_copy),
                        selectedIcon: Icon(Iconsax.home),
                        label: 'Home',
                      ),
                      NavigationDestination(
                        icon: Icon(Iconsax.search_normal_1_copy),
                        selectedIcon: Icon(Iconsax.search_normal_1),
                        label: 'Search',
                      ),
                      NavigationDestination(
                        icon: Icon(Iconsax.add_square_copy),
                        selectedIcon: Icon(Iconsax.add_square),
                        label: 'Query',
                      ),
                      NavigationDestination(
                        icon: Icon(Iconsax.heart_copy),
                        selectedIcon: Icon(Iconsax.heart),
                        label: 'Notifications',
                      ),
                      NavigationDestination(
                        icon: Icon(Iconsax.profile_circle_copy),
                        selectedIcon: Icon(Iconsax.profile_circle),
                        label: 'Profile',
                      ),
                    ],
                  ),
                ],
              ),
            );
          }),
        ),
      ),
    );
  }
}
