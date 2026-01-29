import 'package:category_b/core/services/anekdot/models/anekdots.dart';
import 'package:category_b/core/services/toggle_favorite_func.dart';
import 'package:category_b/feathures/generate%20anekdot/widgets/anekdot_bottom_shett.dart';
import 'package:flutter/material.dart';

Future<void> showAnekdotBottomSheet({
  required BuildContext context,
  required Anekdot anekdot,
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
      ),
    ),
  );
}
