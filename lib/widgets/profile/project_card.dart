import 'package:flutter/material.dart';

import '../../constants/app_constants.dart';
import '../../data/profile_data.dart';
import '../../models/app_language.dart';
import '../../styles/app_colors.dart';
import '../common/glass_card.dart';
import '../common/section_title.dart';

class ProjectSection extends StatelessWidget {
  const ProjectSection({super.key, required this.language, this.cardColor});

  final AppLanguage language;
  final Color? cardColor;

  @override
  Widget build(BuildContext context) {
    final String title = language == AppLanguage.zh ? '專案經驗' : 'Projects';

    return GlassCard(
      color: cardColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SectionTitle(title: title, icon: Icons.rocket_launch_outlined),
          ...ProfileData.projects.map(
            (p) => Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: ProjectCard(project: p, language: language),
            ),
          ),
        ],
      ),
    );
  }
}

class ProjectCard extends StatelessWidget {
  const ProjectCard({
    super.key,
    required this.project,
    required this.language,
  });

  final ProjectItem project;
  final AppLanguage language;

  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    final Color textColor =
        isDark ? AppColors.cardTextDark : AppColors.cardTextLight;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark
            ? Colors.white.withValues(alpha: 0.06)
            : Colors.white.withValues(alpha: 0.45),
        borderRadius: BorderRadius.circular(AppSizes.projectCardRadius),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            project.title,
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w700,
              letterSpacing: -0.2,
              color: textColor,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            project.subtitle.text(language),
            style: TextStyle(
              fontSize: 13,
              color: textColor.withValues(alpha: 0.7),
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 10),
          ...project.highlights.map(
            (h) => Padding(
              padding: const EdgeInsets.only(bottom: 4),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 6),
                    child: Icon(
                      Icons.circle,
                      size: 5,
                      color: textColor.withValues(alpha: 0.5),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      h.text(language),
                      style: TextStyle(
                        fontSize: 13,
                        height: 1.4,
                        color: textColor.withValues(alpha: 0.7),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 6,
            runSpacing: 6,
            children: project.techTags.map((tag) {
              return Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: isDark
                      ? Colors.white.withValues(alpha: 0.1)
                      : Colors.black.withValues(alpha: 0.06),
                  borderRadius: BorderRadius.circular(AppSizes.tagRadius),
                ),
                child: Text(
                  tag,
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: textColor,
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
