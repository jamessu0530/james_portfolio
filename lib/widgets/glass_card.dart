import 'package:flutter/material.dart';

import '../constants/app_constants.dart';
import '../styles/app_colors.dart';

class GlassCard extends StatelessWidget {
  const GlassCard({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(AppSpacing.pagePadding),
  });

  final Widget child;
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      width: double.infinity,
      padding: padding,
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkCard : Colors.white,
        borderRadius: BorderRadius.circular(AppSizes.cardRadius),
        border: Border.all(
          color: isDark
              ? Colors.white.withValues(alpha: AppColors.darkBorderAlpha)
              : Colors.black.withValues(alpha: AppColors.lightBorderAlpha),
          width: AppColors.cardBorderWidth,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(
              alpha: isDark
                  ? AppColors.darkShadowAlpha
                  : AppColors.lightShadowAlpha,
            ),
            blurRadius: isDark ? 8 : 16,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: child,
    );
  }
}
