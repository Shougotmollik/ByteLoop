import 'package:byteloop/controllers/search_user_controller.dart';
import 'package:byteloop/views/main_navbar/search/lottie_search_widget.dart';
import 'package:byteloop/views/widgets/nav_bar/common_widget/custom_circular_progress_indicator.dart';
import 'package:byteloop/views/widgets/nav_bar/common_widget/custom_radial_background.dart';
import 'package:byteloop/views/widgets/nav_bar/common_widget/search_input.dart';
import 'package:byteloop/views/widgets/nav_bar/common_widget/user_tile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController searchTEController = TextEditingController();
  final SearchUserController controller = Get.find<SearchUserController>();

  void searchUser(String? name) async {
    if (name != null) {
      controller.searchUser(name);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomRadialBackground(
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              floating: true,
              snap: true,
              pinned: true,
              expandedHeight: GetPlatform.isIOS ? 110 : 105,
              collapsedHeight: GetPlatform.isIOS ? 90 : 80,
              centerTitle: false,
              title: const Text(
                'Search',
                style: TextStyle(fontSize: 32, fontWeight: FontWeight.w500),
              ),
              bottom: PreferredSize(
                preferredSize: const Size.fromHeight(60),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10.0,
                    vertical: 10,
                  ),
                  child: SearchInput(
                    controller: searchTEController,
                    hintText: 'Search user',
                    callback: searchUser,
                  ),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Obx(
                () => controller.loading.value
                    ? const CustomCircularProgressIndicator()
                    : Column(
                        children: [
                          if (controller.users.isNotEmpty)
                            ListView.separated(
                              itemCount: controller.users.length,
                              shrinkWrap: true,
                              physics: const BouncingScrollPhysics(),
                              itemBuilder: (context, index) =>
                                  UserTile(user: controller.users[index]),
                              separatorBuilder: (context, index) =>
                                  const Divider(color: Color(0xff242424)),
                            )
                          else if (controller.users.isEmpty &&
                              controller.notFound.value == true)
                            const Text('No user found')
                          else
                            const LottieSearchWidget(),
                        ],
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
