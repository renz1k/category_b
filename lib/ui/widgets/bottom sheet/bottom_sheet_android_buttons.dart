import 'package:category_b/ui/theme/app_theme_tokens.dart';
import 'package:category_b/ui/widgets/bottom%20sheet/anekdot_bottom_shett.dart';
import 'package:flutter/material.dart';

class BottomSheetAndroidButtons extends StatelessWidget {
  const BottomSheetAndroidButtons({
    required this.widget,
    required this.isFavorite,
    super.key,
  });

  final AnekdotBottomSheet widget;
  final bool isFavorite;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        IconButton(
          onPressed: widget.onTapShare,
          icon: Icon(
            Icons.share,
            size: AppThemeTokens.iconSizeMedium,
            color: theme.hintColor,
          ),
          tooltip: 'Поделиться',
        ),
        if (widget.onTapEdit != null)
          IconButton(
            onPressed: widget.onTapEdit,
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
          onPressed: widget.onTapFavorite,
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
