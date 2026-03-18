import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
        textTheme: GoogleFonts.notoSansTextTheme(),
        useMaterial3: true,
      );

  static ThemeData get dark => ThemeData(
        brightness: Brightness.dark,
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.darkSeed,
          brightness: Brightness.dark,
        ),
        scaffoldBackgroundColor: AppColors.darkScaffold,
        textTheme: GoogleFonts.notoSansTextTheme(
          ThemeData(brightness: Brightness.dark).textTheme,
        ),
        useMaterial3: true,
      );
}
