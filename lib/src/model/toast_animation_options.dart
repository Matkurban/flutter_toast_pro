import 'package:flutter/material.dart';

/// Standard enter/exit animation options for toast overlays.
///
/// toast 覆盖层进入/退出动画的标准配置。
@immutable
class ToastAnimationOptions {
  /// Create animation options.
  ///
  /// 创建动画配置。
  const ToastAnimationOptions({
    /// Forward animation duration.
    ///
    /// 进入动画时长。
    this.duration = const Duration(milliseconds: 200),

    /// Reverse animation duration.
    ///
    /// 退出动画时长（为空时使用 [duration]）。
    this.reverseDuration,

    /// Forward animation curve.
    ///
    /// 进入动画曲线。
    this.curve = Curves.easeOutCubic,

    /// Reverse animation curve.
    ///
    /// 退出动画曲线。
    this.reverseCurve = Curves.easeInCubic,

    /// Custom transition builder.
    ///
    /// 自定义过渡动画构建器。
    ///
    /// If null, a default (fade + slight slide) transition is used.
    ///
    /// 若为空，将使用默认的（淡入淡出 + 轻微位移）过渡。
    this.transitionBuilder,
  });

  /// Forward animation duration.
  ///
  /// 进入动画时长。
  final Duration duration;

  /// Reverse animation duration.
  ///
  /// 退出动画时长（为空时使用 [duration]）。
  final Duration? reverseDuration;

  /// Forward animation curve.
  ///
  /// 进入动画曲线。
  final Curve curve;

  /// Reverse animation curve.
  ///
  /// 退出动画曲线。
  final Curve reverseCurve;

  /// Custom transition builder.
  ///
  /// 自定义过渡动画构建器。
  ///
  /// Parameters:
  /// - context: build context
  /// - animation: animation value (0..1)
  /// - child: overlay content
  ///
  /// 参数说明：
  /// - context：构建上下文
  /// - animation：动画值（0..1）
  /// - child：覆盖层内容
  final Widget Function(
    BuildContext context,
    Animation<double> animation,
    Widget child,
  )?
  transitionBuilder;

  /// Returns a copy with the given fields replaced.
  ///
  /// 基于当前对象创建副本，并替换指定字段。
  ToastAnimationOptions copyWith({
    /// Forward animation duration.
    ///
    /// 进入动画时长。
    Duration? duration,

    /// Reverse animation duration.
    ///
    /// 退出动画时长。
    Duration? reverseDuration,

    /// Forward animation curve.
    ///
    /// 进入动画曲线。
    Curve? curve,

    /// Reverse animation curve.
    ///
    /// 退出动画曲线。
    Curve? reverseCurve,

    /// Custom transition builder.
    ///
    /// 自定义过渡动画构建器。
    Widget Function(
      BuildContext context,
      Animation<double> animation,
      Widget child,
    )?
    transitionBuilder,
  }) {
    return ToastAnimationOptions(
      duration: duration ?? this.duration,
      reverseDuration: reverseDuration ?? this.reverseDuration,
      curve: curve ?? this.curve,
      reverseCurve: reverseCurve ?? this.reverseCurve,
      transitionBuilder: transitionBuilder ?? this.transitionBuilder,
    );
  }
}
