import 'package:category_b/ui/theme/app_theme_tokens.dart';
import 'package:category_b/ui/widgets/base_container.dart';
import 'package:flutter/material.dart';

class SettingsActionCard extends StatelessWidget {
  const SettingsActionCard({
    required this.title,
    required this.iconData,
    super.key,
    this.onTap,
    this.iconColor,
  });
  final String title;
  final IconData iconData;
  final VoidCallback? onTap;
  final Color? iconColor;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: AppThemeTokens.paddingSymmetricSettingsCard.copyWith(
          bottom: AppThemeTokens.marginBottomSettingsCard.bottom,
        ),
        child: BaseContainer(
          padding: AppThemeTokens.paddingSymmetricSettingsCardContent,
          width: double.infinity,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: theme.textTheme.titleMedium?.copyWith(
                  fontSize: AppThemeTokens.settingsActionTitleFontSize,
                  color: theme.brightness == Brightness.dark
                      ? Colors.white
                      : Colors.black,
                ),
              ),

              Padding(
                padding: AppThemeTokens.paddingXSmall,
                child: Icon(
                  iconData,
                  color: iconColor ?? theme.hintColor.withValues(alpha: 0.3),
                  size: AppThemeTokens.settingsActionIconSize,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
