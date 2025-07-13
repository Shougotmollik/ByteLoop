import 'package:byteloop/views/widgets/nav_bar/common_widget/custom_radial_background.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
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
                Stack(
                  alignment: Alignment.topRight,
                  children: [
                    const CircleAvatar(
                      radius: 58,
                      backgroundImage: NetworkImage(
                        'https://www.pngall.com/wp-content/uploads/12/Avatar-Profile-PNG-Photos.png',
                      ),
                    ),
                    IconButton(
                      onPressed: () {},
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

                const SizedBox(height: 28),

                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: TextFormField(
                    maxLines: 4,
                    decoration: InputDecoration(
                      hintText: 'Your Description ...',
                      hintStyle: const TextStyle(
                        fontSize: 18,
                        color: Colors.grey,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ),
              ],
            ),
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
      title: const Text('Profile'),
      actions: [TextButton(onPressed: () {}, child: const Text('Done'))],
    );
  }
}
