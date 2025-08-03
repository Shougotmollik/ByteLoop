import 'package:byteloop/constant/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ConfirmDialog extends StatelessWidget {
  const ConfirmDialog({
    super.key,
    required this.title,
    required this.text,
    required this.onTap,
  });

  final String title, text;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Container(
        width: MediaQuery.of(context).size.width / 1.4,
        height: MediaQuery.of(context).size.height / 4,
        decoration: BoxDecoration(
          color: AppColors.bgColor,
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CircleAvatar(
              backgroundColor: Colors.redAccent,
              radius: 25,
              child: Icon(
                Icons.error_outline_outlined,
                color: Colors.white,
                size: 50,
              ),
            ),
            const SizedBox(height: 15),
            Text(
              title,
              style: const TextStyle(
                color: Colors.red,
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 3.5),
            Text(
              text,
              style: const TextStyle(
                color: Colors.white70,
                fontSize: 15,
                fontWeight: FontWeight.w400,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ActionButton(text: "Allow", onPressed: onTap),
                ActionButton(
                  text: "Deny",
                  onPressed: () {
                    Get.back();
                  },
                  invertedColors: true,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class ActionButton extends StatelessWidget {
  final String text;
  final Function() onPressed;
  final bool invertedColors;

  const ActionButton({
    required this.text,
    required this.onPressed,
    this.invertedColors = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        elevation: WidgetStateProperty.all(0),
        alignment: Alignment.center,
        side: WidgetStateProperty.all(
          const BorderSide(width: 1, color: AppColors.purpleBgColor),
        ),
        padding: WidgetStateProperty.all(
          const EdgeInsets.only(right: 25, left: 25, top: 0, bottom: 0),
        ),
        backgroundColor: WidgetStateProperty.all(
          invertedColors ? Colors.green : AppColors.purpleBgColor,
        ),
        shape: WidgetStateProperty.all(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        ),
      ),
      onPressed: onPressed,
      child: Text(
        text,
        style: TextStyle(
          color: invertedColors
              ? AppColors.purpleBgColor
              : AppColors.whiteColor,
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
