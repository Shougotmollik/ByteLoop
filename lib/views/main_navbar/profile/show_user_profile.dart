import 'package:byteloop/controllers/profile_controller.dart';
import 'package:byteloop/routes/route_names.dart';
import 'package:byteloop/views/widgets/nav_bar/common_widget/custom_circular_progress_indicator.dart';
import 'package:byteloop/views/widgets/nav_bar/common_widget/custom_radial_background.dart';
import 'package:byteloop/views/widgets/nav_bar/common_widget/query_card.dart';
import 'package:byteloop/views/widgets/nav_bar/profile/custom_circle_avatar.dart';
import 'package:byteloop/views/widgets/nav_bar/profile/sliver_app_delegate.dart';
import 'package:byteloop/views/widgets/nav_bar/profile/user_reply_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ShowUserProfile extends StatefulWidget {
  const ShowUserProfile({super.key});

  @override
  State<ShowUserProfile> createState() => _ShowUserProfileState();
}

class _ShowUserProfileState extends State<ShowUserProfile> {
  final ProfileController profileController = Get.find<ProfileController>();
  final String userId = Get.arguments;

  @override
  void initState() {
    super.initState();
    profileController.fetchUserProfile(userId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(Icons.language_outlined),
        ),
        actions: [
          IconButton(
            onPressed: () => Get.toNamed(RouteNames.settingsScreens),
            icon: const Icon(Icons.sort_sharp),
          ),
        ],
      ),
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.transparent,
      body: CustomRadialBackground(
        child: DefaultTabController(
          length: 2,
          child: NestedScrollView(
            headerSliverBuilder: (context, innerBoxIsScrolled) {
              return <Widget>[
                SliverAppBar(
                  expandedHeight: 120,
                  collapsedHeight: 80,
                  automaticallyImplyLeading: false,
                  flexibleSpace: FlexibleSpaceBar(
                    background: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Column(
                        children: [
                          Obx(
                            () => Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    if (profileController.userLoading.value)
                                      const CustomCircularProgressIndicator()
                                    else
                                      Text(
                                        profileController
                                            .user
                                            .value
                                            .metadata!
                                            .name!,
                                        style: const TextStyle(
                                          fontSize: 24,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    SizedBox(
                                      width: context.width * 0.60,
                                      child: Text(
                                        profileController
                                                .user
                                                .value
                                                .metadata
                                                ?.description ??
                                            "Welcome to byteLoop🙂.Add your description📋",
                                        style: const TextStyle(
                                          color: Colors.white60,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                CustomCircleAvatar(
                                  radius: 48,
                                  url: profileController
                                      .user
                                      .value
                                      .metadata
                                      ?.image,
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 12),
                        ],
                      ),
                    ),
                  ),
                ),

                SliverPersistentHeader(
                  floating: true,
                  pinned: true,
                  delegate: SliverAppBarDelegate(
                    const TabBar(
                      indicatorSize: TabBarIndicatorSize.tab,
                      indicatorWeight: 2.5,
                      tabs: [
                        Tab(text: 'Queries'),
                        Tab(text: 'Replies'),
                      ],
                    ),
                  ),
                ),
              ];
            },
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 0),
              child: TabBarView(
                children: [_buildQuerySection(), _buildReplySection()],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildQuerySection() {
    return Obx(
      () => profileController.queryLoading.value
          ? const CustomCircularProgressIndicator()
          : profileController.queries.isEmpty
          ? const Center(child: Text("No queries found"))
          : ListView.builder(
              padding: const EdgeInsets.only(top: 10),
              itemCount: profileController.queries.length,
              itemBuilder: (context, index) {
                return QueryCard(query: profileController.queries[index]);
              },
            ),
    );
  }

  Widget _buildReplySection() {
    return Obx(
      () => profileController.replyLoading.value
          ? const CustomCircularProgressIndicator()
          : profileController.replies.isEmpty
          ? const Center(child: Text("No repiles found"))
          : ListView.builder(
              padding: const EdgeInsets.only(top: 10),
              itemCount: profileController.replies.length,
              shrinkWrap: true,
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    Get.toNamed(
                      RouteNames.showQueryScreen,
                      arguments: profileController.replies[index].postId,
                    );
                  },
                  child: UserReplyCard(
                    userReply: profileController.replies[index],
                  ),
                );
              },
            ),
    );
  }
}
