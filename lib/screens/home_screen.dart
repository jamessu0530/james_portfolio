import 'package:flutter/material.dart';

import '../constants/app_constants.dart';
import '../models/app_language.dart';
import '../pages/timeline_page.dart';
import '../styles/app_colors.dart';
import '../widgets/common/fade_slide_in.dart';
import '../widgets/common/pressable_card.dart';
import '../widgets/profile/info_sections.dart';
import '../widgets/profile/profile_header.dart';
import '../widgets/profile/project_card.dart';
import '../widgets/profile/skill_section.dart';
import '../widgets/profile/stats_row.dart';

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
    final String timelineLabel =
        language == AppLanguage.zh ? '人生時間軸' : 'Timeline';

    const int baseMs = 120;

    final List<Widget> sections = [
      AboutSection(
        language: language,
        cardColor: isDarkMode ? AppColors.cardAboutDark : AppColors.cardAbout,
      ),
      EducationSection(
        language: language,
        cardColor: isDarkMode
            ? AppColors.cardEducationDark
            : AppColors.cardEducation,
      ),
      SkillSection(
        language: language,
        cardColor:
            isDarkMode ? AppColors.cardSkillsDark : AppColors.cardSkills,
      ),
      ProjectSection(
        language: language,
        cardColor: isDarkMode
            ? AppColors.cardProjectsDark
            : AppColors.cardProjects,
      ),
      ActivitySection(
        language: language,
        cardColor: isDarkMode
            ? AppColors.cardActivitiesDark
            : AppColors.cardActivities,
      ),
      BiographySection(
        language: language,
        cardColor: isDarkMode
            ? AppColors.cardBiographyDark
            : AppColors.cardBiography,
      ),
    ];

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              // -- Profile header --
              FadeSlideIn(
                delay: const Duration(milliseconds: 80),
                offset: const Offset(0, 16),
                child: Padding(
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
                    avatarPath: avatarPath,
                    onAvatarChanged: onAvatarChanged,
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // -- Stats row --
              FadeSlideIn(
                delay: const Duration(milliseconds: 200),
                offset: const Offset(0, 12),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.pagePadding,
                  ),
                  child: StatsRow(
                    stats: [
                      StatItem(
                        value: '4',
                        label: language == AppLanguage.zh ? '專案' : 'Projects',
                      ),
                      StatItem(
                        value: '5',
                        label: language == AppLanguage.zh ? '語言' : 'Languages',
                      ),
                      StatItem(
                        value: '7',
                        label: language == AppLanguage.zh ? '經歷' : 'Experience',
                      ),
                      StatItem(
                        value: '810',
                        label: 'TOEIC',
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 12),

              // -- Timeline button --
              FadeSlideIn(
                delay: const Duration(milliseconds: 280),
                offset: const Offset(0, 12),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.pagePadding,
                  ),
                  child: SizedBox(
                    width: double.infinity,
                    child: FilledButton.icon(
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
                      style: FilledButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: AppSpacing.sectionGap + 4),

              // -- Stacked card sections --
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.pagePadding,
                ),
                child: Column(
                  children: [
                    for (int i = 0; i < sections.length; i++) ...[
                      FadeSlideIn(
                        delay: Duration(milliseconds: 350 + i * baseMs),
                        offset: const Offset(0, 24),
                        child: PressableCard(child: sections[i]),
                      ),
                      if (i < sections.length - 1)
                        const SizedBox(height: AppSpacing.sectionGap),
                    ],
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
