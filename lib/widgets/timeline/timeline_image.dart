import 'dart:io';

import 'package:flutter/material.dart';

import '../../constants/app_constants.dart';

class TimelineImage extends StatelessWidget {
  const TimelineImage({
    super.key,
    required this.imagePath,
    this.aspectRatio = 16 / 9,
  });

  final String imagePath;
  final double aspectRatio;

  bool get _isAsset => imagePath.startsWith('assets/');

  @override
  Widget build(BuildContext context) {
    final ColorScheme colors = Theme.of(context).colorScheme;

    return ClipRRect(
      borderRadius: BorderRadius.circular(AppSizes.projectCardRadius),
      child: AspectRatio(
        aspectRatio: aspectRatio,
        child: _isAsset
            ? Image.asset(
                imagePath,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => _fallback(context, colors),
              )
            : Image.file(
                File(imagePath),
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => _fallback(context, colors),
              ),
      ),
    );
  }

  Widget _fallback(BuildContext context, ColorScheme colors) {
    return Container(
      color: colors.surfaceContainerHighest,
      child: Center(
        child: Icon(
          Icons.photo_outlined,
          size: 32,
          color: colors.onSurfaceVariant.withValues(alpha: 0.5),
        ),
      ),
    );
  }
}
