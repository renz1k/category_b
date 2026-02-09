import 'package:category_b/ui/theme/theme.dart';
import 'package:flutter/material.dart';

class BaseBottomSheet extends StatelessWidget {
  const BaseBottomSheet({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: theme.brightness == Brightness.light
            ? kSurfaceLight
            : kSurfaceDark,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: child,
    );
  }
}
