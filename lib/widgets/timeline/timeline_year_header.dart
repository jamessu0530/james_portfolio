import 'package:flutter/material.dart';

import '../../constants/app_constants.dart';

class TimelineYearHeader extends StatelessWidget {
  const TimelineYearHeader({
    super.key,
    required this.year,
    required this.isFirst,
  });

  final String year;
  final bool isFirst;

  @override
  Widget build(BuildContext context) {
    final ColorScheme colors = Theme.of(context).colorScheme;

    return Padding(
      padding: EdgeInsets.only(
        top: isFirst ? 4 : 24,
        bottom: 10,
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
            decoration: BoxDecoration(
              color: colors.primaryContainer,
              borderRadius: BorderRadius.circular(AppSizes.chipRadius),
            ),
            child: Text(
              year,
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w800,
                letterSpacing: 0.5,
                color: colors.onPrimaryContainer,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Divider(
              height: 1,
              thickness: 1,
              color: colors.outlineVariant.withValues(alpha: 0.4),
            ),
          ),
        ],
      ),
    );
  }
}
