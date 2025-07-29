import 'package:byteloop/controllers/query_controller.dart';
import 'package:byteloop/views/widgets/nav_bar/common_widget/custom_circular_progress_indicator.dart';
import 'package:byteloop/views/widgets/nav_bar/common_widget/custom_radial_background.dart';
import 'package:byteloop/views/widgets/nav_bar/common_widget/query_card.dart';
import 'package:byteloop/views/widgets/nav_bar/profile/user_reply_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ShowQueryScreen extends StatefulWidget {
  const ShowQueryScreen({super.key});

  @override
  State<ShowQueryScreen> createState() => _ShowQueryScreenState();
}

class _ShowQueryScreenState extends State<ShowQueryScreen> {
  final int postId = Get.arguments;
  final QueryController queryController = Get.find<QueryController>();

  @override
  void initState() {
    super.initState();
    queryController.showQuery(postId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.transparent,
      body: CustomRadialBackground(
        child: Obx(
          () => queryController.showQueryLoading.value
              ? const CustomCircularProgressIndicator()
              : SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Column(
                      children: [
                        QueryCard(query: queryController.queries.value),
                        const SizedBox(height: 8),
                        queryController.showReplyLoading.value
                            ? const CustomCircularProgressIndicator()
                            : queryController.replies.isEmpty
                            ? const Center(child: Text("No repiles found"))
                            : ListView.builder(
                                itemCount: queryController.replies.length,
                                shrinkWrap: true,
                                physics: const BouncingScrollPhysics(),
                                itemBuilder: (context, index) {
                                  return UserReplyCard(
                                    userReply: queryController.replies[index],
                                  );
                                },
                              ),
                      ],
                    ),
                  ),
                ),
        ),
      ),
    );
  }
}
