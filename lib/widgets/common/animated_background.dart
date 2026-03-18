import 'dart:math' as math;

import 'package:flutter/material.dart';

class AnimatedBackground extends StatefulWidget {
  const AnimatedBackground({super.key, required this.isDark});

  final bool isDark;

  @override
  State<AnimatedBackground> createState() => _AnimatedBackgroundState();
}

class _AnimatedBackgroundState extends State<AnimatedBackground>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 12),
    )..repeat();
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _ctrl,
      builder: (context, _) {
        return CustomPaint(
          painter: _BlobPainter(
            progress: _ctrl.value,
            isDark: widget.isDark,
          ),
          size: Size.infinite,
        );
      },
    );
  }
}

class _BlobPainter extends CustomPainter {
  _BlobPainter({required this.progress, required this.isDark});

  final double progress;
  final bool isDark;

  @override
  void paint(Canvas canvas, Size size) {
    final double t = progress * 2 * math.pi;

    final List<_Blob> blobs = [
      _Blob(
        cx: size.width * (0.2 + 0.1 * math.sin(t * 0.7)),
        cy: size.height * (0.15 + 0.08 * math.cos(t * 0.5)),
        radius: size.width * 0.45,
        color: isDark
            ? const Color(0xFF0A84FF).withValues(alpha: 0.06)
            : const Color(0xFF007AFF).withValues(alpha: 0.07),
      ),
      _Blob(
        cx: size.width * (0.8 + 0.12 * math.cos(t * 0.6)),
        cy: size.height * (0.35 + 0.1 * math.sin(t * 0.8)),
        radius: size.width * 0.5,
        color: isDark
            ? const Color(0xFF5E5CE6).withValues(alpha: 0.05)
            : const Color(0xFF5856D6).withValues(alpha: 0.06),
      ),
      _Blob(
        cx: size.width * (0.4 + 0.15 * math.sin(t * 0.9)),
        cy: size.height * (0.7 + 0.08 * math.cos(t * 0.4)),
        radius: size.width * 0.4,
        color: isDark
            ? const Color(0xFF30D158).withValues(alpha: 0.04)
            : const Color(0xFF34C759).withValues(alpha: 0.05),
      ),
    ];

    for (final blob in blobs) {
      final Paint paint = Paint()
        ..shader = RadialGradient(
          colors: [blob.color, blob.color.withValues(alpha: 0)],
        ).createShader(
          Rect.fromCircle(center: Offset(blob.cx, blob.cy), radius: blob.radius),
        );
      canvas.drawCircle(Offset(blob.cx, blob.cy), blob.radius, paint);
    }
  }

  @override
  bool shouldRepaint(_BlobPainter old) => old.progress != progress;
}

class _Blob {
  const _Blob({
    required this.cx,
    required this.cy,
    required this.radius,
    required this.color,
  });

  final double cx;
  final double cy;
  final double radius;
  final Color color;
}
