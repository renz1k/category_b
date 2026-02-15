import 'package:flutter/material.dart';

class CustomSearchBar extends StatelessWidget {
  const CustomSearchBar({
    super.key,
    required this.controller,
    required this.onChanged,
    required this.onClear,
    this.hintText = 'Поиск...',
  });

  final TextEditingController controller;
  final ValueChanged<String> onChanged;
  final VoidCallback onClear;
  final String hintText;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final textColor = theme.brightness == Brightness.dark
        ? Colors.white
        : Colors.black;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: TextField(
        controller: controller,
        onChanged: onChanged,
        style: TextStyle(color: textColor),
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(color: textColor),
          filled: true,
          fillColor: theme.cardColor,
          contentPadding: const EdgeInsets.all(12),
          prefixIcon: Icon(Icons.search, color: theme.hintColor),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide.none,
          ),
          suffixIcon: ValueListenableBuilder<TextEditingValue>(
            valueListenable: controller,
            builder: (context, value, child) {
              if (value.text.isEmpty) return const SizedBox.shrink();
              return IconButton(
                icon: const Icon(Icons.clear),
                onPressed: onClear,
              );
            },
          ),
        ),
      ),
    );
  }
}
