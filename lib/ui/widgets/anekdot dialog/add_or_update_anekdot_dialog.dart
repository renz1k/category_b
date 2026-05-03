import 'package:category_b/core/texts/app_texts.dart';
import 'package:category_b/ui/theme/app_theme_tokens.dart';
import 'package:category_b/ui/theme/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AddOrUpdateAnekdotDialog extends StatefulWidget {
  const AddOrUpdateAnekdotDialog({
    required this.onAddOrUpdate,
    super.key,
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
        actionsPadding: EdgeInsets.fromLTRB(
          AppThemeTokens.paddingLarge.left,
          0,
          AppThemeTokens.paddingLarge.right,
          AppThemeTokens.paddingLarge.top,
        ),
        title: Center(
          child: Text(
            widget.initialText == null
                ? AppTexts.dialogAddTitle
                : AppTexts.dialogEditTitle,
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
            hintText: AppTexts.dialogPlaceholder,
            hintStyle: TextStyle(
              color: theme.brightness == Brightness.dark
                  ? Colors.white
                  : Colors.black,
            ),
            border: const OutlineInputBorder(),
            enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: theme.hintColor.withValues(alpha: AppThemeTokens.alphaHigh),
                width: 2,
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
                  AppTexts.buttonCancel,
                  style: TextStyle(
                    color: theme.primaryColor.withValues(alpha: AppThemeTokens.alphaNearlySolid),
                  ),
                ),
              ),
              FilledButton(
                onPressed: () => widget.onAddOrUpdate(_controller.text),
                style: FilledButton.styleFrom(
                  backgroundColor: theme.primaryColor.withValues(alpha: AppThemeTokens.alphaSolid),
                  foregroundColor: Colors.white,
                ),
                child: Text(
                  widget.initialText == null
                      ? AppTexts.buttonAdd
                      : AppTexts.buttonSave,
                ),
              ),
            ],
          ),
        ],
      );
    }
    return CupertinoAlertDialog(
      title: Text(
        widget.initialText == null
            ? AppTexts.dialogAddTitle
            : AppTexts.dialogEditTitle,
      ),
      content: Padding(
        padding: EdgeInsets.only(top: AppThemeTokens.paddingMedium.top),
        child: CupertinoTextField(
          controller: _controller,
          maxLines: 6,
          minLines: 1,
          autofocus: true,
          placeholder: AppTexts.dialogPlaceholder,
          padding: AppThemeTokens.paddingMedium,
          decoration: BoxDecoration(
            color: theme.cardColor,
            borderRadius: BorderRadius.circular(AppThemeTokens.radiusSmall),
            border: Border.all(color: CupertinoColors.separator),
          ),
          textAlignVertical: TextAlignVertical.top,
        ),
      ),
      actions: [
        CupertinoDialogAction(
          isDestructiveAction: true,
          onPressed: () => _close(context),
          child: const Text(AppTexts.buttonCancel),
        ),
        CupertinoDialogAction(
          onPressed: () => widget.onAddOrUpdate(_controller.text),
          isDefaultAction: true,
          child: Text(
            widget.initialText == null
                ? AppTexts.buttonAdd
                : AppTexts.buttonSave,
            style: const TextStyle(color: CupertinoColors.activeBlue),
          ),
        ),
      ],
    );
  }
}

void _close(BuildContext context) {
  Navigator.of(context).pop();
}
