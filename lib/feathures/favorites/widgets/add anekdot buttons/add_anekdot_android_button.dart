import 'package:category_b/feathures/favorites/widgets/add%20anekdot%20buttons/show_add_anekdot_dialog.dart';
import 'package:flutter/material.dart';

class AddAnekdotAndroidButton extends StatelessWidget {
  const AddAnekdotAndroidButton({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return FloatingActionButton(
      onPressed: () => showAddAnekdotDialog(context),
      tooltip: 'Добавить свой анекдот',
      backgroundColor: theme.primaryColor,
      child: const Icon(Icons.add),
    );
  }
}
