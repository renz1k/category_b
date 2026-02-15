import 'package:category_b/core/services/anekdot/models/anekdots.dart';
import 'package:category_b/core/services/share_service.dart';
import 'package:category_b/core/services/toggle_favorite_func.dart';
import 'package:category_b/ui/widgets/anekdot%20dialog/show_add_or_update_dialog.dart';
import 'package:category_b/ui/widgets/bottom%20sheet/anekdot_bottom_shett.dart';
import 'package:flutter/material.dart';

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
    builder: (context) => GestureDetector(
      onTap: () => _close(context),
      child: Container(
        color: Colors.transparent,
        child: Padding(
          padding: const EdgeInsets.only(top: 100),
          child: AnekdotBottomSheet(
            anekdot: anekdot,
            initialIsFavorite: isFavorite,
            onTapFavorite: () => toggleFavorite(context, anekdot),
            onTapShare: () => ShareService.shareAnekdot(anekdot.anekdotText),
            onTapEdit: dbId != null
                ? () =>
                      showAddOrUpdateDialog(context, dbId, anekdot.anekdotText)
                : null,
          ),
        ),
      ),
    ),
  );
}

void _close(BuildContext context) {
  Navigator.of(context).pop();
}
