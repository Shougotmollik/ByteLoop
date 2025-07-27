import 'package:byteloop/controllers/notification_controller.dart';
import 'package:byteloop/services/supabase_service.dart';
import 'package:byteloop/views/widgets/nav_bar/common_widget/custom_circular_progress_indicator.dart';
import 'package:byteloop/views/widgets/nav_bar/common_widget/custom_radial_background.dart';
import 'package:byteloop/views/widgets/nav_bar/profile/custom_circle_avatar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:timeago/timeago.dart' as timeago;

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  final NotificationController notificationController =
      Get.find<NotificationController>();
  final SupabaseService supabaseService = Get.find<SupabaseService>();

  @override
  void initState() {
    super.initState();

    notificationController.fetchNotifications(
      supabaseService.currentUser.value!.id,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.transparent,

      body: CustomRadialBackground(
        child: SingleChildScrollView(
          child: Obx(
            () => notificationController.loading.value
                ? const CustomCircularProgressIndicator()
                : notificationController.notifications.isNotEmpty
                ? ListView.builder(
                    shrinkWrap: true,
                    physics: const BouncingScrollPhysics(),
                    itemCount: notificationController.notifications.length,
                    itemBuilder: (context, index) => ListTile(
                      leading: CustomCircleAvatar(
                        url: notificationController
                            .notifications[index]
                            .user
                            ?.metadata
                            ?.image,
                      ),

                      title: Text(
                        notificationController
                            .notifications[index]
                            .user!
                            .metadata!
                            .name!,
                      ),
                      subtitle: Text(
                        notificationController
                            .notifications[index]
                            .notification!,
                        style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 14,
                        ),
                      ),
                      trailing: Text(
                        timeago.format(
                          DateTime.parse(
                            notificationController
                                .notifications[index]
                                .createdAt!,
                          ),
                        ),
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  )
                : const Center(child: Text('No notifications found!')),
          ),
        ),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: const Text(
        'Notifications',
        style: TextStyle(fontSize: 32, fontWeight: FontWeight.w500),
      ),
    );
  }
}
