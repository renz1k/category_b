import 'package:category_b/ui/theme/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AddOrUpdateAnekdotDialog extends StatefulWidget {
  const AddOrUpdateAnekdotDialog({
    super.key,
    required this.onAddOrUpdate,
    this.initialText,
  });

  final ValueChanged<String> onAddOrUpdate;
  final String? initialText;

  @override
  State<AddOrUpdateAnekdotDialog> createState() =>
      _AddOrUpdateAnekdotDialogState();
}

class _AddOrUpdateAnekdotDialogState extends State<AddOrUpdateAnekdotDialog> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.initialText);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    if (theme.isAndroid) {
      return AlertDialog(
        backgroundColor: theme.cardColor,
        actionsPadding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
        title: Center(
          child: Text(
            widget.initialText == null ? 'Добавить анекдот' : 'Редактировать',
            style: TextStyle(
              color: theme.brightness == Brightness.dark
                  ? Colors.white
                  : Colors.black,
            ),
          ),
        ),
        content: TextField(
          controller: _controller,
          maxLines: 6,
          minLines: 1,
          autofocus: true,
          style: TextStyle(
            color: theme.brightness == Brightness.dark
                ? Colors.white
                : Colors.black,
          ),
          decoration: InputDecoration(
            hintText: 'Введите текст анекдота...',
            hintStyle: TextStyle(
              color: theme.brightness == Brightness.dark
                  ? Colors.white
                  : Colors.black,
            ),
            border: const OutlineInputBorder(),
            enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey, width: 1.0),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: theme.hintColor.withValues(alpha: 0.3),
                width: 2.0,
              ),
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
                onPressed: () => _close(context),
                child: Text(
                  'Отмена',
                  style: TextStyle(
                    color: theme.primaryColor.withValues(alpha: 0.8),
                  ),
                ),
              ),
              FilledButton(
                onPressed: () => widget.onAddOrUpdate(_controller.text),
                style: FilledButton.styleFrom(
                  backgroundColor: theme.primaryColor.withValues(alpha: 0.9),
                  foregroundColor: Colors.white,
                ),
                child: Text(
                  widget.initialText == null ? 'Добавить' : 'Сохранить',
                ),
              ),
            ],
          ),
        ],
      );
    }
    return CupertinoAlertDialog(
      title: Text(
        widget.initialText == null ? 'Добавить анекдот' : 'Редактировать',
      ),
      content: Padding(
        padding: const EdgeInsets.only(top: 12),
        child: CupertinoTextField(
          controller: _controller,
          maxLines: 6,
          minLines: 1,
          autofocus: true,
          placeholder: 'Введите текст анекдота...',
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: theme.cardColor,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: CupertinoColors.separator),
          ),
          textAlignVertical: TextAlignVertical.top,
        ),
      ),
      actions: [
        CupertinoDialogAction(
          isDestructiveAction: true,
          onPressed: () => _close(context),
          child: const Text('Отмена'),
        ),
        CupertinoDialogAction(
          onPressed: () => widget.onAddOrUpdate(_controller.text),
          isDefaultAction: true,
          child: Text(
            widget.initialText == null ? 'Добавить' : 'Сохранить',
            style: TextStyle(color: CupertinoColors.activeBlue),
          ),
        ),
      ],
    );
  }
}

void _close(BuildContext context) {
  Navigator.of(context).pop();
}
