import 'package:flutter/material.dart';

class EmptyFavoritesWidget extends StatelessWidget {
  const EmptyFavoritesWidget({super.key, required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SliverFillRemaining(
      hasScrollBody: false,
      child: Center(
        child: Text(
          message,
          style: theme.textTheme.bodyLarge?.copyWith(color: theme.hintColor),
        ),
      ),
    );
  }
}
