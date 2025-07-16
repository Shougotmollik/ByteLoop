import 'package:byteloop/controllers/profile_controller.dart';
import 'package:byteloop/services/supabase_service.dart';
import 'package:byteloop/views/widgets/nav_bar/common_widget/custom_radial_background.dart';
import 'package:byteloop/views/widgets/nav_bar/profile/custom_circle_avatar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final ProfileController _profileController = Get.find<ProfileController>();
  final SupabaseService supabaseService = Get.find<SupabaseService>();

  final TextEditingController _nameTEController = TextEditingController();
  final TextEditingController _descriptionTEController =
      TextEditingController();

  @override
  void initState() {
    var data = supabaseService.currentUser.value?.userMetadata;
    if (data?['name'] != null && data?['description'] != null) {
      _nameTEController.text = data?['name'];
      _descriptionTEController.text = data?['description'];
    }

    super.initState();
  }

  @override
  void dispose() {
    _descriptionTEController.dispose();
    _nameTEController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.transparent,
      body: CustomRadialBackground(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 18.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Obx(
                  () => Stack(
                    alignment: Alignment.topRight,
                    children: [
                      CustomCircleAvatar(
                        radius: 80,
                        file: _profileController.image.value,
                        url: supabaseService
                            .currentUser
                            .value
                            ?.userMetadata?['image'],
                      ),
                      IconButton(
                        onPressed: () {
                          _profileController.pickImage();
                        },
                        icon: const CircleAvatar(
                          radius: 18,
                          backgroundColor: Colors.white70,
                          child: Icon(
                            Iconsax.gallery_edit_copy,
                            color: Colors.black87,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 28),

                _buildTextFormFieldSection(
                  hintText: 'Username',
                  maxLines: 1,
                  controller: _nameTEController,
                ),
                const SizedBox(height: 12),
                _buildTextFormFieldSection(
                  hintText: 'Your Description',
                  maxLines: 4,
                  controller: _descriptionTEController,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextFormFieldSection({
    required String hintText,
    required int maxLines,
    required TextEditingController controller,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
      child: TextFormField(
        controller: controller,
        maxLines: maxLines,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: const TextStyle(fontSize: 18, color: Colors.grey),

          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        ),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      leading: IconButton(
        onPressed: () {
          Get.back();
        },
        icon: const Icon(Icons.arrow_back_ios),
      ),
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      title: const Text('Profile'),
      actions: [
        Obx(
          () => TextButton(
            onPressed: () {
              _profileController.updateProfile(
                supabaseService.currentUser.value!.id,
                _nameTEController.text,
                _descriptionTEController.text,
              );
            },
            child: _profileController.loading.value
                ? const SizedBox(
                    height: 14,
                    width: 14,
                    child: CircularProgressIndicator(color: Colors.deepPurple),
                  )
                : const Text('Done'),
          ),
        ),
      ],
    );
  }
}
