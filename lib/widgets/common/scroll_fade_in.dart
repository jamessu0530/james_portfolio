import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class ScrollFadeIn extends StatefulWidget {
  const ScrollFadeIn({
    super.key,
    required this.child,
    this.offset = const Offset(0, 40),
    this.duration = const Duration(milliseconds: 500),
  });

  final Widget child;
  final Offset offset;
  final Duration duration;

  @override
  State<ScrollFadeIn> createState() => _ScrollFadeInState();
}

class _ScrollFadeInState extends State<ScrollFadeIn>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;
  late final Animation<double> _opacity;
  late final Animation<Offset> _position;
  bool _triggered = false;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(vsync: this, duration: widget.duration);
    _opacity = CurvedAnimation(parent: _ctrl, curve: Curves.easeOut);
    _position = Tween<Offset>(
      begin: widget.offset,
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _ctrl, curve: Curves.easeOutCubic));
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  void _checkVisibility() {
    if (_triggered) return;
    final RenderObject? renderObj = context.findRenderObject();
    if (renderObj == null || renderObj is! RenderBox || !renderObj.hasSize) return;

    final RenderAbstractViewport? viewport =
        RenderAbstractViewport.of(renderObj);
    if (viewport == null) return;

    final RevealedOffset offsetToReveal =
        viewport.getOffsetToReveal(renderObj, 0.0);
    final double vpHeight =
        (viewport as RenderBox).size.height;
    final ScrollableState? scrollable = Scrollable.maybeOf(context);
    if (scrollable == null) return;

    final double scrollOffset = scrollable.position.pixels;
    final double top = offsetToReveal.offset - scrollOffset;

    if (top < vpHeight * 0.92) {
      _triggered = true;
      _ctrl.forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollNotification>(
      onNotification: (_) {
        _checkVisibility();
        return false;
      },
      child: AnimatedBuilder(
        animation: _ctrl,
        builder: (context, child) {
          WidgetsBinding.instance.addPostFrameCallback((_) => _checkVisibility());
          return Opacity(
            opacity: _opacity.value,
            child: Transform.translate(
              offset: _position.value,
              child: child,
            ),
          );
        },
        child: widget.child,
      ),
    );
  }
}
