import 'package:flutter/material.dart';

final primaryColor = Color(0xFFF82B10);
final themeData = ThemeData(
  dividerTheme: DividerThemeData(color: Colors.grey.withValues(alpha: 0.1)),
  colorScheme: ColorScheme.fromSeed(seedColor: primaryColor),
  scaffoldBackgroundColor: Color(0xFFEFF1F3),
  primaryColor: primaryColor,
  textTheme: TextTheme(
    titleMedium: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: primaryColor,
      foregroundColor: Colors.white,
      elevation: 8,
      shadowColor: Colors.black.withValues(alpha: 0.3),
      padding: EdgeInsets.symmetric(
        horizontal: 32,
        vertical: 16,
      ), // Внутренние отступы
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16), // Скругление
      ),
      textStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
    ),
  ),
);
