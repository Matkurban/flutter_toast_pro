import 'package:flutter/material.dart';

import '../statement.dart';

///message消息的颜色自定义
class MessageStyleOptions {
  ///Info消息颜色自定义
  final InfoMessageColorOption info;

  ///Success消息颜色自定义
  final SuccessMessageColorOption success;

  ///Warning消息颜色自定义
  final WarningMessageColorOption warning;

  ///Error消息颜色自定义
  final ErrorMessageColorOption error;

  ///消息内边距
  final EdgeInsetsGeometry padding;

  ///消息外边距
  final EdgeInsetsGeometry? margin;

  ///消息边框圆角
  final BorderRadiusGeometry borderRadius;

  ///消息文本样式构建器
  ///可以不传颜色，内部会 merge 设置颜色
  final MessageTextStyleBuilder? textStyleBuilder;

  MessageStyleOptions({
    required this.info,
    required this.success,
    required this.warning,
    required this.error,
    required this.padding,
    this.margin,
    required this.borderRadius,
    this.textStyleBuilder,
  });

  MessageStyleOptions copyWith({
    InfoMessageColorOption? info,
    SuccessMessageColorOption? success,
    WarningMessageColorOption? warning,
    ErrorMessageColorOption? error,
    EdgeInsetsGeometry? padding,
    EdgeInsetsGeometry? margin,
    BorderRadiusGeometry? borderRadius,
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

class ColorOption {
  ///背景颜色
  final Color backgroundColor;

  ///前景颜色
  final Color foregroundColor;

  ColorOption({required this.backgroundColor, required this.foregroundColor});

  ColorOption copyWith({Color? backgroundColor, Color? foregroundColor}) {
    return ColorOption(
      backgroundColor: backgroundColor ?? this.backgroundColor,
      foregroundColor: foregroundColor ?? this.foregroundColor,
    );
  }
}

class MessageColorTone {
  ///浅色调颜色
  final ColorOption primaryLight;

  ///主色调颜色
  final ColorOption primary;

  MessageColorTone({required this.primaryLight, required this.primary});

  MessageColorTone copyWith({ColorOption? primaryLight, ColorOption? primary}) {
    return MessageColorTone(
      primaryLight: primaryLight ?? this.primaryLight,
      primary: primary ?? this.primary,
    );
  }
}

///Info消息颜色自定义
class InfoMessageColorOption extends MessageColorTone {
  InfoMessageColorOption({required super.primaryLight, required super.primary});
}

///Success消息颜色自定义
class SuccessMessageColorOption extends MessageColorTone {
  SuccessMessageColorOption({required super.primaryLight, required super.primary});
}

///Warning消息颜色自定义
class WarningMessageColorOption extends MessageColorTone {
  WarningMessageColorOption({required super.primaryLight, required super.primary});
}

///Error消息颜色自定义
class ErrorMessageColorOption extends MessageColorTone {
  ErrorMessageColorOption({required super.primaryLight, required super.primary});
}
