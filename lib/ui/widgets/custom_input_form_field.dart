import 'package:flutter/material.dart';
import 'package:prodel_admin/values/colors.dart';

class CustomInputFormField extends StatelessWidget {
  final TextEditingController controller;
  final Function(String?)? validator;
  final Widget? suffixIcon;
  final IconData? prefixIcon;
  final String hintText;
  final int maxLines;
  final bool isObscure;
  const CustomInputFormField({
    super.key,
    required this.controller,
    required this.validator,
    this.suffixIcon,
    this.prefixIcon,
    required this.hintText,
    this.maxLines = 1,
    this.isObscure = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLines: maxLines,
      controller: controller,
      obscureText: isObscure,
      validator: (value) => validator!(value),
      decoration: InputDecoration(
        prefixIcon: Icon(
          prefixIcon,
          color: primaryColor,
        ),
        filled: true,
        fillColor: primaryColor.withOpacity(0.1),
        hintText: hintText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide.none,
        ),
        suffixIcon: suffixIcon,
      ),
    );
  }
}
