import 'dart:async';

import 'package:category_b/feathures/favorites/bloc/favorite_anekdots_bloc.dart';
import 'package:category_b/ui/theme/theme.dart';
import 'package:category_b/ui/widgets/anekdot%20dialog/add_or_update_anekdot_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void showAddOrUpdateDialog(
  BuildContext context,
  String id,
  String currentText,
) {
  final theme = Theme.of(context);

  if (theme.isAndroid) {
    showDialog(
      context: context,
      builder: (dialogContext) => AddOrUpdateAnekdotDialog(
        initialText: currentText,
        onAddOrUpdate: (newText) =>
            _handleUpdate(context, dialogContext, id, newText),
      ),
    );
  } else {
    showCupertinoDialog(
      context: context,
      builder: (dialogContext) => AddOrUpdateAnekdotDialog(
        initialText: currentText,
        onAddOrUpdate: (newText) =>
            _handleUpdate(context, dialogContext, id, newText),
      ),
    );
  }
}

void _handleUpdate(
  BuildContext context,
  BuildContext dialogContext,
  String id,
  String newText,
) {
  try {
    BlocProvider.of<FavoriteAnekdotsBloc>(
      context,
    ).add(UpdateAnekdot(id: id, newText: newText));

    Navigator.pop(dialogContext);
    Navigator.pop(context);

    showMessage(context, 'Анекдот обновлён!', isError: false);
  } catch (e) {
    showMessage(context, 'Ошибка: $e', isError: true);
  }
}

void showMessage(BuildContext context, String message, {bool isError = false}) {
  final theme = Theme.of(context);

  if (theme.isAndroid) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
        backgroundColor: isError ? Colors.red : Colors.green,
        duration: const Duration(seconds: 1),
      ),
    );
  } else {
    Timer? timer;
    timer = Timer(const Duration(seconds: 1), () {
      if (context.mounted && Navigator.canPop(context)) {
        Navigator.of(context).pop();
      }
      timer?.cancel();
    });

    showCupertinoDialog(
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
            child: Text(
              'OK',
              style: TextStyle(color: CupertinoColors.activeBlue),
            ),
          ),
        ],
      ),
    );
  }
}
