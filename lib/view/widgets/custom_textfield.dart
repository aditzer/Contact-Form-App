import 'package:flutter/material.dart';

import '../../common/theme/app_theme.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final IconData iconData;
  const CustomTextField({super.key, required this.controller, required this.hintText, required this.iconData});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      cursorColor: primaryColor,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        prefixIcon: Icon(iconData,color: primaryColor),
        hintText: hintText,
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(100),
            borderSide: const BorderSide(color: primaryColor)
        ),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(100),
            borderSide: const BorderSide(color: primaryColor)
        ),
      ),
    );
  }
}
