import 'package:category_b/ui/theme/app_theme_tokens.dart';
import 'package:category_b/ui/theme/theme.dart';
import 'package:category_b/ui/widgets/base_container.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SettingsToggleCard extends StatelessWidget {
  const SettingsToggleCard({
    required this.title,
    required this.value,
    super.key,
    this.onChanged,
  });

  final String title;
  final bool value;
  final ValueChanged<bool>? onChanged;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
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
            if (theme.isAndroid)
              Switch(
                value: value,
                onChanged: onChanged,
                activeThumbColor: CupertinoColors.activeGreen.withValues(
                  alpha: 0.8,
                ),
                inactiveThumbColor: theme.hintColor,
              )
            else
              CupertinoSwitch(value: value, onChanged: onChanged),
          ],
        ),
      ),
    );
  }
}
