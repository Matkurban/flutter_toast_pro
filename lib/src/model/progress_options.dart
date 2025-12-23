import 'package:flutter/material.dart';

import 'overlay_options.dart';
import 'progress_style_options.dart';

/// Toast progress configuration.
///
/// progress 类型 Toast 的配置项。
@immutable
class ToastProgressOptions {
  /// Create progress options.
  ///
  /// 创建 progress 配置。
  const ToastProgressOptions({
    /// Overlay behavior & barrier options.
    ///
    /// 覆盖层行为与遮罩配置。
    this.overlay = const OverlayOptions(
      overlayColor: Colors.transparent,
      ignoring: false,
    ),

    /// Style options for the built-in default progress widget.
    ///
    /// 内置默认 progress 组件的样式配置。
    this.style = const ProgressStyleOptions(),
  });

  /// Overlay behavior & barrier options.
  ///
  /// 覆盖层行为与遮罩配置。
  final OverlayOptions overlay;

  /// Style options for the built-in default progress widget.
  ///
  /// 内置默认 progress 组件的样式配置。
  final ProgressStyleOptions style;

  /// Returns a copy with the given fields replaced.
  ///
  /// 基于当前对象创建副本，并替换指定字段。
  ToastProgressOptions copyWith({
    /// Overlay behavior & barrier options.
    ///
    /// 覆盖层行为与遮罩配置。
    OverlayOptions? overlay,

    /// Style options for the built-in default progress widget.
    ///
    /// 内置默认 progress 组件的样式配置。
    ProgressStyleOptions? style,
  }) {
    return ToastProgressOptions(
      overlay: overlay ?? this.overlay,
      style: style ?? this.style,
    );
  }
}
