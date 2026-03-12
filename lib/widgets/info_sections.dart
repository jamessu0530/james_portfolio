import 'package:flutter/material.dart';

import '../data/profile_data.dart';
import '../models/app_language.dart';
import 'glass_card.dart';
import 'section_title.dart';

// ---------------------------------------------------------------------------
// About Me
// ---------------------------------------------------------------------------

class AboutSection extends StatelessWidget {
  const AboutSection({super.key, required this.language});

  final AppLanguage language;

  @override
  Widget build(BuildContext context) {
    final ColorScheme colors = Theme.of(context).colorScheme;
    final String title = language == AppLanguage.zh ? '關於我' : 'About Me';

    return GlassCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SectionTitle(title: title, icon: Icons.person_outline),
          Text(
            ProfileData.bio.text(language),
            style: TextStyle(
              fontSize: 14,
              height: 1.7,
              color: colors.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Education
// ---------------------------------------------------------------------------

class EducationSection extends StatelessWidget {
  const EducationSection({super.key, required this.language});

  final AppLanguage language;

  @override
  Widget build(BuildContext context) {
    final ColorScheme colors = Theme.of(context).colorScheme;
    final String title = language == AppLanguage.zh ? '教育背景' : 'Education';

    return GlassCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SectionTitle(title: title, icon: Icons.school_outlined),
          ...ProfileData.education.map(
            (item) => Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 6),
                    width: 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color: colors.primary,
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item.school.text(language),
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          item.degree.text(language),
                          style: TextStyle(
                            fontSize: 13,
                            color: colors.onSurfaceVariant,
                          ),
                        ),
                        if (item.detail.isNotEmpty) ...[
                          const SizedBox(height: 2),
                          Text(
                            item.detail,
                            style: TextStyle(
                              fontSize: 12,
                              color: colors.onSurfaceVariant.withValues(
                                alpha: 0.7,
                              ),
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Experience & Activities
// ---------------------------------------------------------------------------

class ActivitySection extends StatelessWidget {
  const ActivitySection({super.key, required this.language});

  final AppLanguage language;

  @override
  Widget build(BuildContext context) {
    final ColorScheme colors = Theme.of(context).colorScheme;
    final String title =
        language == AppLanguage.zh ? '經歷與活動' : 'Experience & Activities';

    return GlassCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SectionTitle(title: title, icon: Icons.emoji_events_outlined),
          ...ProfileData.experiences.map(
            (item) => Padding(
              padding: const EdgeInsets.only(bottom: 14),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(item.icon, size: 18, color: colors.tertiary),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item.title.text(language),
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          item.subtitle.text(language),
                          style: TextStyle(
                            fontSize: 13,
                            color: colors.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Biography
// ---------------------------------------------------------------------------

class BiographySection extends StatelessWidget {
  const BiographySection({super.key, required this.language});

  final AppLanguage language;

  @override
  Widget build(BuildContext context) {
    final ColorScheme colors = Theme.of(context).colorScheme;
    final String title = language == AppLanguage.zh ? '自傳' : 'Biography';

    return GlassCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SectionTitle(title: title, icon: Icons.menu_book_outlined),
          Text(
            ProfileData.biography.text(language),
            style: TextStyle(
              fontSize: 14,
              height: 1.7,
              color: colors.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }
}
