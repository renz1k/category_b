import 'package:anekdots_b/core/services/anekdot/models/anekdots.dart';
import 'package:anekdots_b/core/services/share_service.dart';
import 'package:anekdots_b/core/services/show_add_or_update_dialog.dart';
import 'package:anekdots_b/core/services/toggle_favorite_func.dart';
import 'package:anekdots_b/ui/theme/app_theme_tokens.dart';
import 'package:anekdots_b/ui/widgets/bottom%20sheet/anekdot_bottom_shett.dart';
import 'package:flutter/material.dart';

Future<void> showAnekdotBottomSheet({
  required BuildContext context,
  required Anekdot anekdot,
  String? dbId,
  bool isFavorite = false,
}) async {
  await showModalBottomSheet<void>(
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    context: context,
    builder: (context) => GestureDetector(
      onTap: () => _close(context),
      child: ColoredBox(
        color: Colors.transparent,
        child: Padding(
          padding: AppThemeTokens.marginTopLarge,
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
