import 'package:category_b/ui/theme/app_theme_tokens.dart';
import 'package:flutter/material.dart';

class CupertinoHandle extends StatelessWidget {
  const CupertinoHandle({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      width: AppThemeTokens.cupertinoHandleWidth,
      height: AppThemeTokens.cupertinoHandleHeight,
      margin: AppThemeTokens.marginBottomMedium,
      decoration: BoxDecoration(
        color: theme.hintColor.withValues(alpha: AppThemeTokens.alphaHigh),
        borderRadius: BorderRadius.circular(AppThemeTokens.radiusXSmall),
      ),
    );
  }
}
