import 'package:flutter/material.dart';

import '../../constants/app_constants.dart';

class CardStack extends StatefulWidget {
  const CardStack({
    super.key,
    required this.children,
    this.maxVisible = 4,
  });

  final List<Widget> children;
  final int maxVisible;

  @override
  State<CardStack> createState() => _CardStackState();
}

class _CardStackState extends State<CardStack>
    with SingleTickerProviderStateMixin {
  double _page = 0;
  late AnimationController _anim;
  Animation<double>? _snap;

  static const double _stackGap = 36.0;
  static const double _scaleStep = 0.06;
  static const double _opacityStep = 0.12;
  static const double _topInset = 12.0;

  @override
  void initState() {
    super.initState();
    _anim = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 450),
    )..addListener(() {
        if (_snap != null) setState(() => _page = _snap!.value);
      });
  }

  @override
  void dispose() {
    _anim.dispose();
    super.dispose();
  }

  void _onDragUpdate(DragUpdateDetails d) {
    _anim.stop();
    final double h = MediaQuery.of(context).size.height;
    final double delta = -d.delta.dy / (h * 0.38);
    setState(() {
      _page = (_page + delta).clamp(0.0, widget.children.length - 1.0);
    });
  }

  void _onDragEnd(DragEndDetails d) {
    final double h = MediaQuery.of(context).size.height;
    final double v = -d.velocity.pixelsPerSecond.dy / h;

    int target;
    if (v > 0.7) {
      target = _page.ceil();
    } else if (v < -0.7) {
      target = _page.floor();
    } else {
      target = _page.round();
    }
    target = target.clamp(0, widget.children.length - 1);

    _snap = Tween<double>(begin: _page, end: target.toDouble()).animate(
      CurvedAnimation(parent: _anim, curve: Curves.easeOutCubic),
    );
    _anim
      ..reset()
      ..forward();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.pagePadding,
            ),
            child: LayoutBuilder(
              builder: (context, constraints) {
                final double cardH = constraints.maxHeight -
                    _topInset -
                    (widget.maxVisible - 1) * _stackGap;

                return GestureDetector(
                  onVerticalDragUpdate: _onDragUpdate,
                  onVerticalDragEnd: _onDragEnd,
                  behavior: HitTestBehavior.translucent,
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: _renderCards(cardH),
                  ),
                );
              },
            ),
          ),
        ),
        const SizedBox(height: 8),
        _DotIndicator(count: widget.children.length, page: _page),
        const SizedBox(height: 12),
      ],
    );
  }

  List<Widget> _renderCards(double cardH) {
    final int current = _page.round();
    final List<_Entry> entries = [];

    for (int i = 0; i < widget.children.length; i++) {
      final double diff = i - _page;
      if (diff < -1.2 || diff > widget.maxVisible + 0.5) continue;
      entries.add(_Entry(i, diff));
    }

    entries.sort((a, b) => b.diff.compareTo(a.diff));

    final bool isDark = Theme.of(context).brightness == Brightness.dark;

    return entries.map((e) {
      final double diff = e.diff;
      double y, s, o;
      double shadowAlpha;

      if (diff < 0) {
        final double screenH = MediaQuery.of(context).size.height;
        y = _topInset + diff * screenH * 0.6;
        s = 1.0;
        o = (1.0 + diff * 1.3).clamp(0.0, 1.0);
        shadowAlpha = 0;
      } else {
        y = _topInset + diff * _stackGap;
        s = (1.0 - diff * _scaleStep).clamp(0.82, 1.0);
        o = (1.0 - diff * _opacityStep).clamp(0.0, 1.0);
        shadowAlpha = (0.12 - diff * 0.03).clamp(0.0, 0.12);
      }

      return Transform.translate(
        key: ValueKey<int>(e.index),
        offset: Offset(0, y),
        child: Transform.scale(
          scale: s,
          alignment: Alignment.topCenter,
          child: Opacity(
            opacity: o,
            child: IgnorePointer(
              ignoring: e.index != current,
              child: Container(
                width: double.infinity,
                height: cardH,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(AppSizes.cardRadius),
                  boxShadow: [
                    if (shadowAlpha > 0)
                      BoxShadow(
                        color: Colors.black.withValues(
                          alpha: isDark ? shadowAlpha * 2 : shadowAlpha,
                        ),
                        blurRadius: 24,
                        offset: const Offset(0, 10),
                      ),
                  ],
                ),
                child: widget.children[e.index],
              ),
            ),
          ),
        ),
      );
    }).toList();
  }
}

class _Entry {
  const _Entry(this.index, this.diff);
  final int index;
  final double diff;
}

class _DotIndicator extends StatelessWidget {
  const _DotIndicator({required this.count, required this.page});

  final int count;
  final double page;

  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    final Color base = isDark ? Colors.white : Colors.black;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(count, (i) {
        final double d = (i - page).abs();
        final double size = d < 0.5 ? 8 : 5;
        final double alpha = d < 0.5 ? 0.9 : 0.25;

        return AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          margin: const EdgeInsets.symmetric(horizontal: 3),
          width: size,
          height: size,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: base.withValues(alpha: alpha),
          ),
        );
      }),
    );
  }
}
