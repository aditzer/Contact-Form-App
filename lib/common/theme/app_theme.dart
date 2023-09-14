import 'package:flutter/material.dart';

const Color primaryColor = Colors.indigo;

const Color buttonColor = Colors.white;
const Color buttonTextColor = primaryColor;

ThemeData appTheme = ThemeData(
    colorScheme: ColorScheme.fromSeed(seedColor: primaryColor),
    useMaterial3: true,
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.indigo,
      foregroundColor: Colors.white,
      iconTheme: IconThemeData(color: Colors.white),
      centerTitle: true,
      elevation: 15,
    )
);