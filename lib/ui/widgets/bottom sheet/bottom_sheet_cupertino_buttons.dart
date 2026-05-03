import 'package:category_b/ui/theme/app_theme_tokens.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BottomSheetCupertinoButtons extends StatelessWidget {
  const BottomSheetCupertinoButtons({
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
        CupertinoButton(
          onPressed: onTapShare,
          borderRadius: BorderRadius.circular(AppThemeTokens.radiusLarge),
          child: Icon(
            Icons.ios_share,
            size: AppThemeTokens.iconSizeSmall,
            color: theme.hintColor,
          ),
        ),

        if (onTapEdit != null)
          CupertinoButton(
            onPressed: onTapEdit,
            color: theme.colorScheme.surface.withValues(
              alpha: AppThemeTokens.alphaLight,
            ),
            child: Icon(
              Icons.edit,
              size: AppThemeTokens.iconSizeSmall,
              color: theme.hintColor.withValues(
                alpha: AppThemeTokens.alphaVeryHigh,
              ),
            ),
          ),

        CupertinoButton(
          onPressed: onTapFavorite,
          color: theme.colorScheme.surface.withValues(
            alpha: AppThemeTokens.alphaLight,
          ),
          child: Icon(
            isFavorite ? Icons.favorite : Icons.favorite_border,
            size: AppThemeTokens.iconSizeSmall,
            color: isFavorite ? theme.primaryColor : theme.hintColor,
          ),
        ),
      ],
    );
  }
}
