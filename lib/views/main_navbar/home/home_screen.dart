import 'package:byteloop/controllers/home_controller.dart';
import 'package:byteloop/views/widgets/nav_bar/common_widget/custom_app_bar.dart';
import 'package:byteloop/views/widgets/nav_bar/common_widget/custom_circular_progress_indicator.dart';
import 'package:byteloop/views/widgets/nav_bar/common_widget/custom_radial_background.dart';
import 'package:byteloop/views/widgets/nav_bar/common_widget/query_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final HomeController homeController = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: const CustomAppBar(),
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.transparent,
      body: CustomRadialBackground(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: CustomScrollView(
            slivers: [
              const CustomAppBar(),
              SliverToBoxAdapter(
                child: Obx(
                  () => homeController.loading.value
                      ? const CustomCircularProgressIndicator()
                      : ListView.builder(
                          itemCount: homeController.queries.length,
                          shrinkWrap: true,
                          padding: EdgeInsets.zero,
                          physics: const BouncingScrollPhysics(),
                          itemBuilder: (context, index) =>
                              QueryCard(query: homeController.queries[index]),
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
