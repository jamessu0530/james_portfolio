import 'package:flutter/material.dart';

import '../constants/app_constants.dart';
import '../models/app_language.dart';
import '../pages/timeline_page.dart';
import '../widgets/info_sections.dart';
import '../widgets/profile_header.dart';
import '../widgets/project_card.dart';
import '../widgets/skill_section.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({
    super.key,
    required this.language,
    required this.isDarkMode,
    required this.onToggleLanguage,
    required this.onToggleTheme,
  });

  final AppLanguage language;
  final bool isDarkMode;
  final VoidCallback onToggleLanguage;
  final VoidCallback onToggleTheme;

  @override
  Widget build(BuildContext context) {
    final String timelineLabel =
        language == AppLanguage.zh ? '查看人生時間軸' : 'Open Timeline';

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              // -- Profile header --
              Padding(
                padding: const EdgeInsets.fromLTRB(
                  AppSpacing.pagePadding,
                  AppSpacing.headerTopPadding,
                  AppSpacing.pagePadding,
                  0,
                ),
                child: ProfileHeader(
                  language: language,
                  isDarkMode: isDarkMode,
                  onToggleLanguage: onToggleLanguage,
                  onToggleTheme: onToggleTheme,
                ),
              ),
              const SizedBox(height: AppSpacing.headerBottomGap),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.pagePadding,
                ),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: FilledButton.tonalIcon(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute<void>(
                          builder: (context) {
                            return TimelinePage(language: language);
                          },
                        ),
                      );
                    },
                    icon: const Icon(Icons.timeline_outlined),
                    label: Text(timelineLabel),
                  ),
                ),
              ),
              const SizedBox(height: AppSpacing.sectionGap),

              // -- Content sections --
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.pagePadding,
                ),
                child: Column(
                  children: [
                    AboutSection(language: language),
                    const SizedBox(height: AppSpacing.sectionGap),
                    EducationSection(language: language),
                    const SizedBox(height: AppSpacing.sectionGap),
                    SkillSection(language: language),
                    const SizedBox(height: AppSpacing.sectionGap),
                    ProjectSection(language: language),
                    const SizedBox(height: AppSpacing.sectionGap),
                    ActivitySection(language: language),
                    const SizedBox(height: AppSpacing.sectionGap),
                    BiographySection(language: language),
                    const SizedBox(height: AppSpacing.bottomSafeArea),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
