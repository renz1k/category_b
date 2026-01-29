import 'package:category_b/ui/widgets/base_container.dart';
import 'package:flutter/material.dart';

class AnekdotListCard extends StatelessWidget {
  const AnekdotListCard({
    super.key,
    this.isFovorite = false,
    required this.anekdotText,
    this.onTap,
  });

  final String anekdotText;
  final bool isFovorite;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return GestureDetector(
      onTap: onTap,
      child: BaseContainer(
        width: double.infinity,
        height: 60,
        margin: const EdgeInsets.symmetric(horizontal: 16).copyWith(bottom: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(right: 8),
                child: Text(
                  anekdotText,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: theme.textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ),
              ),
            ),

            IconButton(
              constraints: BoxConstraints(minWidth: 44, minHeight: 44),
              padding: EdgeInsets.zero,
              onPressed: () {},
              icon: Icon(
                Icons.favorite,
                color: isFovorite
                    ? theme.primaryColor
                    : theme.hintColor.withValues(alpha: 0.2),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
