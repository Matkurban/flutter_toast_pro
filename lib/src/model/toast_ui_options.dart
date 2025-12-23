import 'package:flutter/material.dart';

import 'loading_options.dart';
import 'message_options.dart';
import 'progress_options.dart';

/// Standard UI configuration for FlutterToastPro.
///
/// FlutterToastPro 的标准 UI 配置入口。
///
/// This is a single place to configure text direction and per-type
/// (message/loading/progress) overlay + style options.
///
/// 你可以在这里统一配置文字方向，以及 message/loading/progress 三类 toast 的
/// overlay 行为与样式参数。
@immutable
class ToastUiOptions {
  /// Create UI options.
  ///
  /// 创建 UI 配置。
  const ToastUiOptions({
    /// Text direction used by the wrapper (LTR/RTL).
    ///
    /// Wrapper 使用的文字方向（LTR/RTL）。
    this.textDirection = TextDirection.ltr,

    /// Message toast options.
    ///
    /// message toast 的配置项。
    this.message = const ToastMessageOptions(),

    /// Loading toast options.
    ///
    /// loading toast 的配置项。
    this.loading = const ToastLoadingOptions(),

    /// Progress toast options.
    ///
    /// progress toast 的配置项。
    this.progress = const ToastProgressOptions(),
  });

  /// Text direction used by the wrapper (LTR/RTL).
  ///
  /// Wrapper 使用的文字方向（LTR/RTL）。
  final TextDirection textDirection;

  /// Message toast options.
  ///
  /// message toast 的配置项。
  final ToastMessageOptions message;

  /// Loading toast options.
  ///
  /// loading toast 的配置项。
  final ToastLoadingOptions loading;

  /// Progress toast options.
  ///
  /// progress toast 的配置项。
  final ToastProgressOptions progress;

  /// Returns a copy with the given fields replaced.
  ///
  /// 基于当前对象创建副本，并替换指定字段。
  ToastUiOptions copyWith({
    /// Text direction used by the wrapper (LTR/RTL).
    ///
    /// Wrapper 使用的文字方向（LTR/RTL）。
    TextDirection? textDirection,

    /// Message toast options.
    ///
    /// message toast 的配置项。
    ToastMessageOptions? message,

    /// Loading toast options.
    ///
    /// loading toast 的配置项。
    ToastLoadingOptions? loading,

    /// Progress toast options.
    ///
    /// progress toast 的配置项。
    ToastProgressOptions? progress,
  }) {
    return ToastUiOptions(
      textDirection: textDirection ?? this.textDirection,
      message: message ?? this.message,
      loading: loading ?? this.loading,
      progress: progress ?? this.progress,
    );
  }
}
