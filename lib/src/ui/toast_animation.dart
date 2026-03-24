import 'package:flutter/material.dart';

import '../model/toast_position.dart';

/// Wraps a single toast item with enter / exit animations.
///
/// The animation direction is position-aware:
/// - [ToastPosition.top]: slides down from above
/// - [ToastPosition.bottom]: slides up from below
/// - [ToastPosition.center]: scales + fades in
class ToastAnimationWrapper extends StatefulWidget {
  const ToastAnimationWrapper({
    super.key,
    required this.position,
    required this.duration,
    required this.reverseDuration,
    required this.curve,
    required this.reverseCurve,
    required this.onDismissed,
    required this.child,
  });

  final ToastPosition position;
  final Duration duration;
  final Duration reverseDuration;
  final Curve curve;
  final Curve reverseCurve;
  final VoidCallback onDismissed;
  final Widget child;

  @override
  State<ToastAnimationWrapper> createState() => ToastAnimationWrapperState();
}

class ToastAnimationWrapperState extends State<ToastAnimationWrapper>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late Animation<double> _curvedAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
      reverseDuration: widget.reverseDuration,
    );
    _curvedAnimation = CurvedAnimation(
      parent: _controller,
      curve: widget.curve,
      reverseCurve: widget.reverseCurve,
    );
    _controller.forward();
  }

  /// Reverse the animation, then call [onDismissed].
  Future<void> animateOut() async {
    if (!mounted) return;
    await _controller.reverse();
    widget.onDismissed();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _curvedAnimation,
      builder: (context, child) {
        final value = _curvedAnimation.value;
        switch (widget.position) {
          case ToastPosition.top:
            return Transform.translate(
              offset: Offset(0, -30 * (1 - value)),
              child: Opacity(opacity: value, child: child),
            );
          case ToastPosition.bottom:
            return Transform.translate(
              offset: Offset(0, 30 * (1 - value)),
              child: Opacity(opacity: value, child: child),
            );
          case ToastPosition.center:
            return Transform.scale(
              scale: 0.85 + 0.15 * value,
              child: Opacity(opacity: value, child: child),
            );
        }
      },
      child: widget.child,
    );
  }
}
