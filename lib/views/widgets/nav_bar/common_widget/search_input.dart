import 'package:byteloop/utils/type_def.dart';
import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class SearchInput extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final InputCallback callback;

  const SearchInput({
    super.key,
    required this.controller,
    required this.hintText,
    required this.callback,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            offset: const Offset(12, 26),
            blurRadius: 50,
            spreadRadius: 0,
            color: Colors.grey.withAlpha(26),
          ),
        ],
      ),
      child: TextFormField(
        controller: controller,
        onChanged: callback,
        decoration: InputDecoration(
          prefixIcon: const Icon(
            Iconsax.search_normal_1_copy,
            color: Color(0xff616161),
            size: 22,
          ),
          filled: true,
          fillColor: const Color(0xff262626),
          hintText: hintText,
          hintStyle: const TextStyle(color: Color(0xff616161)),
          contentPadding: const EdgeInsets.symmetric(
            vertical: 10.0,
            horizontal: 20.0,
          ),
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(12.0)),
          ),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xff616161), width: 1.0),
            borderRadius: BorderRadius.all(Radius.circular(12.0)),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xff616161), width: 2.0),
            borderRadius: BorderRadius.all(Radius.circular(12.0)),
          ),
        ),
      ),
    );
  }
}
