import 'package:flutter/material.dart';

import 'loading_style_options.dart';
import 'overlay_options.dart';

/// Toast loading configuration.
///
/// loading 类型 Toast 的配置项。
@immutable
class ToastLoadingOptions {
  /// Create loading options.
  ///
  /// 创建 loading 配置。
  const ToastLoadingOptions({
    /// Overlay behavior & barrier options.
    ///
    /// 覆盖层行为与遮罩配置。
    this.overlay = const OverlayOptions(
      overlayColor: Colors.transparent,
      ignoring: false,
    ),

    /// Style options for the built-in default loading widget.
    ///
    /// 内置默认 loading 组件的样式配置。
    this.style = const LoadingStyleOptions(),
  });

  /// Overlay behavior & barrier options.
  ///
  /// 覆盖层行为与遮罩配置。
  final OverlayOptions overlay;

  /// Style options for the built-in default loading widget.
  ///
  /// 内置默认 loading 组件的样式配置。
  final LoadingStyleOptions style;

  /// Returns a copy with the given fields replaced.
  ///
  /// 基于当前对象创建副本，并替换指定字段。
  ToastLoadingOptions copyWith({
    /// Overlay behavior & barrier options.
    ///
    /// 覆盖层行为与遮罩配置。
    OverlayOptions? overlay,

    /// Style options for the built-in default loading widget.
    ///
    /// 内置默认 loading 组件的样式配置。
    LoadingStyleOptions? style,
  }) {
    return ToastLoadingOptions(
      overlay: overlay ?? this.overlay,
      style: style ?? this.style,
    );
  }
}
