import 'package:flutter/material.dart';

import '../constants/app_constants.dart';
import '../models/timeline_event.dart';
import 'timeline_image.dart';

class TimelineCard extends StatelessWidget {
  const TimelineCard({
    super.key,
    required this.event,
    required this.onEdit,
    required this.onDelete,
    required this.dragHandle,
  });

  final TimelineEvent event;
  final VoidCallback onEdit;
  final VoidCallback onDelete;
  final Widget dragHandle;

  @override
  Widget build(BuildContext context) {
    final ColorScheme colors = Theme.of(context).colorScheme;
    final bool isDark = Theme.of(context).brightness == Brightness.dark;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // -- Timeline rail (line + dot) --
        SizedBox(
          width: 36,
          child: Column(
            children: [
              const SizedBox(height: 8),
              Container(
                width: 12,
                height: 12,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: colors.primary,
                  border: Border.all(
                    color: isDark ? colors.surface : Colors.white,
                    width: 2,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Container(
                  width: 2,
                  height: 40,
                  decoration: BoxDecoration(
                    color: colors.outlineVariant.withValues(alpha: 0.4),
                    borderRadius: BorderRadius.circular(999),
                  ),
                ),
              ),
            ],
          ),
        ),

        // -- Card content --
        Expanded(
          child: Card(
            elevation: isDark ? 0 : 2,
            margin: EdgeInsets.zero,
            clipBehavior: Clip.antiAlias,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppSizes.cardRadius),
            ),
            child: Column(
              children: [
                // -- Cover image (centered) --
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                  child: Center(
                    child: TimelineImage(imagePath: event.imagePath),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 14, 8, 14),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // -- Top row: title + actions --
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              event.title,
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium
                                  ?.copyWith(fontWeight: FontWeight.w700),
                            ),
                          ),
                          _ActionIcon(
                            icon: Icons.edit_outlined,
                            onPressed: onEdit,
                          ),
                          _ActionIcon(
                            icon: Icons.delete_outline,
                            onPressed: onDelete,
                          ),
                          dragHandle,
                        ],
                      ),
                      if (event.description.isNotEmpty) ...[
                        const SizedBox(height: 6),
                        Text(
                          event.description,
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          style:
                              Theme.of(context).textTheme.bodySmall?.copyWith(
                                    color: colors.onSurfaceVariant,
                                    height: 1.5,
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
    );
  }
}

class _ActionIcon extends StatelessWidget {
  const _ActionIcon({required this.icon, required this.onPressed});

  final IconData icon;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 32,
      height: 32,
      child: IconButton(
        padding: EdgeInsets.zero,
        iconSize: 18,
        onPressed: onPressed,
        icon: Icon(
          icon,
          color: Theme.of(context).colorScheme.onSurfaceVariant,
        ),
      ),
    );
  }
}
