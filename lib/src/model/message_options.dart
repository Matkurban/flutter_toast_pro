import 'package:flutter/material.dart';

import 'effect_type.dart';
import 'message_style_options.dart';
import 'overlay_options.dart';

/// Toast message configuration.
///
/// 消息类型 Toast 的配置项。
@immutable
class ToastMessageOptions {
  /// Create message options.
  ///
  /// 创建 message 配置。
  const ToastMessageOptions({
    /// Overlay behavior & barrier options.
    ///
    /// 覆盖层行为与遮罩配置。
    this.overlay = const OverlayOptions(
      overlayColor: Colors.transparent,
      ignoring: true,
    ),

    /// Whether to auto-close message toasts.
    ///
    /// 是否自动关闭 message toast。
    this.autoClose = true,

    /// Auto close duration for message toasts.
    ///
    /// message toast 的自动关闭时长。
    this.closeDuration = const Duration(seconds: 2),

    /// Default effect type for message toasts (used when event doesn't specify one).
    ///
    /// message toast 的默认效果类型（当事件未指定时使用）。
    this.effectType = EffectType.primaryLight,

    /// Style options for the built-in default message widget.
    ///
    /// 内置默认 message 组件的样式配置。
    this.style,
  });

  /// Overlay behavior & barrier options.
  ///
  /// 覆盖层行为与遮罩配置。
  final OverlayOptions overlay;

  /// Whether to auto-close message toasts.
  ///
  /// 是否自动关闭 message toast。
  final bool autoClose;

  /// Auto close duration for message toasts.
  ///
  /// message toast 的自动关闭时长。
  final Duration closeDuration;

  /// Default effect type for message toasts.
  ///
  /// message toast 的默认效果类型。
  final EffectType effectType;

  /// Style options for the built-in default message widget.
  ///
  /// 内置默认 message 组件的样式配置。
  final MessageStyleOptions? style;

  /// Returns a copy with the given fields replaced.
  ///
  /// 基于当前对象创建副本，并替换指定字段。
  ToastMessageOptions copyWith({
    /// Overlay behavior & barrier options.
    ///
    /// 覆盖层行为与遮罩配置。
    OverlayOptions? overlay,

    /// Whether to auto-close message toasts.
    ///
    /// 是否自动关闭 message toast。
    bool? autoClose,

    /// Auto close duration for message toasts.
    ///
    /// message toast 的自动关闭时长。
    Duration? closeDuration,

    /// Default effect type for message toasts.
    ///
    /// message toast 的默认效果类型。
    EffectType? effectType,

    /// Style options for the built-in default message widget.
    ///
    /// 内置默认 message 组件的样式配置。
    MessageStyleOptions? style,
  }) {
    return ToastMessageOptions(
      overlay: overlay ?? this.overlay,
      autoClose: autoClose ?? this.autoClose,
      closeDuration: closeDuration ?? this.closeDuration,
      effectType: effectType ?? this.effectType,
      style: style ?? this.style,
    );
  }
}
