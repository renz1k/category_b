import 'package:category_b/ui/widgets/bottom%20sheet/anekdot_bottom_shett.dart';
import 'package:flutter/material.dart';

class BottomSheetAndroidButtons extends StatelessWidget {
  const BottomSheetAndroidButtons({
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
        IconButton(
          onPressed: widget.onTapShare,
          icon: Icon(Icons.share, size: 32, color: theme.hintColor),
          tooltip: 'Поделиться',
        ),
        if (widget.onTapEdit != null)
          IconButton(
            onPressed: widget.onTapEdit,
            icon: Icon(
              Icons.edit,
              size: 32,
              color: theme.hintColor.withValues(alpha: 0.4),
            ),
            tooltip: 'Редактировать',
          ),
        IconButton(
          onPressed: widget.onTapFavorite,
          icon: Icon(
            Icons.favorite,
            size: 32,
            color: isFavorite
                ? theme.primaryColor
                : theme.hintColor.withValues(alpha: 0.4),
          ),
          tooltip: 'В избранное',
        ),
      ],
    );
  }
}
