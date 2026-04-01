import 'package:flutter/material.dart';

import '../../constants/app_constants.dart';
import '../../styles/app_colors.dart';

class GlassCard extends StatelessWidget {
  const GlassCard({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(AppSpacing.pagePadding),
    this.color,
  });

  final Widget child;
  final EdgeInsets padding;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    final Color bg = color ?? (isDark ? AppColors.darkCard : Colors.white);

    return Container(
      width: double.infinity,
      padding: padding,
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(AppSizes.cardRadius),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(
              alpha: isDark
                  ? AppColors.darkShadowAlpha
                  : AppColors.lightShadowAlpha,
            ),
            blurRadius: isDark ? 8 : 16,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: child,
    );
  }
}
