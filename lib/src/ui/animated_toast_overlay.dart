import 'package:flutter/material.dart';

import '../model/toast_animation_options.dart';

/// A small helper widget to animate toast overlay appearance/disappearance.
///
/// 用于 toast 覆盖层显示/隐藏动画的轻量辅助组件。
class AnimatedToastOverlay extends StatefulWidget {
  /// Create an animated toast overlay wrapper.
  ///
  /// 创建一个带动画的 toast 覆盖层包装组件。
  const AnimatedToastOverlay({
    super.key,
    required this.visible,
    required this.options,
    required this.child,
  });

  /// Whether the overlay is visible.
  ///
  /// 覆盖层是否可见。
  final bool visible;

  /// Animation options.
  ///
  /// 动画配置。
  final ToastAnimationOptions options;

  /// The overlay content.
  ///
  /// 覆盖层内容。
  final Widget child;

  @override
  State<AnimatedToastOverlay> createState() => _AnimatedToastOverlayState();
}

class _AnimatedToastOverlayState extends State<AnimatedToastOverlay>
    with SingleTickerProviderStateMixin {
  /// Animation controller.
  ///
  /// 动画控制器。
  late final AnimationController _controller;

  /// Animation used by transitions.
  ///
  /// 过渡动画使用的 Animation。
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    // Build controller based on current options.
    //
    // 根据当前 options 构建 controller。
    _controller = AnimationController(
      vsync: this,
      duration: widget.options.duration,
      reverseDuration:
          widget.options.reverseDuration ?? widget.options.duration,
    );

    // Apply curves.
    //
    // 应用曲线。
    _animation = CurvedAnimation(
      parent: _controller,
      curve: widget.options.curve,
      reverseCurve: widget.options.reverseCurve,
    );

    // If initially visible, set progress to 1.
    //
    // 如果初始就是可见状态，则直接设置到 1。
    if (widget.visible) {
      _controller.value = 1;
    }
  }

  @override
  void didUpdateWidget(covariant AnimatedToastOverlay oldWidget) {
    super.didUpdateWidget(oldWidget);

    // Update controller durations when options change.
    //
    // 当 options 变化时更新 controller 时长。
    if (oldWidget.options.duration != widget.options.duration ||
        oldWidget.options.reverseDuration != widget.options.reverseDuration) {
      _controller.duration = widget.options.duration;
      _controller.reverseDuration =
          widget.options.reverseDuration ?? widget.options.duration;
    }

    // Play animation based on visibility.
    //
    // 根据 visible 执行动画。
    if (widget.visible) {
      _controller.forward();
    } else {
      _controller.reverse();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // If user provided custom transition, use it.
    //
    // 如果用户提供自定义过渡动画，则优先使用。
    final transition = widget.options.transitionBuilder;
    if (transition != null) {
      return transition(context, _animation, widget.child);
    }

    // Default: fade + slight slide.
    //
    // 默认动画：淡入淡出 + 轻微位移。
    return FadeTransition(
      opacity: _animation,
      child: SlideTransition(
        position: Tween<Offset>(
          begin: const Offset(0, -0.03),
          end: Offset.zero,
        ).animate(_animation),
        child: widget.child,
      ),
    );
  }
}
