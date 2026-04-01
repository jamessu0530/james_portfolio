import 'package:flutter/material.dart';

import '../models/app_language.dart';
import '../pages/timeline_page.dart';
import '../styles/app_colors.dart';
import '../widgets/common/card_stack.dart';
import '../widgets/profile/highlights_card.dart';
import '../widgets/profile/identity_card.dart';
import '../widgets/profile/info_sections.dart';
import '../widgets/profile/project_card.dart';
import '../widgets/profile/skill_section.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({
    super.key,
    required this.language,
    required this.isDarkMode,
    required this.onToggleLanguage,
    required this.onToggleTheme,
    required this.avatarPath,
    required this.onAvatarChanged,
  });

  final AppLanguage language;
  final bool isDarkMode;
  final VoidCallback onToggleLanguage;
  final VoidCallback onToggleTheme;
  final String? avatarPath;
  final ValueChanged<String?> onAvatarChanged;

  @override
  Widget build(BuildContext context) {
    final List<Widget> journey = [
      // 0 — Identity: who I am
      IdentityCard(
        language: language,
        isDarkMode: isDarkMode,
        avatarPath: avatarPath,
        onAvatarChanged: onAvatarChanged,
        onToggleLanguage: onToggleLanguage,
        onToggleTheme: onToggleTheme,
        cardColor: isDarkMode
            ? AppColors.cardIdentityDark
            : AppColors.cardIdentity,
      ),
      // 1 — Highlights: key numbers + links
      HighlightsCard(
        language: language,
        cardColor: isDarkMode
            ? AppColors.cardHighlightsDark
            : AppColors.cardHighlights,
        onTimelineTap: () {
          Navigator.of(context).push(
            MaterialPageRoute<void>(
              builder: (_) => TimelinePage(language: language),
            ),
          );
        },
      ),
      // 2 — About
      AboutSection(
        language: language,
        cardColor: isDarkMode ? AppColors.cardAboutDark : AppColors.cardAbout,
      ),
      // 3 — Education
      EducationSection(
        language: language,
        cardColor: isDarkMode
            ? AppColors.cardEducationDark
            : AppColors.cardEducation,
      ),
      // 4 — Skills
      SkillSection(
        language: language,
        cardColor:
            isDarkMode ? AppColors.cardSkillsDark : AppColors.cardSkills,
      ),
      // 5 — Projects
      ProjectSection(
        language: language,
        cardColor: isDarkMode
            ? AppColors.cardProjectsDark
            : AppColors.cardProjects,
      ),
      // 6 — Experience
      ActivitySection(
        language: language,
        cardColor: isDarkMode
            ? AppColors.cardActivitiesDark
            : AppColors.cardActivities,
      ),
      // 7 — Biography
      BiographySection(
        language: language,
        cardColor: isDarkMode
            ? AppColors.cardBiographyDark
            : AppColors.cardBiography,
      ),
    ];

    return Scaffold(
      body: SafeArea(
        child: CardStack(children: journey),
      ),
    );
  }
}
