import 'package:flutter/material.dart';

/// UI style options for the default progress widget.
///
/// 默认 progress 组件的样式配置。
@immutable
class ProgressStyleOptions {
  const ProgressStyleOptions({
    this.padding = const EdgeInsets.all(10),
    this.margin,
    this.decoration,
    this.backgroundColor = const Color(0x4D000000),
    this.borderRadius = const BorderRadius.all(Radius.circular(10)),
    this.constraints,
    this.safeArea = true,
    this.semanticsLabel,
    this.indicatorSize = 48,
    this.indicatorConstraints,
    this.indicatorColor = const Color(0xFF1f65f3),
    this.indicatorBackgroundColor,
    this.messageTextStyle,
    this.messageSpacing = 8,
    this.alignment = Alignment.center,
  });

  /// Inner padding of the content card.
  ///
  /// 内容卡片的内边距。
  final EdgeInsetsGeometry padding;

  /// Outer margin of the content card.
  ///
  /// 内容卡片的外边距。
  final EdgeInsetsGeometry? margin;

  /// Full decoration of the content card.
  ///
  /// 内容卡片的完整装饰（若设置，会优先于 [backgroundColor]/[borderRadius]）。
  final Decoration? decoration;

  /// Background color of the content card.
  ///
  /// 内容卡片背景颜色。
  final Color backgroundColor;

  /// Border radius of the content card.
  ///
  /// 内容卡片圆角。
  final BorderRadiusGeometry borderRadius;

  /// Optional constraints for the content card.
  ///
  /// 内容卡片的约束（可限制最大宽高等）。
  final BoxConstraints? constraints;

  /// Whether to wrap with SafeArea.
  ///
  /// 是否使用 SafeArea 包裹。
  final bool safeArea;

  /// Optional semantics label for accessibility.
  ///
  /// 无障碍语义标签（Accessibility）。
  final String? semanticsLabel;

  /// Progress indicator size.
  ///
  /// 进度指示器尺寸。
  final double indicatorSize;

  /// Constraints override for the indicator.
  ///
  /// 指示器约束（用于覆盖默认 constraints）。
  final BoxConstraints? indicatorConstraints;

  /// Indicator foreground color.
  ///
  /// 指示器前景颜色。
  final Color indicatorColor;

  /// Indicator background color.
  ///
  /// 指示器背景颜色（为空时使用 [indicatorColor] 的 0.3 透明度）。
  final Color? indicatorBackgroundColor;

  /// Text style for message.
  ///
  /// 文案文本样式。
  final TextStyle? messageTextStyle;

  /// Spacing between indicator and message.
  ///
  /// 指示器与文案之间的间距。
  final double messageSpacing;

  /// Alignment of the progress widget within the overlay.
  ///
  /// progress 组件在覆盖层中的对齐位置。
  final Alignment alignment;

  /// Returns a copy with the given fields replaced.
  ///
  /// 基于当前对象创建副本，并替换指定字段。
  ProgressStyleOptions copyWith({
    EdgeInsetsGeometry? padding,
    EdgeInsetsGeometry? margin,
    Decoration? decoration,
    Color? backgroundColor,
    BorderRadiusGeometry? borderRadius,
    BoxConstraints? constraints,
    double? maxWidth,
    bool? safeArea,
    String? semanticsLabel,
    double? indicatorSize,
    BoxConstraints? indicatorConstraints,
    Color? indicatorColor,
    Color? indicatorBackgroundColor,
    TextStyle? messageTextStyle,
    double? messageSpacing,
  }) {
    return ProgressStyleOptions(
      padding: padding ?? this.padding,
      margin: margin ?? this.margin,
      decoration: decoration ?? this.decoration,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      borderRadius: borderRadius ?? this.borderRadius,
      constraints: constraints ?? this.constraints,
      safeArea: safeArea ?? this.safeArea,
      semanticsLabel: semanticsLabel ?? this.semanticsLabel,
      indicatorSize: indicatorSize ?? this.indicatorSize,
      indicatorConstraints: indicatorConstraints ?? this.indicatorConstraints,
      indicatorColor: indicatorColor ?? this.indicatorColor,
      indicatorBackgroundColor:
          indicatorBackgroundColor ?? this.indicatorBackgroundColor,
      messageTextStyle: messageTextStyle ?? this.messageTextStyle,
      messageSpacing: messageSpacing ?? this.messageSpacing,
    );
  }
}
