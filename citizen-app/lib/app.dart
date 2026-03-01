import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'screens/civic_navigator.dart';
import 'screens/sme_companion.dart';
import 'screens/cyber_trainer.dart';
import 'screens/preparedness.dart';
import 'screens/data_explorer.dart';
import 'widgets/disclaimer_banner.dart';
import 'widgets/quick_exit_button.dart';
import 'widgets/language_switch.dart';
import 'widgets/theme_toggle.dart';
import 'widgets/emirate_selector.dart';
import 'generated/l10n.dart';

class MainScreen extends StatefulWidget {
  final Function(Locale) onLanguageChange;
  final Function(ThemeMode) onThemeChange;
  final Locale currentLocale;
  final ThemeMode currentTheme;

  const MainScreen({
    super.key,
    required this.onLanguageChange,
    required this.onThemeChange,
    required this.currentLocale,
    required this.currentTheme,
  });

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;
  String _selectedEmirate = 'Dubai';

  final List<Widget> _screens = const [
    CivicNavigatorScreen(),
    SMECompanionScreen(),
    CyberTrainerScreen(),
    PreparednessScreen(),
    DataExplorerScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        title: Text(loc.appTitle),
        actions: [
          EmirateSelector(
            onEmirateChanged: (emirate) {
              setState(() => _selectedEmirate = emirate);
            },
          ),
          LanguageSwitch(
            currentLocale: widget.currentLocale,
            onChanged: widget.onLanguageChange,
          ),
          ThemeToggle(
            currentTheme: widget.currentTheme,
            onChanged: widget.onThemeChange,
          ),
        ],
      ),
      body: Column(
        children: [
          const DisclaimerBanner(),
          Expanded(child: _screens[_selectedIndex]),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) => setState(() => _selectedIndex = index),
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(icon: const Icon(Icons.home), label: loc.civicTab),
          BottomNavigationBarItem(icon: const Icon(Icons.business), label: loc.smeTab),
          BottomNavigationBarItem(icon: const Icon(Icons.security), label: loc.cyberTab),
          BottomNavigationBarItem(icon: const Icon(Icons.shield), label: loc.amanTab),
          BottomNavigationBarItem(icon: const Icon(Icons.data_usage), label: loc.dataTab),
        ],
      ),
      floatingActionButton: const QuickExitButton(),
    );
  }
}
