import 'package:flutter/material.dart';

class AddQueryScreen extends StatefulWidget {
  const AddQueryScreen({super.key});

  @override
  State<AddQueryScreen> createState() => _AddQueryScreenState();
}

class _AddQueryScreenState extends State<AddQueryScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Query'),
      ),
    );
  }
}
