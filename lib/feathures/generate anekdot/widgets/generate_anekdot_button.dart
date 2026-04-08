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
          if (icon != null) ...[Icon(icon, size: 24), const SizedBox(width: 8)],
          Text(text),
        ],
      ),
    );
  }
}
