import 'package:category_b/core/services/anekdot/models/anekdots.dart';
import 'package:category_b/core/services/share_service.dart';
import 'package:category_b/core/services/toggle_favorite_func.dart';
import 'package:category_b/feathures/favorites/bloc/favorite_anekdots_bloc.dart';
import 'package:category_b/ui/widgets/add_anekdot_dialog.dart';
import 'package:category_b/ui/widgets/anekdot_bottom_shett.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Future<void> showAnekdotBottomSheet({
  required BuildContext context,
  required Anekdot anekdot,
  String? dbId,
  bool isFavorite = false,
}) async {
  await showModalBottomSheet(
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    context: context,
    builder: (context) => Padding(
      padding: const EdgeInsets.only(top: 100),
      child: AnekdotBottomSheet(
        anekdot: anekdot,
        initialIsFavorite: isFavorite,
        onTapFavorite: () => toggleFavorite(context, anekdot),
        onTapCopy: () => ShareService.shareAnekdot(anekdot.anekdotText),
        onTapEdit: dbId != null
            ? () => _showEditDialog(context, dbId, anekdot.anekdotText)
            : null,
      ),
    ),
  );
}

void _showEditDialog(BuildContext context, String id, String currentText) {
  showDialog(
    context: context,
    builder: (dialogContext) => AddAnekdotDialog(
      initialText: currentText,
      onAdd: (newText) {
        BlocProvider.of<FavoriteAnekdotsBloc>(
          context,
        ).add(UpdateAnekdot(id: id, newText: newText));

        Navigator.pop(dialogContext);
        Navigator.pop(context);

        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('Анекдот обновлен!')));
      },
    ),
  );
}
