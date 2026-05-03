import 'package:category_b/ui/theme/app_colors.dart';
import 'package:category_b/ui/theme/app_theme_tokens.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

const TextTheme _kTextTheme = TextTheme(
  titleMedium: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
  bodyLarge: TextStyle(fontSize: 16, height: 1.6),
  bodyMedium: TextStyle(fontSize: 14),
  labelLarge: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
);

ElevatedButtonThemeData _buttonThemeData() => ElevatedButtonThemeData(
  style: ElevatedButton.styleFrom(
    backgroundColor: AppColors.primary,
    foregroundColor: Colors.white,
    elevation: AppThemeTokens.elevationXLarge,
    shadowColor: Colors.black.withValues(alpha: AppThemeTokens.alphaHigh),
    padding: AppThemeTokens.paddingSymmetricButtonHorizontal,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(AppThemeTokens.radiusXLarge),
    ),
    textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
  ),
);

FilledButtonThemeData _filledButtonThemeData() => FilledButtonThemeData(
  style: FilledButton.styleFrom(
    backgroundColor: AppColors.primary,
    foregroundColor: Colors.white,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(AppThemeTokens.radiusLarge),
    ),
    textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
  ),
);

final ThemeData lightTheme = ThemeData(
  useMaterial3: true,
  brightness: Brightness.light,

  switchTheme: SwitchThemeData(
    trackOutlineColor: WidgetStateProperty.all(
      ColorScheme.fromSeed(
        seedColor: AppColors.primary,
      ).onSurfaceVariant.withValues(alpha: AppThemeTokens.alphaHigh),
    ),
  ),

  colorScheme:
      ColorScheme.fromSeed(
        seedColor: AppColors.primary,
        primaryContainer: AppColors.primary.withValues(
          alpha: AppThemeTokens.alphaLight,
        ),
      ).copyWith(
        surface: AppColors.surfaceLight,
        surfaceContainerHighest: AppColors.surfaceLight,
      ),

  scaffoldBackgroundColor: AppColors.scaffoldLight,
  primaryColor: AppColors.primary,
  cardColor: AppColors.cardLight,
  cardTheme: CardThemeData(
    color: AppColors.cardLight,
    elevation: AppThemeTokens.elevationSmall,
    shadowColor: Colors.black.withValues(alpha: AppThemeTokens.alphaLight),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(AppThemeTokens.radiusLarge),
    ),
  ),

  textTheme: _kTextTheme,
  dividerTheme: const DividerThemeData(
    color: AppColors.dividerLight,
    thickness: 1,
    space: 16,
  ),

  elevatedButtonTheme: _buttonThemeData(),
  filledButtonTheme: _filledButtonThemeData(),

  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: AppColors.surfaceLight,
    selectedItemColor: AppColors.primary,
    unselectedItemColor: Colors.grey.shade600,
    type: BottomNavigationBarType.fixed,
    elevation: AppThemeTokens.elevationXLarge,
    showSelectedLabels: true,
    showUnselectedLabels: true,
    selectedLabelStyle: const TextStyle(fontWeight: FontWeight.w600),
  ),

  appBarTheme: const AppBarTheme(
    backgroundColor: AppColors.scaffoldLight,
    foregroundColor: Colors.black87,
    elevation: AppThemeTokens.elevationNone,
    shadowColor: Colors.transparent,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        bottom: Radius.circular(AppThemeTokens.radiusXXLarge),
      ),
    ),
  ),
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: AppColors.primary,
    foregroundColor: Colors.white,
    elevation: 6,
    shape: CircleBorder(),
  ),
);

final ThemeData darkTheme = ThemeData(
  useMaterial3: true,
  brightness: Brightness.dark,

  switchTheme: SwitchThemeData(
    trackOutlineColor: WidgetStateProperty.all(
      ColorScheme.fromSeed(
        seedColor: AppColors.primary,
        brightness: Brightness.dark,
      ).onSurfaceVariant.withValues(alpha: AppThemeTokens.alphaHigh),
    ),
  ),

  colorScheme:
      ColorScheme.fromSeed(
        seedColor: AppColors.primary,
        brightness: Brightness.dark,
      ).copyWith(
        surface: AppColors.surfaceDark,
        surfaceContainerHighest: AppColors.surfaceVariantDark,
        primaryContainer: AppColors.primary.withValues(
          alpha: AppThemeTokens.alphaMedium,
        ),
      ),

  scaffoldBackgroundColor: AppColors.scaffoldDark,
  primaryColor: AppColors.primary,
  cardColor: AppColors.cardDark,
  cardTheme: CardThemeData(
    color: AppColors.cardDark,
    elevation: AppThemeTokens.elevationMedium,
    shadowColor: Colors.black.withValues(alpha: AppThemeTokens.alphaDarker),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(AppThemeTokens.radiusLarge),
    ),
  ),

  textTheme: _kTextTheme,
  dividerTheme: const DividerThemeData(
    color: AppColors.dividerDark,
    thickness: 1,
    space: 16,
  ),

  elevatedButtonTheme: _buttonThemeData(),
  filledButtonTheme: _filledButtonThemeData(),

  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: AppColors.surfaceDark,
    selectedItemColor: AppColors.primary,
    unselectedItemColor: Colors.grey.shade400,
    type: BottomNavigationBarType.fixed,
    elevation: AppThemeTokens.elevationXLarge,
    showSelectedLabels: true,
    showUnselectedLabels: true,
    selectedLabelStyle: const TextStyle(
      fontWeight: FontWeight.w600,
      color: Colors.white,
    ),
  ),

  appBarTheme: const AppBarTheme(
    backgroundColor: AppColors.scaffoldDark,
    foregroundColor: Colors.white,
    elevation: AppThemeTokens.elevationNone,
    shadowColor: Colors.transparent,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        bottom: Radius.circular(AppThemeTokens.radiusXXLarge),
      ),
    ),
  ),
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: AppColors.primary,
    foregroundColor: Colors.white,
    elevation: 6,
    shape: CircleBorder(),
  ),
);

extension ThemePlatformExtension on ThemeData {
  bool get isAndroid => defaultTargetPlatform == TargetPlatform.android;
}
