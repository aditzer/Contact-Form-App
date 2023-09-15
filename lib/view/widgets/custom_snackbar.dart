import 'package:contact_form_app/common/theme/app_theme.dart';
import 'package:flutter/material.dart';

// custom snackBar
SnackBar customSnackBar(String snackBarMessage){
  return SnackBar(
      content: Text(snackBarMessage, style: const TextStyle(color: primaryColor, fontWeight: FontWeight.bold)),
      backgroundColor: Colors.white,
      elevation: 10
  );
}
