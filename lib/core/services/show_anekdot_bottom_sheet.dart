import 'package:category_b/feathures/generate%20anekdot/widgets/anekdot_bottom_shett.dart';
import 'package:flutter/material.dart';

void showAnekdotBottomSheet({
  required BuildContext context,
  required String anekdotText,
  bool isFavorite = false,
}) {
  showModalBottomSheet(
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    context: context,
    builder: (context) => Padding(
      padding: const EdgeInsets.only(top: 100),
      child: AnekdotBottomSheet(
        anekdotText: anekdotText,
        isFavorite: isFavorite,
      ),
    ),
  );
}
