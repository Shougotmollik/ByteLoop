import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:byteloop/routes/route_names.dart';
import 'package:byteloop/views/main_navbar/home/home_screen.dart';
import 'package:byteloop/views/main_navbar/search/search_screen.dart';
import 'package:byteloop/views/main_navbar/query/add_query_screen.dart';
import 'package:byteloop/views/main_navbar/notification/notification_screen.dart';
import 'package:byteloop/views/main_navbar/profile/profile_screen.dart';

class NavBarService extends GetxService {
  var currentIndex = 0.obs;
  var previousIndex = 0.obs;
  var isNavBarVisible = true.obs;
  var isAppBarVisible = true.obs;

  final ScrollController scrollController = ScrollController();

  final List<Widget> screens = [
    const HomeScreen(),
    const SearchScreen(),
    const AddQueryScreen(),
    const NotificationScreen(),
    const ProfileScreen(),
  ];

  @override
  void onInit() {
    super.onInit();
    scrollController.addListener(_scrollListener);
  }

  void _scrollListener() {
    if (scrollController.position.userScrollDirection ==
        ScrollDirection.reverse) {
      isNavBarVisible.value = false;
      isAppBarVisible.value = false;
    } else if (scrollController.position.userScrollDirection ==
        ScrollDirection.forward) {
      isNavBarVisible.value = true;
      isAppBarVisible.value = true;
    }
  }

  void updateIndex(int index) {
    previousIndex.value = currentIndex.value;
    currentIndex.value = index;
  }

  void backToPreviousScreen() {
    currentIndex.value = previousIndex.value;
  }

  void backToHomeScreenAndClearStack() {
    Get.offAllNamed(RouteNames.mainNavBarScreen);
    currentIndex.value = 0;
  }

  void backToProfileScreen() {
    currentIndex.value = 4;
  }
}
