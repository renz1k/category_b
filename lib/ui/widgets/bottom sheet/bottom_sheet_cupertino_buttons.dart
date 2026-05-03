import 'package:category_b/ui/theme/app_theme_tokens.dart';
import 'package:category_b/ui/widgets/bottom%20sheet/anekdot_bottom_shett.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BottomSheetCupertinoButtons extends StatelessWidget {
  const BottomSheetCupertinoButtons({
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
        CupertinoButton(
          onPressed: widget.onTapShare,
          borderRadius: BorderRadius.circular(AppThemeTokens.radiusLarge),
          child: Icon(
            Icons.ios_share,
            size: AppThemeTokens.iconSizeSmall,
            color: theme.hintColor,
          ),
        ),

        if (widget.onTapEdit != null)
          CupertinoButton(
            onPressed: widget.onTapEdit,
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
          onPressed: widget.onTapFavorite,
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
