import 'package:flutter/material.dart';

import 'app_colors.dart';

class AppTheme {
  AppTheme._();

  static ThemeData get light => ThemeData(
        brightness: Brightness.light,
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.lightSeed,
          brightness: Brightness.light,
        ),
        scaffoldBackgroundColor: AppColors.lightScaffold,
        useMaterial3: true,
      );

  static ThemeData get dark => ThemeData(
        brightness: Brightness.dark,
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.darkSeed,
          brightness: Brightness.dark,
        ),
        scaffoldBackgroundColor: AppColors.darkScaffold,
        useMaterial3: true,
      );
}
