import 'package:anekdots_b/ui/theme/app_theme_tokens.dart';
import 'package:anekdots_b/ui/widgets/base_container.dart';
import 'package:flutter/material.dart';

class AnekdotListCard extends StatelessWidget {
  const AnekdotListCard({
    required this.anekdotText,
    super.key,
    this.onTapCard,
    this.onTapFavorite,
    this.onTapCopy,
    this.isFovorite = false,
  });

  final String anekdotText;
  final VoidCallback? onTapCard;
  final VoidCallback? onTapFavorite;
  final VoidCallback? onTapCopy;
  final bool isFovorite;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return GestureDetector(
      onTap: onTapCard,
      child: BaseContainer(
        width: double.infinity,
        height: AppThemeTokens.anekdotListCardHeight,
        margin: AppThemeTokens.paddingSymmetricListCardHorizontal.copyWith(
          bottom: AppThemeTokens.marginBottomListCard.bottom,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(
                  right: AppThemeTokens.paddingSmall.right,
                ),
                child: Text(
                  anekdotText,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: theme.textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.w600,
                    fontSize: AppThemeTokens.anekdotListCardFontSize,
                    color: theme.brightness == Brightness.dark
                        ? Colors.white
                        : Colors.black,
                  ),
                ),
              ),
            ),

            IconButton(
              constraints: const BoxConstraints(
                minWidth: AppThemeTokens.buttonMinimumSize,
                minHeight: AppThemeTokens.buttonMinimumSize,
              ),
              padding: EdgeInsets.zero,
              onPressed: onTapFavorite,
              icon: Icon(
                Icons.favorite,
                color: isFovorite
                    ? theme.primaryColor
                    : theme.hintColor.withValues(alpha: 0.2),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
