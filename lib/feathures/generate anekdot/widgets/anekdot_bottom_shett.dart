import 'package:category_b/ui/widgets/base_bottom_sheet.dart';
import 'package:flutter/material.dart';

class AnekdotBottomSheet extends StatelessWidget {
  const AnekdotBottomSheet({
    super.key,
    this.anekdotText,
    this.isFavorite = false,
  });

  final String? anekdotText;
  final bool isFavorite;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BaseBottomSheet(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 24, right: 8, left: 8),
                  child: Text(
                    anekdotText ?? 'Походу без анекдотов',
                    style: theme.textTheme.bodyLarge?.copyWith(
                      height: 1.6,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.copy,
                    size: 32,
                    color: theme.hintColor.withValues(alpha: 0.4),
                  ),
                  tooltip: 'Копировать',
                ),
                IconButton(
                  onPressed: () {},
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
            ),
          ],
        ),
      ),
    );
  }
}
