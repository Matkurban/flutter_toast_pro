import 'package:flutter/material.dart';

import 'toast_animation_options.dart';

/// Common overlay options shared by message/loading/progress.
///
/// message/loading/progress 共用的覆盖层（Overlay）配置。
@immutable
class OverlayOptions {
  /// Create overlay options.
  ///
  /// 创建覆盖层配置。
  const OverlayOptions({
    /// Overlay background color.
    ///
    /// 覆盖层背景颜色（遮罩颜色）。
    this.overlayColor = Colors.transparent,

    /// Whether the overlay should ignore pointer events.
    ///
    /// 覆盖层是否忽略所有指针事件（触摸/点击）。
    this.ignoring = true,

    /// Default alignment of the toast content.
    ///
    /// toast 内容的默认对齐位置（当事件未指定 alignment 时使用）。
    this.defaultAlignment,

    /// Whether to wrap overlay content with SafeArea.
    ///
    /// 是否使用 SafeArea 包裹覆盖层内容。
    this.safeArea = true,

    /// Whether tapping the barrier/background dismisses the toast.
    ///
    /// 点击遮罩/背景是否关闭 toast。
    ///
    /// Note: When true, barrier must receive taps.
    ///
    /// 注意：为 true 时遮罩必须能接收点击事件。
    this.barrierDismissible = false,

    /// Whether tapping the toast content dismisses it.
    ///
    /// 点击 toast 内容是否关闭。
    this.tapToDismiss = false,

    /// Optional semantics label for accessibility.
    ///
    /// 无障碍语义标签，用于辅助功能（Accessibility）。
    this.semanticsLabel,

    /// Enter/exit animation options.
    ///
    /// 进入/退出动画配置。
    this.animation = const ToastAnimationOptions(),
  });

  /// Overlay background color.
  ///
  /// 覆盖层背景颜色（遮罩颜色）。
  final Color overlayColor;

  /// Whether the overlay should ignore pointer events.
  ///
  /// 覆盖层是否忽略所有指针事件（触摸/点击）。
  final bool ignoring;

  /// Default alignment of the toast content.
  ///
  /// toast 内容的默认对齐位置（当事件未指定 alignment 时使用）。
  final Alignment? defaultAlignment;

  /// Whether to wrap overlay content with SafeArea.
  ///
  /// 是否使用 SafeArea 包裹覆盖层内容。
  final bool safeArea;

  /// Whether tapping the barrier/background dismisses the toast.
  ///
  /// 点击遮罩/背景是否关闭 toast。
  ///
  /// Note: When true, barrier will receive pointer events even if [ignoring] is true.
  ///
  /// 注意：为 true 时，即使 [ignoring] 为 true，遮罩也需要能接收指针事件。
  final bool barrierDismissible;

  /// Whether tapping the toast content dismisses it.
  ///
  /// 点击 toast 内容是否关闭。
  final bool tapToDismiss;

  /// Optional semantics label for accessibility.
  ///
  /// 无障碍语义标签，用于辅助功能（Accessibility）。
  final String? semanticsLabel;

  /// Enter/exit animation options.
  ///
  /// 进入/退出动画配置。
  final ToastAnimationOptions animation;

  /// Returns a copy with the given fields replaced.
  ///
  /// 基于当前对象创建副本，并替换指定字段。
  OverlayOptions copyWith({
    /// Overlay background color.
    ///
    /// 覆盖层背景颜色（遮罩颜色）。
    Color? overlayColor,

    /// Whether the overlay should ignore pointer events.
    ///
    /// 覆盖层是否忽略所有指针事件（触摸/点击）。
    bool? ignoring,

    /// Default alignment of the toast content.
    ///
    /// toast 内容的默认对齐位置。
    Alignment? defaultAlignment,

    /// Whether to wrap overlay content with SafeArea.
    ///
    /// 是否使用 SafeArea 包裹覆盖层内容。
    bool? safeArea,

    /// Whether tapping the barrier/background dismisses the toast.
    ///
    /// 点击遮罩/背景是否关闭 toast。
    bool? barrierDismissible,

    /// Whether tapping the toast content dismisses it.
    ///
    /// 点击 toast 内容是否关闭。
    bool? tapToDismiss,

    /// Optional semantics label for accessibility.
    ///
    /// 无障碍语义标签。
    String? semanticsLabel,

    /// Enter/exit animation options.
    ///
    /// 进入/退出动画配置。
    ToastAnimationOptions? animation,
  }) {
    return OverlayOptions(
      overlayColor: overlayColor ?? this.overlayColor,
      ignoring: ignoring ?? this.ignoring,
      defaultAlignment: defaultAlignment ?? this.defaultAlignment,
      safeArea: safeArea ?? this.safeArea,
      barrierDismissible: barrierDismissible ?? this.barrierDismissible,
      tapToDismiss: tapToDismiss ?? this.tapToDismiss,
      semanticsLabel: semanticsLabel ?? this.semanticsLabel,
      animation: animation ?? this.animation,
    );
  }
}
