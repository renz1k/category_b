import 'package:flutter/material.dart';

class AddAnekdotDialog extends StatefulWidget {
  const AddAnekdotDialog({super.key, required this.onAdd});

  final ValueChanged<String> onAdd;

  @override
  State<AddAnekdotDialog> createState() => _AddAnekdotDialogState();
}

class _AddAnekdotDialogState extends State<AddAnekdotDialog> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return AlertDialog(
      backgroundColor: theme.cardColor,
      actionsPadding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
      title: const Text('Добавить анекдот'),
      content: TextField(
        controller: _controller,
        maxLines: 5,
        minLines: 1,
        autofocus: true,
        decoration: InputDecoration(
          hintText: 'Введите текст анекдота...',
          border: const OutlineInputBorder(),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey, width: 1.0),
          ),

          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: theme.primaryColor, width: 2.0),
          ),
        ),
        keyboardType: TextInputType.multiline,
        textInputAction: TextInputAction.newline,
      ),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(
                'Отмена',
                style: TextStyle(color: theme.primaryColor),
              ),
            ),
            FilledButton(
              onPressed: () => widget.onAdd(_controller.text),
              style: FilledButton.styleFrom(
                backgroundColor: theme.primaryColor,
                foregroundColor: theme.cardColor,
              ),
              child: const Text('Добавить'),
            ),
          ],
        ),
      ],
    );
  }
}
