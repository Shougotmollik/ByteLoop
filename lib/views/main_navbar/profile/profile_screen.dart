import 'package:byteloop/controllers/profile_controller.dart';
import 'package:byteloop/routes/route_names.dart';
import 'package:byteloop/services/supabase_service.dart';
import 'package:byteloop/utils/styles/button_styles.dart';
import 'package:byteloop/views/widgets/nav_bar/common_widget/custom_circular_progress_indicator.dart';
import 'package:byteloop/views/widgets/nav_bar/common_widget/custom_radial_background.dart';
import 'package:byteloop/views/widgets/nav_bar/common_widget/query_card.dart';
import 'package:byteloop/views/widgets/nav_bar/profile/custom_circle_avatar.dart';
import 'package:byteloop/views/widgets/nav_bar/profile/sliver_app_delegate.dart';
import 'package:byteloop/views/widgets/nav_bar/profile/user_reply_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final ProfileController profileController = Get.find<ProfileController>();
  final SupabaseService supabaseService = Get.find<SupabaseService>();

  @override
  void initState() {
    super.initState();
    if (supabaseService.currentUser.value?.id != null) {
      profileController.fetchUserQuery(supabaseService.currentUser.value!.id);
      profileController.fetchUserReplies(supabaseService.currentUser.value!.id);
    }
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
                  expandedHeight: 160,
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
                                    Text(
                                      supabaseService
                                          .currentUser
                                          .value!
                                          .userMetadata?['name'],
                                      style: const TextStyle(
                                        fontSize: 24,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    SizedBox(
                                      width: context.width * 0.60,
                                      child: Text(
                                        supabaseService
                                                .currentUser
                                                .value!
                                                .userMetadata?["description"] ??
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
                                  url: supabaseService
                                      .currentUser
                                      .value
                                      ?.userMetadata?['image'],
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 12),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: OutlinedButton(
                                  style: customOutlineStyle(),
                                  onPressed: () {
                                    Get.toNamed(RouteNames.editProfileScreen);
                                  },
                                  child: const Text('Edit Profile'),
                                ),
                              ),
                              const SizedBox(width: 20),
                              Expanded(
                                child: OutlinedButton(
                                  style: customOutlineStyle(),
                                  onPressed: () {},
                                  child: const Text('Share Profile'),
                                ),
                              ),
                            ],
                          ),
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
                return QueryCard(
                  query: profileController.queries[index],
                  isAuthCard: true,
                  callback: profileController.deleteQuery,
                );
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
