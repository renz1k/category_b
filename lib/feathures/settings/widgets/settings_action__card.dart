import 'package:category_b/ui/widgets/base_container.dart';
import 'package:flutter/material.dart';

class SettingsActionCard extends StatelessWidget {
  const SettingsActionCard({
    super.key,
    required this.title,
    this.onTap,
    required this.iconData,
    this.iconColor,
  });
  final String title;
  final VoidCallback? onTap;
  final IconData iconData;
  final Color? iconColor;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16).copyWith(bottom: 8),
        child: BaseContainer(
          padding: EdgeInsets.symmetric(vertical: 12, horizontal: 12),
          width: double.infinity,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: theme.textTheme.titleMedium?.copyWith(fontSize: 18),
              ),

              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Icon(
                  iconData,
                  color: iconColor ?? theme.hintColor.withValues(alpha: 0.3),
                  size: 32,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
