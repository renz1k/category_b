import 'package:anekdots_b/ui/theme/app_colors.dart';
import 'package:anekdots_b/ui/theme/app_theme_tokens.dart';
import 'package:anekdots_b/ui/theme/theme.dart';
import 'package:flutter/material.dart';

class BaseBottomSheet extends StatelessWidget {
  const BaseBottomSheet({required this.child, super.key});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isCupertino = !theme.isAndroid;

    return Container(
      padding: AppThemeTokens.paddingLarge.copyWith(top: isCupertino ? 12 : 20),
      decoration: BoxDecoration(
        color: theme.brightness == Brightness.light
            ? AppColors.surfaceLight
            : AppColors.surfaceDark,
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(AppThemeTokens.radiusXXLarge),
        ),
      ),
      child: child,
    );
  }
}
