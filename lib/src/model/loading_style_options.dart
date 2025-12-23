import 'package:flutter/material.dart';

/// UI style options for the default loading widget.
///
/// 默认 loading 组件的样式配置。
@immutable
class LoadingStyleOptions {
  /// Create loading style options.
  ///
  /// 创建 loading 样式配置。
  const LoadingStyleOptions({
    /// Inner padding of the content card.
    ///
    /// 内容卡片的内边距。
    this.padding = const EdgeInsets.all(10),

    /// Outer margin of the content card.
    ///
    /// 内容卡片的外边距。
    this.margin,

    /// Full decoration of the content card.
    ///
    /// 内容卡片的完整装饰（若设置，会优先于 [backgroundColor]/[borderRadius]）。
    this.decoration,

    /// Background color of the content card (used when [decoration] is null).
    ///
    /// 内容卡片背景颜色（当 [decoration] 为空时使用）。
    this.backgroundColor = const Color(0xFF000000),

    /// Border radius of the content card (used when [decoration] is null).
    ///
    /// 内容卡片圆角（当 [decoration] 为空时使用）。
    this.borderRadius = const BorderRadius.all(Radius.circular(10)),

    /// Optional constraints for the content card.
    ///
    /// 内容卡片的约束（可限制最大宽高等）。
    this.constraints,

    /// Convenience max width used when [constraints] is null.
    ///
    /// 当 [constraints] 为空时使用的便捷最大宽度。
    this.maxWidth = 560,

    /// Whether to wrap with SafeArea.
    ///
    /// 是否使用 SafeArea 包裹。
    this.safeArea = true,

    /// Optional semantics label for accessibility.
    ///
    /// 无障碍语义标签（Accessibility）。
    this.semanticsLabel,

    /// Loading indicator size.
    ///
    /// 加载指示器尺寸。
    this.indicatorSize = 48,

    /// Loading indicator type.
    ///
    /// 加载指示器类型。
    ///
    /// Note: This is kept as `dynamic` to avoid exposing 3rd party types.
    ///
    /// 注意：这里使用 `dynamic` 以避免对外暴露第三方类型。
    this.indicatorType,

    /// Loading indicator colors.
    ///
    /// 加载指示器颜色列表。
    this.indicatorColors,

    /// Text style for message.
    ///
    /// 文案文本样式。
    this.messageTextStyle,

    /// Spacing between indicator and message.
    ///
    /// 指示器与文案之间的间距。
    this.messageSpacing = 4,
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

  /// Convenience max width used when [constraints] is null.
  ///
  /// 当 [constraints] 为空时使用的便捷最大宽度。
  final double maxWidth;

  /// Whether to wrap with SafeArea.
  ///
  /// 是否使用 SafeArea 包裹。
  final bool safeArea;

  /// Optional semantics label for accessibility.
  ///
  /// 无障碍语义标签（Accessibility）。
  final String? semanticsLabel;

  /// Loading indicator size.
  ///
  /// 加载指示器尺寸。
  final double indicatorSize;

  /// Loading indicator type.
  ///
  /// 加载指示器类型。
  final dynamic indicatorType;

  /// Loading indicator colors.
  ///
  /// 加载指示器颜色列表。
  final List<Color>? indicatorColors;

  /// Text style for message.
  ///
  /// 文案文本样式。
  final TextStyle? messageTextStyle;

  /// Spacing between indicator and message.
  ///
  /// 指示器与文案之间的间距。
  final double messageSpacing;

  /// Returns a copy with the given fields replaced.
  ///
  /// 基于当前对象创建副本，并替换指定字段。
  LoadingStyleOptions copyWith({
    /// Inner padding of the content card.
    ///
    /// 内容卡片的内边距。
    EdgeInsetsGeometry? padding,

    /// Outer margin of the content card.
    ///
    /// 内容卡片的外边距。
    EdgeInsetsGeometry? margin,

    /// Full decoration of the content card.
    ///
    /// 内容卡片的完整装饰。
    Decoration? decoration,

    /// Background color of the content card.
    ///
    /// 内容卡片背景颜色。
    Color? backgroundColor,

    /// Border radius of the content card.
    ///
    /// 内容卡片圆角。
    BorderRadiusGeometry? borderRadius,

    /// Optional constraints for the content card.
    ///
    /// 内容卡片的约束。
    BoxConstraints? constraints,

    /// Convenience max width.
    ///
    /// 便捷最大宽度。
    double? maxWidth,

    /// Whether to wrap with SafeArea.
    ///
    /// 是否使用 SafeArea 包裹。
    bool? safeArea,

    /// Optional semantics label for accessibility.
    ///
    /// 无障碍语义标签（Accessibility）。
    String? semanticsLabel,

    /// Loading indicator size.
    ///
    /// 加载指示器尺寸。
    double? indicatorSize,

    /// Loading indicator type.
    ///
    /// 加载指示器类型。
    dynamic indicatorType,

    /// Loading indicator colors.
    ///
    /// 加载指示器颜色列表。
    List<Color>? indicatorColors,

    /// Text style for message.
    ///
    /// 文案文本样式。
    TextStyle? messageTextStyle,

    /// Spacing between indicator and message.
    ///
    /// 指示器与文案之间的间距。
    double? messageSpacing,
  }) {
    return LoadingStyleOptions(
      padding: padding ?? this.padding,
      margin: margin ?? this.margin,
      decoration: decoration ?? this.decoration,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      borderRadius: borderRadius ?? this.borderRadius,
      constraints: constraints ?? this.constraints,
      maxWidth: maxWidth ?? this.maxWidth,
      safeArea: safeArea ?? this.safeArea,
      semanticsLabel: semanticsLabel ?? this.semanticsLabel,
      indicatorSize: indicatorSize ?? this.indicatorSize,
      indicatorType: indicatorType ?? this.indicatorType,
      indicatorColors: indicatorColors ?? this.indicatorColors,
      messageTextStyle: messageTextStyle ?? this.messageTextStyle,
      messageSpacing: messageSpacing ?? this.messageSpacing,
    );
  }
}
