import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return const SliverAppBar(
      title: Text(
        'Home',
        style: TextStyle(fontSize: 32, fontWeight: FontWeight.w500),
      ),
    );
  }
}
