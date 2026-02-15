import 'package:category_b/ui/theme/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ConfirmationDialog extends StatelessWidget {
  const ConfirmationDialog({super.key, required this.onConfirm});

  final VoidCallback onConfirm;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    if (theme.isAndroid) {
      return AlertDialog(
        backgroundColor: theme.cardColor,
        content: _DialogContent(crossAxisAlignment: CrossAxisAlignment.start),
        actions: [
          TextButton(
            onPressed: () => _confirm(context),
            child: Text('Да', style: TextStyle(color: theme.hintColor)),
          ),
          TextButton(
            onPressed: () => _close(context),
            child: Text(
              'Нет',
              style: TextStyle(
                color: theme.primaryColor.withValues(alpha: 0.9),
              ),
            ),
          ),
        ],
      );
    }
    return CupertinoAlertDialog(
      content: _DialogContent(crossAxisAlignment: CrossAxisAlignment.center),
      actions: [
        CupertinoDialogAction(
          onPressed: () => _confirm(context),
          isDestructiveAction: true,
          child: const Text(
            'Да',
            style: TextStyle(color: CupertinoColors.destructiveRed),
          ),
        ),
        CupertinoDialogAction(
          onPressed: () => _close(context),
          isDefaultAction: true,
          child: const Text(
            'Нет',
            style: TextStyle(color: CupertinoColors.activeBlue),
          ),
        ),
      ],
    );
  }

  void _close(BuildContext context) => Navigator.of(context).pop();
  void _confirm(BuildContext context) {
    onConfirm.call();
    Navigator.of(context).pop();
  }
}

class _DialogContent extends StatelessWidget {
  const _DialogContent({required this.crossAxisAlignment});

  final CrossAxisAlignment crossAxisAlignment;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: crossAxisAlignment,
      children: [
        Text(
          'Вы уверены?',
          style: theme.textTheme.headlineSmall?.copyWith(
            color: theme.brightness == Brightness.dark
                ? Colors.white
                : Colors.black,
          ),
        ),
        Text(
          'Это действие не может быть отменено',
          style: theme.textTheme.bodyMedium?.copyWith(
            fontSize: 16,
            color: theme.brightness == Brightness.dark
                ? Colors.white
                : Colors.black,
          ),
        ),
      ],
    );
  }
}
