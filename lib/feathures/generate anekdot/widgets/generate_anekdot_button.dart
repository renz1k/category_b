import 'package:category_b/ui/theme/app_theme_tokens.dart';
import 'package:flutter/material.dart';

class GenerateAnekdotButton extends StatelessWidget {
  const GenerateAnekdotButton({
    required this.onPressed,
    required this.text,
    super.key,
    this.icon,
  });

  final VoidCallback onPressed;
  final String text;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (icon != null) ...[
            Icon(icon, size: AppThemeTokens.generateButtonIconSize),
            const SizedBox(width: AppThemeTokens.generateButtonIconSpacing),
          ],
          Text(text),
        ],
      ),
    );
  }
}
