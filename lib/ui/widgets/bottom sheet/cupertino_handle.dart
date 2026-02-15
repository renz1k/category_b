import 'package:flutter/material.dart';

class CupertinoHandle extends StatelessWidget {
  const CupertinoHandle({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      width: 40,
      height: 3,
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: theme.hintColor.withValues(alpha: 0.3),
        borderRadius: BorderRadius.circular(2),
      ),
    );
  }
}
