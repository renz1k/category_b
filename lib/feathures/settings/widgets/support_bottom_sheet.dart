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
        padding: const EdgeInsets.all(24).copyWith(top: 12),
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
                label: const Text('Написать в Telegram'),
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
                label: const Text('Отправить Email'),
                icon: const Icon(Icons.email_outlined),
              ),
            ),
          ],
        ),
      );
    }
    return CupertinoActionSheet(
      title: const Text('Поддержка'),
      message: const Text('Ответим вам быстро!'),
      actions: <CupertinoActionSheetAction>[
        CupertinoActionSheetAction(
          isDefaultAction: true,
          child: const Text(
            'Написать в Telegram',
            style: TextStyle(color: CupertinoColors.activeBlue),
          ),
          onPressed: () => _close(context),
        ),
        CupertinoActionSheetAction(
          isDestructiveAction: true,
          child: const Text(
            'Отправить Email',
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
