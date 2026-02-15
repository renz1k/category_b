import 'package:category_b/feathures/favorites/widgets/add%20anekdot%20buttons/show_add_anekdot_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AddAnekdotCupertinoButton extends StatelessWidget {
  const AddAnekdotCupertinoButton({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.only(right: 16),
      child: Container(
        decoration: BoxDecoration(
          color: theme.cardColor.withValues(alpha: 0.9),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: theme.brightness == Brightness.dark
                ? Colors.white.withValues(alpha: 0.4)
                : Colors.grey.shade300,
            width: 1.8,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.2),
              blurRadius: 6,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: CupertinoButton(
          padding: const EdgeInsets.all(8),
          minimumSize: const Size(44, 44),
          onPressed: () => showAddAnekdotDialog(context),
          child: Icon(
            Icons.add,
            color: theme.brightness == Brightness.dark
                ? Colors.white.withValues(alpha: 0.95)
                : Colors.black87,
            size: 24,
          ),
        ),
      ),
    );
  }
}
