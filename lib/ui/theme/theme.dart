import 'package:flutter/material.dart';

const Color kPrimaryColor = Color(0xFFF82B10);
const Color kScaffoldLight = Color(0xFFEFF1F3);
const Color kCardLight = Color(0xFFFFFFFF);
const Color kScaffoldDark = Color(0xFF0F1117);
const Color kCardDark = Color(0xFF1A1D24);
const Color kSurfaceLight = Color(0xFFF8FAFC);
const Color kSurfaceDark = Color(0xFF1A1D24);
const Color kSurfaceVariantDark = Color(0xFF242832);

const TextTheme _kTextTheme = TextTheme(
  titleMedium: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
  bodyLarge: TextStyle(fontSize: 16, height: 1.6),
  bodyMedium: TextStyle(fontSize: 14),
  labelLarge: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
);

ElevatedButtonThemeData _buttonThemeData() => ElevatedButtonThemeData(
  style: ElevatedButton.styleFrom(
    backgroundColor: kPrimaryColor,
    foregroundColor: Colors.white,
    elevation: 8,
    shadowColor: Colors.black.withValues(alpha: 0.3),
    padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
  ),
);

FilledButtonThemeData _filledButtonThemeData() => FilledButtonThemeData(
  style: FilledButton.styleFrom(
    backgroundColor: kPrimaryColor,
    foregroundColor: Colors.white,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
  ),
);

final ThemeData lightTheme = ThemeData(
  useMaterial3: true,
  brightness: Brightness.light,

  colorScheme: ColorScheme.fromSeed(
    seedColor: kPrimaryColor,
    brightness: Brightness.light,
    primaryContainer: kPrimaryColor.withValues(alpha: 0.1),
  ).copyWith(surface: kSurfaceLight, surfaceContainerHighest: kSurfaceLight),

  scaffoldBackgroundColor: kScaffoldLight,
  primaryColor: kPrimaryColor,
  cardColor: kCardLight,
  cardTheme: CardThemeData(
    color: kCardLight,
    elevation: 2,
    shadowColor: Colors.black.withValues(alpha: 0.1),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
  ),

  textTheme: _kTextTheme,
  dividerTheme: const DividerThemeData(
    color: Color(0xFFE0E0E0),
    thickness: 1,
    space: 16,
  ),

  elevatedButtonTheme: _buttonThemeData(),
  filledButtonTheme: _filledButtonThemeData(),

  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: kSurfaceLight,
    selectedItemColor: kPrimaryColor,
    unselectedItemColor: Colors.grey.shade600,
    type: BottomNavigationBarType.fixed,
    elevation: 8,
    showSelectedLabels: true,
    showUnselectedLabels: true,
    selectedLabelStyle: const TextStyle(fontWeight: FontWeight.w600),
  ),

  appBarTheme: AppBarTheme(
    backgroundColor: kScaffoldLight,
    foregroundColor: Colors.black87,
    elevation: 0,
    shadowColor: Colors.transparent,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
    ),
  ),
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor: kPrimaryColor,
    foregroundColor: Colors.white,
    elevation: 6,
    shape: const CircleBorder(),
  ),
);

final ThemeData darkTheme = ThemeData(
  useMaterial3: true,
  brightness: Brightness.dark,

  colorScheme:
      ColorScheme.fromSeed(
        seedColor: kPrimaryColor,
        brightness: Brightness.dark,
      ).copyWith(
        surface: kSurfaceDark,
        surfaceContainerHighest: kSurfaceVariantDark,
        primaryContainer: kPrimaryColor.withValues(alpha: 0.2),
      ),

  scaffoldBackgroundColor: kScaffoldDark,
  primaryColor: kPrimaryColor,
  cardColor: kCardDark,
  cardTheme: CardThemeData(
    color: kCardDark,
    elevation: 4,
    shadowColor: Colors.black.withValues(alpha: 0.5),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
  ),

  textTheme: _kTextTheme,
  dividerTheme: const DividerThemeData(
    color: Color(0xFF2A2D38),
    thickness: 1,
    space: 16,
  ),

  elevatedButtonTheme: _buttonThemeData(),
  filledButtonTheme: _filledButtonThemeData(),

  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: kSurfaceDark,
    selectedItemColor: kPrimaryColor,
    unselectedItemColor: Colors.grey.shade400,
    type: BottomNavigationBarType.fixed,
    elevation: 8,
    showSelectedLabels: true,
    showUnselectedLabels: true,
    selectedLabelStyle: const TextStyle(
      fontWeight: FontWeight.w600,
      color: Colors.white,
    ),
  ),

  appBarTheme: AppBarTheme(
    backgroundColor: kScaffoldDark,
    foregroundColor: Colors.white,
    elevation: 0,
    shadowColor: Colors.transparent,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
    ),
  ),
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor: kPrimaryColor,
    foregroundColor: Colors.white,
    elevation: 6,
    shape: const CircleBorder(),
  ),
);
