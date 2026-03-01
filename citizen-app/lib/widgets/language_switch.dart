import 'package:flutter/material.dart';

class LanguageSwitch extends StatelessWidget {
  final Locale currentLocale;
  final Function(Locale) onChanged;

  const LanguageSwitch({
    super.key,
    required this.currentLocale,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Text(currentLocale.languageCode.toUpperCase()),
      onPressed: () {
        final newLocale = currentLocale.languageCode == 'en'
            ? const Locale('ar')
            : const Locale('en');
        onChanged(newLocale);
      },
    );
  }
}
