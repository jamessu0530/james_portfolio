import 'package:flutter/material.dart';

import '../../constants/app_constants.dart';
import '../../data/profile_data.dart';
import '../../models/app_language.dart';
import '../../styles/app_colors.dart';
import '../common/glass_card.dart';
import '../common/section_title.dart';

class SkillSection extends StatelessWidget {
  const SkillSection({super.key, required this.language, this.cardColor});

  final AppLanguage language;
  final Color? cardColor;

  @override
  Widget build(BuildContext context) {
    final String title = language == AppLanguage.zh ? '技術能力' : 'Skills';

    return GlassCard(
      color: cardColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SectionTitle(title: title, icon: Icons.code),
          ...ProfileData.skills.map(
            (category) => _SkillGroup(category: category, language: language),
          ),
        ],
      ),
    );
  }
}

class _SkillGroup extends StatelessWidget {
  const _SkillGroup({required this.category, required this.language});

  final SkillCategory category;
  final AppLanguage language;

  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    final Color textColor =
        isDark ? AppColors.cardTextDark : AppColors.cardTextLight;

    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            category.title.text(language),
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: textColor.withValues(alpha: 0.6),
              letterSpacing: 0.5,
            ),
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children:
                category.skills.map((s) => _SkillChip(label: s)).toList(),
          ),
        ],
      ),
    );
  }
}

class _SkillChip extends StatelessWidget {
  const _SkillChip({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: isDark
            ? Colors.white.withValues(alpha: 0.12)
            : Colors.black.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(AppSizes.chipRadius),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w500,
          color: isDark ? AppColors.cardTextDark : AppColors.cardTextLight,
        ),
      ),
    );
  }
}
