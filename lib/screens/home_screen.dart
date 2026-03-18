import 'package:flutter/material.dart';

import '../constants/app_constants.dart';
import '../models/app_language.dart';
import '../pages/timeline_page.dart';
import '../widgets/common/fade_slide_in.dart';
import '../widgets/common/pressable_card.dart';
import '../widgets/profile/info_sections.dart';
import '../widgets/profile/profile_header.dart';
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
    final String timelineLabel =
        language == AppLanguage.zh ? '查看人生時間軸' : 'Open Timeline';

    const int baseMs = 150;

    final List<Widget> sections = [
      AboutSection(language: language),
      EducationSection(language: language),
      SkillSection(language: language),
      ProjectSection(language: language),
      ActivitySection(language: language),
      BiographySection(language: language),
    ];

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              // -- Profile header (fade + slide in) --
              FadeSlideIn(
                delay: const Duration(milliseconds: 100),
                offset: const Offset(0, 20),
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
              const SizedBox(height: AppSpacing.headerBottomGap),

              // -- Timeline button (fade in) --
              FadeSlideIn(
                delay: const Duration(milliseconds: 300),
                offset: const Offset(0, 16),
                child: Padding(
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
              ),
              const SizedBox(height: AppSpacing.sectionGap),

              // -- Content sections (staggered fade + pressable) --
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.pagePadding,
                ),
                child: Column(
                  children: [
                    for (int i = 0; i < sections.length; i++) ...[
                      FadeSlideIn(
                        delay: Duration(milliseconds: 400 + i * baseMs),
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
