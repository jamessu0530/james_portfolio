import 'package:flutter/material.dart';

import '../../styles/app_colors.dart';

class SectionTitle extends StatelessWidget {
  const SectionTitle({super.key, required this.title, required this.icon});

  final String title;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    final Color textColor =
        isDark ? AppColors.cardTextDark : AppColors.cardTextLight;

    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Row(
        children: [
          Icon(icon, size: 20, color: textColor.withValues(alpha: 0.6)),
          const SizedBox(width: 8),
          Text(
            title,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              letterSpacing: -0.3,
              color: textColor,
            ),
          ),
        ],
      ),
    );
  }
}
