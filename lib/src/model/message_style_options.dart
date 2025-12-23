import 'package:flutter/material.dart';

import '../statement.dart';

/// Message style options.
///
/// message 类型 toast 的样式配置。
@immutable
class MessageStyleOptions {
  /// Info tone option.
  ///
  /// Info 消息配色。
  final InfoMessageColorOption info;

  /// Success tone option.
  ///
  /// Success 消息配色。
  final SuccessMessageColorOption success;

  /// Warning tone option.
  ///
  /// Warning 消息配色。
  final WarningMessageColorOption warning;

  /// Error tone option.
  ///
  /// Error 消息配色。
  final ErrorMessageColorOption error;

  /// Message inner padding.
  ///
  /// 消息内容内边距。
  final EdgeInsetsGeometry padding;

  /// Message outer margin.
  ///
  /// 消息内容外边距。
  final EdgeInsetsGeometry? margin;

  /// Message border radius.
  ///
  /// 消息圆角。
  final BorderRadiusGeometry borderRadius;

  /// Message text style builder.
  ///
  /// 消息文本样式构建器。
  ///
  /// Tip: You can omit color here; internal code will merge the foreground color.
  ///
  /// 提示：这里可以不设置颜色，内部会 merge 前景色。
  final MessageTextStyleBuilder? textStyleBuilder;

  /// Create message style options.
  ///
  /// 创建 message 样式配置。
  const MessageStyleOptions({
    /// Info tone option.
    ///
    /// Info 消息配色。
    required this.info,

    /// Success tone option.
    ///
    /// Success 消息配色。
    required this.success,

    /// Warning tone option.
    ///
    /// Warning 消息配色。
    required this.warning,

    /// Error tone option.
    ///
    /// Error 消息配色。
    required this.error,

    /// Message inner padding.
    ///
    /// 消息内容内边距。
    required this.padding,

    /// Message outer margin.
    ///
    /// 消息内容外边距。
    this.margin,

    /// Message border radius.
    ///
    /// 消息圆角。
    required this.borderRadius,

    /// Message text style builder.
    ///
    /// 消息文本样式构建器。
    this.textStyleBuilder,
  });

  /// Returns a copy with the given fields replaced.
  ///
  /// 基于当前对象创建副本，并替换指定字段。
  MessageStyleOptions copyWith({
    /// Info tone option.
    ///
    /// Info 消息配色。
    InfoMessageColorOption? info,

    /// Success tone option.
    ///
    /// Success 消息配色。
    SuccessMessageColorOption? success,

    /// Warning tone option.
    ///
    /// Warning 消息配色。
    WarningMessageColorOption? warning,

    /// Error tone option.
    ///
    /// Error 消息配色。
    ErrorMessageColorOption? error,

    /// Message inner padding.
    ///
    /// 消息内容内边距。
    EdgeInsetsGeometry? padding,

    /// Message outer margin.
    ///
    /// 消息内容外边距。
    EdgeInsetsGeometry? margin,

    /// Message border radius.
    ///
    /// 消息圆角。
    BorderRadiusGeometry? borderRadius,

    /// Message text style builder.
    ///
    /// 消息文本样式构建器。
    MessageTextStyleBuilder? textStyleBuilder,
  }) {
    return MessageStyleOptions(
      info: info ?? this.info,
      success: success ?? this.success,
      warning: warning ?? this.warning,
      error: error ?? this.error,
      padding: padding ?? this.padding,
      margin: margin ?? this.margin,
      borderRadius: borderRadius ?? this.borderRadius,
      textStyleBuilder: textStyleBuilder ?? this.textStyleBuilder,
    );
  }
}

/// A pair of background + foreground colors.
///
/// 背景色 + 前景色 的组合。
@immutable
class ColorOption {
  /// Background color.
  ///
  /// 背景颜色。
  final Color backgroundColor;

  /// Foreground color.
  ///
  /// 前景颜色（通常用于文字/图标）。
  final Color foregroundColor;

  /// Create a color option.
  ///
  /// 创建颜色配置。
  const ColorOption({
    /// Background color.
    ///
    /// 背景颜色。
    required this.backgroundColor,

    /// Foreground color.
    ///
    /// 前景颜色。
    required this.foregroundColor,
  });

  /// Returns a copy with the given fields replaced.
  ///
  /// 基于当前对象创建副本，并替换指定字段。
  ColorOption copyWith({
    /// Background color.
    ///
    /// 背景颜色。
    Color? backgroundColor,

    /// Foreground color.
    ///
    /// 前景颜色。
    Color? foregroundColor,
  }) {
    return ColorOption(
      backgroundColor: backgroundColor ?? this.backgroundColor,
      foregroundColor: foregroundColor ?? this.foregroundColor,
    );
  }
}

/// A tone set for message colors.
///
/// 消息颜色的色调集合（浅色调/主色调）。
@immutable
class MessageColorTone {
  /// Light tone.
  ///
  /// 浅色调。
  final ColorOption primaryLight;

  /// Primary tone.
  ///
  /// 主色调。
  final ColorOption primary;

  /// Create a tone set.
  ///
  /// 创建色调集合。
  const MessageColorTone({
    /// Light tone.
    ///
    /// 浅色调。
    required this.primaryLight,

    /// Primary tone.
    ///
    /// 主色调。
    required this.primary,
  });

  /// Returns a copy with the given fields replaced.
  ///
  /// 基于当前对象创建副本，并替换指定字段。
  MessageColorTone copyWith({
    /// Light tone.
    ///
    /// 浅色调。
    ColorOption? primaryLight,

    /// Primary tone.
    ///
    /// 主色调。
    ColorOption? primary,
  }) {
    return MessageColorTone(
      primaryLight: primaryLight ?? this.primaryLight,
      primary: primary ?? this.primary,
    );
  }
}

/// Info message color tone.
///
/// Info 消息颜色色调。
class InfoMessageColorOption extends MessageColorTone {
  /// Create info tone.
  ///
  /// 创建 info 色调。
  const InfoMessageColorOption({
    required super.primaryLight,
    required super.primary,
  });
}

/// Success message color tone.
///
/// Success 消息颜色色调。
class SuccessMessageColorOption extends MessageColorTone {
  /// Create success tone.
  ///
  /// 创建 success 色调。
  const SuccessMessageColorOption({
    required super.primaryLight,
    required super.primary,
  });
}

/// Warning message color tone.
///
/// Warning 消息颜色色调。
class WarningMessageColorOption extends MessageColorTone {
  /// Create warning tone.
  ///
  /// 创建 warning 色调。
  const WarningMessageColorOption({
    required super.primaryLight,
    required super.primary,
  });
}

/// Error message color tone.
///
/// Error 消息颜色色调。
class ErrorMessageColorOption extends MessageColorTone {
  /// Create error tone.
  ///
  /// 创建 error 色调。
  const ErrorMessageColorOption({
    required super.primaryLight,
    required super.primary,
  });
}
