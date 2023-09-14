import 'package:flutter/material.dart';

import '../../common/theme/app_theme.dart';

class CustomButton extends StatelessWidget {
  final String buttonText;
  final Function onTap;
  const CustomButton({super.key, required this.buttonText, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: ()=> onTap(),
      style: ElevatedButton.styleFrom(
        elevation: 5,
        backgroundColor: buttonColor,
        foregroundColor: buttonTextColor,
        padding: const EdgeInsets.symmetric(vertical: 10)
      ),
      child: Text(buttonText, style: const TextStyle(fontSize: 24))
    );
  }
}
