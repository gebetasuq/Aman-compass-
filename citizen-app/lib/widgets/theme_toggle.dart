import 'package:flutter/material.dart';

class ThemeToggle extends StatelessWidget {
  final ThemeMode currentTheme;
  final Function(ThemeMode) onChanged;

  const ThemeToggle({
    super.key,
    required this.currentTheme,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        currentTheme == ThemeMode.dark ? Icons.light_mode : Icons.dark_mode,
      ),
      onPressed: () {
        final newMode = currentTheme == ThemeMode.dark
            ? ThemeMode.light
            : ThemeMode.dark;
        onChanged(newMode);
      },
    );
  }
}
