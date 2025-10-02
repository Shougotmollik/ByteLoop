import 'package:byteloop/controllers/settings_controller.dart';
import 'package:byteloop/model/bottom_sheet_item_model.dart';
import 'package:byteloop/services/supabase_service.dart';
import 'package:byteloop/utils/helper.dart';
import 'package:byteloop/views/widgets/nav_bar/common_widget/custom_radial_background.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final SettingsController settingsController =
        Get.find<SettingsController>();
    final SupabaseService supabaseService = Get.find<SupabaseService>();
    return Scaffold(
      appBar: _buildAppBar(),
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.transparent,

      body: CustomRadialBackground(
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            children: [
              const Spacer(),
              Column(
                children: [
                  ListTile(
                    leading: const Icon(
                      Icons.switch_account_outlined,
                      color: Colors.purpleAccent,
                    ),
                    title: const Text(
                      'Switch accounts',
                      style: TextStyle(color: Colors.purpleAccent),
                    ),
                    trailing: const Icon(
                      Icons.arrow_forward_outlined,
                      color: Colors.purpleAccent,
                    ),
                    onTap: () {
                      showCustomBottomSheet(
                        items: [
                          BottomSheetItemModel(
                            title: supabaseService
                                .currentUser
                                .value!
                                .userMetadata?['name'],
                            onTap: () {},
                          ),
                          BottomSheetItemModel(
                            title: 'Add Profile',
                            icon: Iconsax.user_cirlce_add,
                            onTap: () {},
                          ),
                        ],
                      );
                    },
                  ),
                  ListTile(
                    leading: const Icon(
                      Icons.logout_rounded,
                      color: Colors.redAccent,
                    ),
                    title: const Text(
                      'Logout',
                      style: TextStyle(color: Colors.redAccent),
                    ),
                    trailing: const Icon(
                      Icons.arrow_forward_outlined,
                      color: Colors.redAccent,
                    ),
                    onTap: () {
                      showConfirmDialog(
                        title: 'Are your sure?',
                        text: 'This action logout from Byteloop',
                        onTap: () => settingsController.logOut(),
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
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
      title: const Text('Settings'),
    );
  }
}
