import 'package:byteloop/views/main_navbar/home/home_screen.dart';
import 'package:byteloop/views/main_navbar/query/add_query_screen.dart';

import 'package:byteloop/views/main_navbar/notification/notification_screen.dart';
import 'package:byteloop/views/main_navbar/profile/profile_screen.dart';
import 'package:byteloop/views/main_navbar/search/search_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NavBarService extends GetxService {
  var currentIndex = 0.obs;
  var previousIndex = 0.obs;

  final List<Widget> screens = const [
    HomeScreen(),
    SearchScreen(),
    AddQueryScreen(),
    NotificationScreen(),
    ProfileScreen(),
  ];

  void updateIndex(int index) {
    previousIndex.value = currentIndex.value;
    currentIndex.value = index;
  }

  void selectedHomeScreen() {
    updateIndex(0);
  }
}
