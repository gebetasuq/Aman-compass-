import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'app.dart';
import 'generated/l10n.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  runApp(MyApp(prefs: prefs));
}

class MyApp extends StatefulWidget {
  final SharedPreferences prefs;
  const MyApp({super.key, required this.prefs});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late Locale _locale;
  late ThemeMode _themeMode;

  @override
  void initState() {
    super.initState();
    _locale = Locale(widget.prefs.getString('language') ?? 'en');
    _themeMode = ThemeMode.values[widget.prefs.getInt('theme') ?? 0];
  }

  void setLanguage(Locale locale) {
    setState(() => _locale = locale);
    widget.prefs.setString('language', locale.languageCode);
  }

  void setTheme(ThemeMode mode) {
    setState(() => _themeMode = mode);
    widget.prefs.setInt('theme', mode.index);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Aman Compass',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(useMaterial3: true),
      darkTheme: ThemeData.dark(useMaterial3: true),
      themeMode: _themeMode,
      locale: _locale,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: AppLocalizations.delegate.supportedLocales,
      home: Directionality(
        textDirection: _locale.languageCode == 'ar' ? TextDirection.rtl : TextDirection.ltr,
        child: MainScreen(
          onLanguageChange: setLanguage,
          onThemeChange: setTheme,
          currentLocale: _locale,
          currentTheme: _themeMode,
        ),
      ),
    );
  }
}
