import 'package:flutter/material.dart';

import '../constants/app_constants.dart';
import '../data/profile_data.dart';
import '../models/app_language.dart';
import 'glass_card.dart';
import 'section_title.dart';

class ProjectSection extends StatelessWidget {
  const ProjectSection({super.key, required this.language});

  final AppLanguage language;

  @override
  Widget build(BuildContext context) {
    final String title = language == AppLanguage.zh ? '專案經驗' : 'Projects';

    return GlassCard(
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
    final ColorScheme colors = Theme.of(context).colorScheme;
    final bool isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark
            ? colors.surfaceContainerHighest.withValues(alpha: 0.4)
            : colors.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(AppSizes.projectCardRadius),
        border: Border.all(
          color: colors.outlineVariant.withValues(alpha: 0.3),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title
          Text(
            project.title,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w700,
              letterSpacing: -0.2,
            ),
          ),
          const SizedBox(height: 2),
          // Subtitle
          Text(
            project.subtitle.text(language),
            style: TextStyle(
              fontSize: 13,
              color: colors.primary,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 10),
          // Highlights
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
                      color: colors.onSurfaceVariant,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      h.text(language),
                      style: TextStyle(
                        fontSize: 13,
                        height: 1.4,
                        color: colors.onSurfaceVariant,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 8),
          // Tech tags
          Wrap(
            spacing: 6,
            runSpacing: 6,
            children: project.techTags.map((tag) {
              return Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: colors.tertiaryContainer.withValues(alpha: 0.4),
                  borderRadius: BorderRadius.circular(AppSizes.tagRadius),
                ),
                child: Text(
                  tag,
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: colors.onTertiaryContainer,
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
