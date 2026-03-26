import 'package:flutter/material.dart';

import '../model/toast_position.dart';

/// Wraps a toast widget to allow swipe-to-dismiss.
///
/// - [ToastPosition.top] → swipe up to dismiss
/// - [ToastPosition.bottom] → swipe down to dismiss
/// - [ToastPosition.center] → swipe in any vertical direction
class DismissibleToast extends StatefulWidget {
  const DismissibleToast({
    super.key,
    required this.position,
    required this.enabled,
    required this.onDismissed,
    required this.child,
  });

  final ToastPosition position;
  final bool enabled;
  final VoidCallback onDismissed;
  final Widget child;

  @override
  State<DismissibleToast> createState() => _DismissibleToastState();
}

class _DismissibleToastState extends State<DismissibleToast> with SingleTickerProviderStateMixin {
  double _dragOffset = 0;
  late final AnimationController _returnController;
  late Animation<double> _returnAnimation;

  static const double _dismissThreshold = 0.3;
  static const double _maxDragExtent = 200.0;

  @override
  void initState() {
    super.initState();
    _returnController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );
  }

  @override
  void dispose() {
    _returnController.dispose();
    super.dispose();
  }

  bool _isDismissDirection(double dy) {
    switch (widget.position) {
      case ToastPosition.top:
        return dy < 0; // swipe up
      case ToastPosition.bottom:
        return dy > 0; // swipe down
      case ToastPosition.center:
        return true; // any direction
    }
  }

  void _onPanUpdate(DragUpdateDetails details) {
    if (!widget.enabled) return;
    setState(() {
      _dragOffset += details.delta.dy;
      _dragOffset = _dragOffset.clamp(-_maxDragExtent, _maxDragExtent);
    });
  }

  void _onPanEnd(DragEndDetails details) {
    if (!widget.enabled) return;
    final fraction = _dragOffset.abs() / _maxDragExtent;
    if (fraction > _dismissThreshold && _isDismissDirection(_dragOffset)) {
      widget.onDismissed();
    } else {
      // Spring back.
      final startOffset = _dragOffset;
      _returnAnimation = Tween<double>(
        begin: startOffset,
        end: 0,
      ).animate(CurvedAnimation(parent: _returnController, curve: Curves.easeOutCubic));
      _returnController.forward(from: 0).then((_) {
        if (mounted) setState(() => _dragOffset = 0);
      });
      _returnAnimation.addListener(() {
        if (mounted) setState(() => _dragOffset = _returnAnimation.value);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!widget.enabled) return widget.child;

    final opacity = (1.0 - (_dragOffset.abs() / _maxDragExtent) * 0.6).clamp(0.0, 1.0);

    return GestureDetector(
      onVerticalDragUpdate: _onPanUpdate,
      onVerticalDragEnd: _onPanEnd,
      child: Transform.translate(
        offset: Offset(0, _dragOffset),
        child: Opacity(opacity: opacity, child: widget.child),
      ),
    );
  }
}
