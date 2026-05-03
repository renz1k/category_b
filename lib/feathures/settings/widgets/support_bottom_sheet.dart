import 'package:category_b/core/texts/app_texts.dart';
import 'package:category_b/ui/theme/app_theme_tokens.dart';
import 'package:category_b/ui/theme/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SupportBottomSheet extends StatelessWidget {
  const SupportBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    if (theme.isAndroid) {
      return Padding(
        padding: AppThemeTokens.paddingSupportSheet.copyWith(
          top: AppThemeTokens.paddingTopSupportSheet.top,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                const Spacer(),
                IconButton(
                  onPressed: () => _close(context),
                  icon: Icon(Icons.close, color: theme.hintColor),
                ),
              ],
            ),
            const SizedBox(height: 8),
            SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton.icon(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: theme.primaryColor,
                  foregroundColor: Colors.white,
                ),
                label: const Text(AppTexts.settingsTelegramText),
                icon: const Icon(Icons.telegram, color: Colors.white),
              ),
            ),
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              height: 56,
              child: OutlinedButton.icon(
                onPressed: () {},
                style: OutlinedButton.styleFrom(
                  foregroundColor: theme.brightness == Brightness.dark
                      ? Colors.white
                      : Colors.black,
                  side: BorderSide(color: theme.hintColor),
                ),
                label: const Text(AppTexts.settingsEmailText),
                icon: const Icon(Icons.email_outlined),
              ),
            ),
          ],
        ),
      );
    }
    return CupertinoActionSheet(
      title: const Text(AppTexts.settingsSupportTitle),
      message: const Text(AppTexts.settingsSupportText),
      actions: <CupertinoActionSheetAction>[
        CupertinoActionSheetAction(
          isDefaultAction: true,
          child: const Text(
            AppTexts.settingsTelegramText,
            style: TextStyle(color: CupertinoColors.activeBlue),
          ),
          onPressed: () => _close(context),
        ),
        CupertinoActionSheetAction(
          isDestructiveAction: true,
          child: const Text(
            AppTexts.settingsEmailText,
            style: TextStyle(color: CupertinoColors.activeBlue),
          ),
          onPressed: () => _close(context),
        ),
      ],
    );
  }

  void _close(BuildContext context) {
    Navigator.of(context).pop();
  }
}
