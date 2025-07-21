import 'package:byteloop/constant/app_colors.dart';
import 'package:byteloop/controllers/query_controller.dart';
import 'package:byteloop/services/nav_bar_service.dart';
import 'package:byteloop/services/supabase_service.dart';
import 'package:byteloop/views/main_navbar/query/add_query_app_bar.dart';
import 'package:byteloop/views/main_navbar/query/image_preview.dart';
import 'package:byteloop/views/main_navbar/query/video_preview.dart';
import 'package:byteloop/views/widgets/nav_bar/common_widget/custom_radial_background.dart';
import 'package:byteloop/views/widgets/nav_bar/profile/custom_circle_avatar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddQueryScreen extends StatefulWidget {
  const AddQueryScreen({super.key});

  @override
  State<AddQueryScreen> createState() => _AddQueryScreenState();
}

class _AddQueryScreenState extends State<AddQueryScreen> {
  final SupabaseService supabaseService = Get.find<SupabaseService>();
  final QueryController queryController = Get.find<QueryController>();
  final NavBarService navBarService = Get.find<NavBarService>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomRadialBackground(
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(18.0),
              child: Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      AddQueryAppBar(
                        tapCloseQuery: () =>
                            navBarService.backToPreviousScreen(),
                      ),
                      Obx(
                        () => IconButton(
                          onPressed: () {
                            if (queryController.content.value.isNotEmpty) {
                              queryController.store(
                                supabaseService.currentUser.value!.id,
                              );
                            }
                          },
                          icon: queryController.loading.value
                              ? const SizedBox(
                                  height: 20,
                                  width: 20,
                                  child: CircularProgressIndicator(
                                    color: AppColors.purpleBgColor,
                                  ),
                                )
                              : Icon(
                                  Icons.send_outlined,
                                  size: 22,
                                  color:
                                      queryController.content.value.isNotEmpty
                                      ? Colors.white
                                      : Colors.white24,
                                ),
                        ),
                      ),
                    ],
                  ),
                  const Divider(color: Colors.white24, thickness: 0.75),
                  const SizedBox(height: 4.0),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: 12,
                    children: [
                      Obx(
                        () => CustomCircleAvatar(
                          url: supabaseService
                              .currentUser
                              .value!
                              .userMetadata?['image'],
                        ),
                      ),

                      SizedBox(
                        width: context.width * 0.75,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Obx(
                              () => Text(
                                supabaseService
                                    .currentUser
                                    .value
                                    ?.userMetadata?['name'],
                                style: const TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16,
                                  color: Colors.white,
                                ),
                              ),
                            ),

                            _buildInputQuerySection(),
                            _buildAssetsSelectionBtn(),

                            // To preview selected Assets section
                            Obx(() {
                              if (queryController.isPicking.value) {
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              }
                              return _buildAssetsPreviewSection();
                            }),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAssetsSelectionBtn() {
    return Obx(() {
      final isPicking = queryController.isPicking.value;

      return Row(
        children: [
          IconButton(
            onPressed: isPicking ? null : () => queryController.pickImage(),
            icon: const Icon(
              Icons.perm_media_outlined,
              color: Colors.white54,
              size: 26,
            ),
          ),
          IconButton(
            onPressed: isPicking ? null : () => queryController.pickVideo(),
            icon: const Icon(
              Icons.video_camera_back_outlined,
              color: Colors.white54,
              size: 28,
            ),
          ),
        ],
      );
    });
  }

  Widget _buildAssetsPreviewSection() {
    return Column(
      children: [
        Obx(() {
          final img = queryController.image.value;
          if (img != null) {
            return ImagePreview(
              image: img,
              onRemove: () => queryController.image.value = null,
            );
          }
          return const SizedBox.shrink();
        }),
        const SizedBox(height: 12),
        Obx(() {
          final vid = queryController.video.value;

          if (vid != null) {
            return VideoPreview(
              video: vid,
              onRemove: () => queryController.video.value = null,
            );
          }
          return const SizedBox.shrink();
        }),
      ],
    );
  }

  Widget _buildInputQuerySection() {
    return TextFormField(
      autofocus: true,
      controller: queryController.queryTEController,
      onChanged: (value) => queryController.content.value = value,
      maxLines: 8,
      minLines: 1,
      maxLength: 1000,
      style: const TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.w400,
        color: Colors.white,
      ),
      decoration: const InputDecoration(
        hintText: 'Start a query',
        hintStyle: TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w400,
          color: Colors.white38,
        ),
        border: InputBorder.none,
      ),
    );
  }
}
