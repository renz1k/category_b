import 'package:category_b/core/services/show_message_service.dart';
import 'package:category_b/core/texts/app_texts.dart';
import 'package:category_b/feathures/favorites/bloc/favorite_anekdots_bloc.dart';
import 'package:category_b/feathures/generate%20anekdot/bloc/generate_anekdot_bloc.dart';
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
    showDialog<void>(
      context: context,
      builder: (dialogContext) => AddOrUpdateAnekdotDialog(
        initialText: currentText,
        onAddOrUpdate: (newText) =>
            _handleUpdate(context, dialogContext, id, newText),
      ),
    );
  } else {
    showCupertinoDialog<void>(
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

    BlocProvider.of<GenerateAnekdotBloc>(context).add(FavoritesListDirty());

    Navigator.pop(dialogContext);
    Navigator.pop(context);

    showMessage(context, AppTexts.messageUpdated);
  } on Object catch (e) {
    showMessage(context, '${AppTexts.messageError}$e', isError: true);
  }
}
