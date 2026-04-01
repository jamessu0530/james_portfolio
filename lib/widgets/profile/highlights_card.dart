import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../data/profile_data.dart';
import '../../models/app_language.dart';
import '../../styles/app_colors.dart';
import '../common/glass_card.dart';

class HighlightsCard extends StatelessWidget {
  const HighlightsCard({
    super.key,
    required this.language,
    required this.onTimelineTap,
    this.cardColor,
  });

  final AppLanguage language;
  final VoidCallback onTimelineTap;
  final Color? cardColor;

  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    final Color textColor =
        isDark ? AppColors.cardTextDark : AppColors.cardTextLight;
    final bool isZh = language == AppLanguage.zh;

    return GlassCard(
      color: cardColor,
      child: Column(
        children: [
          const Spacer(),
          Text(
            '4',
            style: TextStyle(
              fontSize: 64,
              fontWeight: FontWeight.w900,
              color: textColor,
              height: 1,
            ),
          ),
          Text(
            isZh ? '個專案' : 'Projects',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: textColor.withValues(alpha: 0.5),
            ),
          ),
          const SizedBox(height: 28),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _MiniStat(value: '5', label: isZh ? '語言' : 'Lang', c: textColor),
              const SizedBox(width: 28),
              _MiniStat(value: '7', label: isZh ? '經歷' : 'Exp', c: textColor),
              const SizedBox(width: 28),
              _MiniStat(value: '810', label: 'TOEIC', c: textColor),
            ],
          ),
          const Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _SocialDot(
                icon: Icons.code,
                url: ProfileData.githubURL,
                color: textColor,
              ),
              const SizedBox(width: 14),
              _SocialDot(
                icon: Icons.work_outline,
                url: ProfileData.linkedInURL,
                color: textColor,
              ),
              const SizedBox(width: 14),
              _SocialDot(
                icon: Icons.article_outlined,
                url: ProfileData.mediumURL,
                color: textColor,
              ),
            ],
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            child: FilledButton.icon(
              onPressed: onTimelineTap,
              icon: const Icon(Icons.timeline_outlined, size: 18),
              label: Text(isZh ? '人生時間軸' : 'Timeline'),
              style: FilledButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _MiniStat extends StatelessWidget {
  const _MiniStat({required this.value, required this.label, required this.c});

  final String value;
  final String label;
  final Color c;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.w800,
            color: c,
            height: 1,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: c.withValues(alpha: 0.45),
          ),
        ),
      ],
    );
  }
}

class _SocialDot extends StatelessWidget {
  const _SocialDot({
    required this.icon,
    required this.url,
    required this.color,
  });

  final IconData icon;
  final String url;
  final Color color;

  Future<void> _open() async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;

    return GestureDetector(
      onTap: _open,
      child: Container(
        width: 44,
        height: 44,
        decoration: BoxDecoration(
          color: isDark
              ? Colors.white.withValues(alpha: 0.08)
              : Colors.black.withValues(alpha: 0.06),
          shape: BoxShape.circle,
        ),
        child: Icon(icon, size: 20, color: color.withValues(alpha: 0.7)),
      ),
    );
  }
}
