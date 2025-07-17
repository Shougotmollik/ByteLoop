import 'package:byteloop/controllers/query_controller.dart';
import 'package:byteloop/services/nav_bar_service.dart';
import 'package:byteloop/services/supabase_service.dart';
import 'package:byteloop/views/main_navbar/query/add_query_app_bar.dart';
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
                children: [
                  AddQueryAppBar(
                    tapCloseQuery: () => navBarService.selectedHomeScreen(),
                    tapPost: () {},
                  ),
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
                            Obx(() => _buildAssetsPreviewSection()),
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
    return IconButton(
      onPressed: () => queryController.pickImage(),
      icon: const Icon(Icons.attachment, color: Colors.white, size: 28),
    );
  }

  Widget _buildAssetsPreviewSection() {
    return Column(
      children: [
        if (queryController.image.value != null)
          Stack(
            alignment: Alignment.topRight,
            children: [
              ClipRRect(
                borderRadius: BorderRadiusGeometry.circular(10),
                child: Image.file(
                  queryController.image.value!,
                  fit: BoxFit.cover,
                  alignment: Alignment.topCenter,
                ),
              ),
              Positioned(
                right: 8,
                top: 8,
                child: CircleAvatar(
                  backgroundColor: Colors.black45,
                  child: IconButton(
                    onPressed: () {
                      queryController.image.value = null;
                    },
                    icon: const Icon(
                      Icons.close_rounded,
                      color: Colors.white,
                      weight: 50,
                    ),
                  ),
                ),
              ),
            ],
          ),
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
