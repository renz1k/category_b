import 'package:anekdots_b/core/texts/app_texts.dart';
import 'package:anekdots_b/ui/theme/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NotificationSettingsDialog extends StatelessWidget {
  const NotificationSettingsDialog({
    required this.onConfirm,
    required this.onLater,
    super.key,
  });

  final VoidCallback onConfirm;
  final VoidCallback onLater;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    if (theme.isAndroid) {
      return AlertDialog(
        backgroundColor: theme.cardColor,
        title: const Text(AppTexts.settingsNotificationDialogTitle),
        content: const Text(AppTexts.settingsNotificationDialogBody),
        actionsAlignment: MainAxisAlignment.spaceBetween,
        actions: [
          TextButton(
            onPressed: onLater,
            child: Text(
              AppTexts.settingsNotificationDialogLater,
              style: TextStyle(color: theme.hintColor),
            ),
          ),
          TextButton(
            onPressed: onConfirm,
            child: Text(
              AppTexts.buttonOk,
              style: TextStyle(
                color: theme.primaryColor.withValues(alpha: 0.9),
              ),
            ),
          ),
        ],
      );
    }

    return CupertinoAlertDialog(
      title: const Text(AppTexts.settingsNotificationDialogTitle),
      content: const Text(AppTexts.settingsNotificationDialogBody),
      actions: [
        CupertinoDialogAction(
          onPressed: onLater,
          child: Text(
            AppTexts.settingsNotificationDialogLater,
            style: TextStyle(color: Theme.of(context).primaryColor),
          ),
        ),
        CupertinoDialogAction(
          onPressed: onConfirm,
          isDefaultAction: true,
          child: const Text(
            AppTexts.buttonOk,
            style: TextStyle(color: CupertinoColors.activeBlue),
          ),
        ),
      ],
    );
  }
}
