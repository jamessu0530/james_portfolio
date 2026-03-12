import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'models/app_language.dart';
import 'screens/home_screen.dart';
import 'styles/app_theme.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(statusBarBrightness: Brightness.light),
  );
  runApp(const PortfolioApp());
}

class PortfolioApp extends StatefulWidget {
  const PortfolioApp({super.key});

  @override
  State<PortfolioApp> createState() => _PortfolioAppState();
}

class _PortfolioAppState extends State<PortfolioApp> {
  AppLanguage _language = AppLanguage.zh;
  ThemeMode _themeMode = ThemeMode.light;
  String? _avatarPath;

  void _toggleLanguage() {
    setState(() {
      _language =
          _language == AppLanguage.zh ? AppLanguage.en : AppLanguage.zh;
    });
  }

  void _toggleTheme() {
    setState(() {
      _themeMode =
          _themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    });
  }

  void _updateAvatar(String? path) {
    setState(() {
      _avatarPath = path;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: _themeMode,
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      home: HomeScreen(
        language: _language,
        isDarkMode: _themeMode == ThemeMode.dark,
        onToggleLanguage: _toggleLanguage,
        onToggleTheme: _toggleTheme,
        avatarPath: _avatarPath,
        onAvatarChanged: _updateAvatar,
      ),
    );
  }
}
