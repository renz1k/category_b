import 'dart:async';

import 'package:anekdots_b/core/constants/app_constants.dart';
import 'package:anekdots_b/core/texts/app_texts.dart';
import 'package:anekdots_b/ui/theme/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void showMessage(
  BuildContext context,
  String message, {
  bool isError = false,
}) {
  final theme = Theme.of(context);

  if (theme.isAndroid) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
        backgroundColor: isError ? Colors.red : Colors.green,
        duration: AppConstants.messageDisplayDuration,
      ),
    );
  } else {
    Timer? timer;
    timer = Timer(AppConstants.messageDisplayDuration, () {
      if (context.mounted && Navigator.canPop(context)) {
        Navigator.of(context).pop();
      }
      timer?.cancel();
    });

    showCupertinoDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (dialogContext) => CupertinoAlertDialog(
        content: Text(
          message,
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
        ),
        actions: [
          CupertinoDialogAction(
            onPressed: () {
              timer?.cancel();
              Navigator.of(dialogContext).pop();
            },
            child: const Text(
              AppTexts.buttonOk,
              style: TextStyle(color: CupertinoColors.activeBlue),
            ),
          ),
        ],
      ),
    );
  }
}
