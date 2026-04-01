import 'dart:math';

import 'package:flutter/material.dart';

import '../../constants/app_constants.dart';

class CardStack extends StatefulWidget {
  const CardStack({
    super.key,
    required this.children,
    required this.labels,
    this.maxVisible = 4,
  });

  final List<Widget> children;
  final List<String> labels;
  final int maxVisible;

  @override
  State<CardStack> createState() => _CardStackState();
}

class _CardStackState extends State<CardStack> {
  int _active = 0;
  double _dragX = 0;

  static const double _gap = 18.0;
  static const double _scaleStep = 0.04;
  static const double _opacityStep = 0.2;

  void _goTo(int i) {
    if (i >= 0 && i < widget.children.length && i != _active) {
      setState(() => _active = i);
    }
  }

  void _onDragUpdate(DragUpdateDetails d) {
    setState(() => _dragX += d.delta.dx);
  }

  void _onDragEnd(DragEndDetails d) {
    final double vx = d.velocity.pixelsPerSecond.dx;

    if (_dragX < -60 || vx < -400) {
      _goTo(_active + 1);
    } else if (_dragX > 60 || vx > 400) {
      _goTo(_active - 1);
    }
    setState(() => _dragX = 0);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _StackIndicator(
          labels: widget.labels,
          active: _active,
          onTap: _goTo,
        ),
        const SizedBox(height: 14),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.pagePadding,
            ),
            child: GestureDetector(
              onHorizontalDragUpdate: _onDragUpdate,
              onHorizontalDragEnd: _onDragEnd,
              behavior: HitTestBehavior.translucent,
              child: LayoutBuilder(
                builder: (context, constraints) {
                  return Stack(
                    clipBehavior: Clip.none,
                    children: _buildCards(constraints),
                  );
                },
              ),
            ),
          ),
        ),
      ],
    );
  }

  List<Widget> _buildCards(BoxConstraints constraints) {
    final int count = widget.children.length;
    final int endIdx = min(count - 1, _active + widget.maxVisible - 1);
    final double maxH = constraints.maxHeight - (_gap * (widget.maxVisible - 1));

    final List<Widget> cards = <Widget>[];
    for (int i = endIdx; i >= _active; i--) {
      final int pos = i - _active;
      cards.add(
        _DepthCard(
          key: ValueKey<int>(i),
          position: pos.toDouble(),
          gap: _gap,
          scaleStep: _scaleStep,
          opacityStep: _opacityStep,
          isTop: pos == 0,
          dragX: pos == 0 ? _dragX : 0,
          maxHeight: maxH,
          child: widget.children[i],
        ),
      );
    }
    return cards;
  }
}

class _DepthCard extends StatelessWidget {
  const _DepthCard({
    super.key,
    required this.position,
    required this.gap,
    required this.scaleStep,
    required this.opacityStep,
    required this.isTop,
    required this.dragX,
    required this.maxHeight,
    required this.child,
  });

  final double position;
  final double gap;
  final double scaleStep;
  final double opacityStep;
  final bool isTop;
  final double dragX;
  final double maxHeight;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween<double>(end: position),
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeOutCubic,
      builder: (context, p, staticChild) {
        final double y = p * gap;
        final double s = (1.0 - p * scaleStep).clamp(0.85, 1.0);
        final double o = (1.0 - p * opacityStep).clamp(0.0, 1.0);

        final double dx = isTop ? dragX * 0.15 : 0;

        return Transform.translate(
          offset: Offset(dx, y),
          child: Transform.scale(
            scale: s,
            alignment: Alignment.topCenter,
            child: Opacity(
              opacity: o,
              child: staticChild,
            ),
          ),
        );
      },
      child: IgnorePointer(
        ignoring: !isTop,
        child: ConstrainedBox(
          constraints: BoxConstraints(maxHeight: maxHeight),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(AppSizes.cardRadius),
            child: SingleChildScrollView(
              physics: isTop
                  ? const BouncingScrollPhysics()
                  : const NeverScrollableScrollPhysics(),
              child: child,
            ),
          ),
        ),
      ),
    );
  }
}

class _StackIndicator extends StatelessWidget {
  const _StackIndicator({
    required this.labels,
    required this.active,
    required this.onTap,
  });

  final List<String> labels;
  final int active;
  final ValueChanged<int> onTap;

  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;

    return SizedBox(
      height: 36,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.pagePadding,
        ),
        itemCount: labels.length,
        separatorBuilder: (_, __) => const SizedBox(width: 6),
        itemBuilder: (_, i) {
          final bool on = i == active;
          return GestureDetector(
            onTap: () => onTap(i),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
              decoration: BoxDecoration(
                color: on
                    ? (isDark ? Colors.white : Colors.black87)
                    : (isDark
                        ? Colors.white.withValues(alpha: 0.07)
                        : Colors.black.withValues(alpha: 0.05)),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Center(
                child: AnimatedDefaultTextStyle(
                  duration: const Duration(milliseconds: 250),
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: on ? FontWeight.w700 : FontWeight.w500,
                    color: on
                        ? (isDark ? Colors.black : Colors.white)
                        : (isDark ? Colors.white54 : Colors.black45),
                  ),
                  child: Text(labels[i]),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
