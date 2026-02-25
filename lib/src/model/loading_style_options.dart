import 'package:flutter/material.dart';

/// UI style options for the default loading widget.
///
/// 默认 loading 组件的样式配置。
@immutable
class LoadingStyleOptions {
  const LoadingStyleOptions({
    this.padding = const EdgeInsets.all(10),
    this.margin,
    this.decoration,
    this.backgroundColor = const Color(0xFF000000),
    this.borderRadius = const BorderRadius.all(Radius.circular(10)),
    this.constraints,
    this.safeArea = true,
    this.indicatorSize = 16,
    this.indicatorColor,
    this.messageTextStyle,
    this.messageSpacing = 4,
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

  /// Background color of the content card (used when [decoration] is null).
  ///
  /// 内容卡片背景颜色（当 [decoration] 为空时使用）。
  final Color backgroundColor;

  /// Border radius of the content card (used when [decoration] is null).
  ///
  /// 内容卡片圆角（当 [decoration] 为空时使用）。
  final BorderRadiusGeometry borderRadius;

  /// Optional constraints for the content card.
  ///
  /// 内容卡片的约束（可限制最大宽高等）。
  final BoxConstraints? constraints;

  /// Whether to wrap with SafeArea.
  ///
  /// 是否使用 SafeArea 包裹。
  final bool safeArea;

  /// Loading indicator size.
  ///
  /// 加载指示器尺寸。
  final double indicatorSize;

  final Color? indicatorColor;

  /// Text style for message.
  ///
  /// 文案文本样式。
  final TextStyle? messageTextStyle;

  /// Spacing between indicator and message.
  ///
  /// 指示器与文案之间的间距。
  final double messageSpacing;

  /// The alignment of the loading component within the container.
  ///
  /// loading 组件在容器中中的对齐位置。
  final Alignment alignment;

  LoadingStyleOptions copyWith({
    EdgeInsetsGeometry? padding,
    EdgeInsetsGeometry? margin,
    Decoration? decoration,
    Color? backgroundColor,
    BorderRadiusGeometry? borderRadius,
    BoxConstraints? constraints,
    double? maxWidth,
    bool? safeArea,
    double? indicatorSize,
    Color? indicatorColor,
    TextStyle? messageTextStyle,
    double? messageSpacing,
    Alignment? alignment,
  }) {
    return LoadingStyleOptions(
      padding: padding ?? this.padding,
      margin: margin ?? this.margin,
      decoration: decoration ?? this.decoration,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      borderRadius: borderRadius ?? this.borderRadius,
      constraints: constraints ?? this.constraints,
      safeArea: safeArea ?? this.safeArea,
      indicatorSize: indicatorSize ?? this.indicatorSize,
      indicatorColor: indicatorColor ?? this.indicatorColor,
      messageTextStyle: messageTextStyle ?? this.messageTextStyle,
      messageSpacing: messageSpacing ?? this.messageSpacing,
      alignment: alignment ?? this.alignment,
    );
  }
}
