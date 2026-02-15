import 'package:category_b/ui/widgets/bottom%20sheet/anekdot_bottom_shett.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BottomSheetCupertinoButtons extends StatelessWidget {
  const BottomSheetCupertinoButtons({
    super.key,
    required this.widget,
    required this.isFavorite,
  });

  final AnekdotBottomSheet widget;
  final bool isFavorite;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        CupertinoButton(
          onPressed: widget.onTapShare,
          borderRadius: BorderRadius.circular(12),
          child: Icon(Icons.ios_share, size: 30, color: theme.hintColor),
        ),

        if (widget.onTapEdit != null)
          CupertinoButton(
            onPressed: widget.onTapEdit,
            color: theme.colorScheme.surface.withValues(alpha: 0.1),
            child: Icon(
              Icons.edit,
              size: 30,
              color: theme.hintColor.withValues(alpha: 0.4),
            ),
          ),

        CupertinoButton(
          onPressed: widget.onTapFavorite,
          color: theme.colorScheme.surface.withValues(alpha: 0.1),
          child: Icon(
            isFavorite ? Icons.favorite : Icons.favorite_border,
            size: 30,
            color: isFavorite ? theme.primaryColor : theme.hintColor,
          ),
        ),
      ],
    );
  }
}
