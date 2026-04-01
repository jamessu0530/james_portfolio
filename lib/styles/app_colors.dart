import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  // -- Light theme seed & backgrounds --
  static const Color lightSeed = Color(0xFF007AFF);
  static const Color lightScaffold = Color(0xFFEDE8E0);

  // -- Dark theme seed & backgrounds --
  static const Color darkSeed = Color(0xFF0A84FF);
  static const Color darkScaffold = Color(0xFF1C1C1E);
  static const Color darkCard = Color(0xFF2C2C2E);

  // -- Glass card borders / shadows --
  static const double cardBorderWidth = 0.5;
  static const double lightBorderAlpha = 0.04;
  static const double darkBorderAlpha = 0.08;
  static const double lightShadowAlpha = 0.06;
  static const double darkShadowAlpha = 0.3;

  // -- Section card palette (light mode) --
  static const Color cardAbout = Color(0xFFB8C5B2);
  static const Color cardEducation = Color(0xFFC9B99A);
  static const Color cardSkills = Color(0xFFE8DFC0);
  static const Color cardProjects = Color(0xFFCC4B37);
  static const Color cardActivities = Color(0xFFB0A8A0);
  static const Color cardBiography = Color(0xFF8FA3A6);

  // -- Section card palette (dark mode) --
  static const Color cardAboutDark = Color(0xFF3A4A36);
  static const Color cardEducationDark = Color(0xFF4A3F2E);
  static const Color cardSkillsDark = Color(0xFF4A4530);
  static const Color cardProjectsDark = Color(0xFF6B2820);
  static const Color cardActivitiesDark = Color(0xFF3A3630);
  static const Color cardBiographyDark = Color(0xFF2E3E40);

  // -- Text on colored cards --
  static const Color cardTextLight = Color(0xFF1A1A1A);
  static const Color cardTextDark = Color(0xFFF0EDE8);
}
