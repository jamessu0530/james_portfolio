import 'package:flutter/material.dart';

import '../constants/app_constants.dart';
import '../models/app_language.dart';
import '../pages/timeline_page.dart';
import '../styles/app_colors.dart';
import '../widgets/common/card_stack.dart';
import '../widgets/common/fade_slide_in.dart';
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
    final bool isZh = language == AppLanguage.zh;

    final List<String> labels = isZh
        ? ['關於', '教育', '技能', '專案', '經歷', '自傳']
        : ['About', 'Edu', 'Skills', 'Projects', 'Exp', 'Bio'];

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
        child: Column(
          children: [
            // -- Profile header --
            FadeSlideIn(
              delay: const Duration(milliseconds: 80),
              offset: const Offset(0, 14),
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
            const SizedBox(height: 12),

            // -- Stats row --
            FadeSlideIn(
              delay: const Duration(milliseconds: 180),
              offset: const Offset(0, 10),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.pagePadding,
                ),
                child: StatsRow(
                  stats: [
                    StatItem(
                      value: '4',
                      label: isZh ? '專案' : 'Projects',
                    ),
                    StatItem(
                      value: '5',
                      label: isZh ? '語言' : 'Languages',
                    ),
                    StatItem(
                      value: '7',
                      label: isZh ? '經歷' : 'Experience',
                    ),
                    const StatItem(value: '810', label: 'TOEIC'),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 10),

            // -- Timeline button --
            FadeSlideIn(
              delay: const Duration(milliseconds: 260),
              offset: const Offset(0, 10),
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
                          builder: (_) => TimelinePage(language: language),
                        ),
                      );
                    },
                    icon: const Icon(Icons.timeline_outlined, size: 18),
                    label: Text(isZh ? '人生時間軸' : 'Timeline'),
                    style: FilledButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 14),

            // -- Stacked card sections --
            Expanded(
              child: FadeSlideIn(
                delay: const Duration(milliseconds: 380),
                offset: const Offset(0, 20),
                child: CardStack(
                  labels: labels,
                  children: sections,
                ),
              ),
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}
