import 'package:flutter/material.dart';

class AuthTextFormField extends StatefulWidget {
  const AuthTextFormField({
    super.key,
    required this.hintText,
    required this.prefixIcon,
    this.showToggle = false,
    required this.textEditingController,
    this.validator,
  });

  final String hintText;
  final IconData prefixIcon;
  final bool showToggle;
  final TextEditingController textEditingController;
  final String? Function(String?)? validator;

  @override
  State<AuthTextFormField> createState() => _AuthTextFormFieldState();
}

class _AuthTextFormFieldState extends State<AuthTextFormField> {
  bool _obscureText = true;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xff1E1E1E),
        borderRadius: BorderRadius.circular(12),
      ),
      child: TextFormField(
        obscureText: widget.showToggle ? _obscureText : !_obscureText,
        controller: widget.textEditingController,
        validator: widget.validator,
        style: const TextStyle(
          fontSize: 18,
          color: Colors.white,
          letterSpacing: 0.5,
          height: 1.2,
          fontWeight: FontWeight.w400,
        ),
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(
            vertical: 18,
            horizontal: 12,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          prefixIcon: Icon(widget.prefixIcon),
          hintText: widget.hintText,
          hintStyle: const TextStyle(
            fontSize: 15,
            color: Colors.white70,
            fontWeight: FontWeight.w400,
            wordSpacing: 2,
            letterSpacing: 1.2,
          ),
          suffixIcon: widget.showToggle
              ? IconButton(
                  onPressed: () {
                    setState(() {
                      _obscureText = !_obscureText;
                    });
                  },
                  icon: Icon(
                    _obscureText ? Icons.visibility_off : Icons.visibility,
                  ),
                )
              : null,
          floatingLabelBehavior: FloatingLabelBehavior.never,
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
}
