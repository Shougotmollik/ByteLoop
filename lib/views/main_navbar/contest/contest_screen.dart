import 'package:byteloop/constant/app_colors.dart';
import 'package:byteloop/controllers/contest_controller.dart';
import 'package:byteloop/views/main_navbar/contest/contest_details_screen.dart';
import 'package:byteloop/views/widgets/nav_bar/common_widget/custom_radial_background.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:timeago/timeago.dart' as timeago;

class ContestScreen extends StatelessWidget {
  const ContestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ContestController controller = Get.find<ContestController>();
    return Scaffold(
      appBar: AppBar(title: const Text("Codeforces Contests")),
      extendBodyBehindAppBar: true,
      body: CustomRadialBackground(
        child: Obx(() {
          if (controller.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          }
          if (controller.errorMessage.isNotEmpty) {
            return Center(child: Text(controller.errorMessage.value));
          }
          if (controller.contests.isEmpty) {
            return const Center(child: Text("No contests available"));
          }

          return ListView.builder(
            itemCount: controller.contests.length,
            itemBuilder: (context, index) {
              final contest = controller.contests[index];

              int seconds = contest.durationSeconds;
              DateTime endTime = DateTime.now().subtract(
                Duration(seconds: seconds),
              );
              return Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 8,
                ),
                child: GestureDetector(
                  onTap: () => Get.to(ContestDetailsScreen(contest: contest)),
                  child: Container(
                    padding: const EdgeInsets.only(right: 8),
                    decoration: BoxDecoration(
                      color: AppColors.authBgColor.withAlpha(122),
                      borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(12),
                        bottomLeft: Radius.circular(12),
                      ),
                    ),
                    child: Row(
                      spacing: 12,
                      children: [
                        ClipRRect(
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(12),
                            bottomRight: Radius.circular(12),
                          ),
                          child: Image.network(
                            contest.iconLogo,
                            height: context.height * 0.15,
                            width: context.width * 0.3,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                contest.name,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: 6),
                              Text(
                                "PHASE ${contest.phase.toUpperCase()}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: contest.phase.toUpperCase() == 'BEFORE'
                                      ? Colors.green
                                      : contest.phase.toUpperCase() == 'CODING'
                                      ? Colors.orange
                                      : contest.phase.toUpperCase() ==
                                            'FINISHED'
                                      ? Colors.red
                                      : Colors.white70,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),

                              const SizedBox(height: 6),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    contest.type,
                                    style: const TextStyle(
                                      fontSize: 14,
                                      color: Colors.white60,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  Text(
                                    timeago.format(endTime, allowFromNow: true),
                                    style: const TextStyle(
                                      fontSize: 12,
                                      color: Colors.white60,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        }),
      ),
    );
  }
}
