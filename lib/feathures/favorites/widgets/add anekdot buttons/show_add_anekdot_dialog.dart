import 'package:category_b/core/services/show_message_service.dart';
import 'package:category_b/feathures/favorites/bloc/favorite_anekdots_bloc.dart';
import 'package:category_b/feathures/generate%20anekdot/bloc/generate_anekdot_bloc.dart';
import 'package:category_b/ui/theme/theme.dart';
import 'package:category_b/ui/widgets/anekdot%20dialog/add_or_update_anekdot_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void showAddAnekdotDialog(BuildContext context) {
  final theme = Theme.of(context);

  if (theme.isAndroid) {
    showDialog<void>(
      context: context,
      builder: (dialogContext) => AddOrUpdateAnekdotDialog(
        onAddOrUpdate: (text) =>
            _onPressedAddAnekdot(context, dialogContext, text),
      ),
    );
  } else {
    showCupertinoDialog<void>(
      context: context,
      builder: (dialogContext) => AddOrUpdateAnekdotDialog(
        onAddOrUpdate: (text) =>
            _onPressedAddAnekdot(context, dialogContext, text),
      ),
    );
  }
}

void _onPressedAddAnekdot(
  BuildContext context,
  BuildContext dialogContext,
  String rawText,
) {
  final text = rawText.trim();

  if (text.isNotEmpty) {
    try {
      BlocProvider.of<FavoriteAnekdotsBloc>(
        context,
      ).add(AddCustomAnekdot(text: text));

      BlocProvider.of<GenerateAnekdotBloc>(context).add(FavoritesListDirty());

      Navigator.of(dialogContext).pop();

      showMessage(context, 'Анекдот добавлен!');
    } on Object catch (e) {
      showMessage(context, 'Ошибка добавления: $e', isError: true);
    }
  }
}
