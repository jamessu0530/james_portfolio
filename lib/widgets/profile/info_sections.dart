import 'package:flutter/material.dart';

import '../../data/profile_data.dart';
import '../../models/app_language.dart';
import '../../styles/app_colors.dart';
import '../common/glass_card.dart';
import '../common/section_title.dart';

// ---------------------------------------------------------------------------
// About Me
// ---------------------------------------------------------------------------

class AboutSection extends StatelessWidget {
  const AboutSection({super.key, required this.language, this.cardColor});

  final AppLanguage language;
  final Color? cardColor;

  @override
  Widget build(BuildContext context) {
    final Color textColor = _cardText(context);
    final String title = language == AppLanguage.zh ? '關於我' : 'About Me';

    return GlassCard(
      color: cardColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SectionTitle(title: title, icon: Icons.person_outline),
          Text(
            ProfileData.bio.text(language),
            style: TextStyle(
              fontSize: 14,
              height: 1.7,
              color: textColor.withValues(alpha: 0.8),
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
  const EducationSection({super.key, required this.language, this.cardColor});

  final AppLanguage language;
  final Color? cardColor;

  @override
  Widget build(BuildContext context) {
    final Color textColor = _cardText(context);
    final String title = language == AppLanguage.zh ? '教育背景' : 'Education';

    return GlassCard(
      color: cardColor,
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
                      color: textColor.withValues(alpha: 0.5),
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
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: textColor,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          item.degree.text(language),
                          style: TextStyle(
                            fontSize: 13,
                            color: textColor.withValues(alpha: 0.7),
                          ),
                        ),
                        if (item.detail.isNotEmpty) ...[
                          const SizedBox(height: 2),
                          Text(
                            item.detail,
                            style: TextStyle(
                              fontSize: 12,
                              color: textColor.withValues(alpha: 0.5),
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
  const ActivitySection({super.key, required this.language, this.cardColor});

  final AppLanguage language;
  final Color? cardColor;

  @override
  Widget build(BuildContext context) {
    final Color textColor = _cardText(context);
    final String title =
        language == AppLanguage.zh ? '經歷與活動' : 'Experience & Activities';

    return GlassCard(
      color: cardColor,
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
                  Icon(
                    item.icon,
                    size: 18,
                    color: textColor.withValues(alpha: 0.6),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item.title.text(language),
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: textColor,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          item.subtitle.text(language),
                          style: TextStyle(
                            fontSize: 13,
                            color: textColor.withValues(alpha: 0.7),
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
  const BiographySection({super.key, required this.language, this.cardColor});

  final AppLanguage language;
  final Color? cardColor;

  @override
  Widget build(BuildContext context) {
    final Color textColor = _cardText(context);
    final String title = language == AppLanguage.zh ? '自傳' : 'Biography';

    return GlassCard(
      color: cardColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SectionTitle(title: title, icon: Icons.menu_book_outlined),
          Text(
            ProfileData.biography.text(language),
            style: TextStyle(
              fontSize: 14,
              height: 1.7,
              color: textColor.withValues(alpha: 0.8),
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Helper
// ---------------------------------------------------------------------------

Color _cardText(BuildContext context) {
  final bool isDark = Theme.of(context).brightness == Brightness.dark;
  return isDark ? AppColors.cardTextDark : AppColors.cardTextLight;
}
