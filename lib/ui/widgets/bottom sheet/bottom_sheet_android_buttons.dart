import 'package:category_b/ui/theme/app_theme_tokens.dart';
import 'package:flutter/material.dart';

class BottomSheetAndroidButtons extends StatelessWidget {
  const BottomSheetAndroidButtons({
    required this.onTapFavorite,
    required this.onTapShare,
    required this.isFavorite,
    super.key,
    this.onTapEdit,
  });

  final VoidCallback? onTapFavorite;
  final VoidCallback? onTapShare;
  final VoidCallback? onTapEdit;
  final bool isFavorite;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        IconButton(
          onPressed: onTapShare,
          icon: Icon(
            Icons.share,
            size: AppThemeTokens.iconSizeMedium,
            color: theme.hintColor,
          ),
          tooltip: 'Поделиться',
        ),
        if (onTapEdit != null)
          IconButton(
            onPressed: onTapEdit,
            icon: Icon(
              Icons.edit,
              size: AppThemeTokens.iconSizeMedium,
              color: theme.hintColor.withValues(
                alpha: AppThemeTokens.alphaVeryHigh,
              ),
            ),
            tooltip: 'Редактировать',
          ),
        IconButton(
          onPressed: onTapFavorite,
          icon: Icon(
            Icons.favorite,
            size: AppThemeTokens.iconSizeMedium,
            color: isFavorite
                ? theme.primaryColor
                : theme.hintColor.withValues(
                    alpha: AppThemeTokens.alphaVeryHigh,
                  ),
          ),
          tooltip: 'В избранное',
        ),
      ],
    );
  }
}
