import 'package:flutter/material.dart';

import 'AppColors.dart';

ThemeData themeEnglish = ThemeData(
    primaryColor: AppColors.primaryColor,
    useMaterial3: true,
    appBarTheme: const AppBarTheme(color: AppColors.primaryColor),
    textTheme: const TextTheme(
        displayLarge: TextStyle(
            fontFamily: "Almarai", fontWeight: FontWeight.bold, fontSize: 20),
        bodyLarge: TextStyle(fontFamily: "Almarai", height: 1.5)));

ThemeData themeArabic = ThemeData(
    primaryColor: AppColors.primaryColor,
    useMaterial3: true,
    appBarTheme: const AppBarTheme(color: AppColors.primaryColor),
    textTheme: const TextTheme(
        displayLarge: TextStyle(
            fontFamily: "Cairo", fontWeight: FontWeight.bold, fontSize: 20),
        bodyLarge: TextStyle(fontFamily: "Cairo", height: 1.5)));
