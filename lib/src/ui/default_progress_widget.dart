import 'package:flutter/material.dart';

import '../model/progress_style_options.dart';

/// Default progress widget used when no custom [ToastProgressBuilder] is provided.
///
/// 当未提供自定义 [ToastProgressBuilder] 时使用的默认 progress 组件。
class DefaultProgressWidget extends StatelessWidget {
  /// Create a default progress widget.
  ///
  /// 创建默认 progress 组件。
  const DefaultProgressWidget({
    super.key,
    required this.progress,
    this.message,
    this.alignment,
    this.styleOptions = const ProgressStyleOptions(),
  });

  /// Progress value.
  ///
  /// 进度值。
  ///
  /// - null: indeterminate progress
  /// - 0..1: determinate progress
  ///
  /// - null：不确定进度
  /// - 0..1：确定进度
  final double? progress;

  /// Optional message shown below the indicator.
  ///
  /// 可选文案，显示在指示器下方。
  final String? message;

  /// Alignment of the progress widget within the overlay.
  ///
  /// progress 组件在覆盖层中的对齐位置。
  final AlignmentGeometry? alignment;

  /// Style options for the built-in progress UI.
  ///
  /// 内置 progress UI 的样式配置。
  final ProgressStyleOptions styleOptions;

  @override
  Widget build(BuildContext context) {
    // Full screen size used by the overlay.
    //
    // 覆盖层的全屏尺寸。
    final size = MediaQuery.sizeOf(context);

    // Build decoration.
    // If [styleOptions.decoration] is provided, it takes precedence.
    //
    // 构建装饰。
    // 如果配置了 [styleOptions.decoration]，则优先使用它。
    final Decoration decoration =
        styleOptions.decoration ??
        BoxDecoration(
          color: styleOptions.backgroundColor,
          borderRadius: styleOptions.borderRadius,
        );

    // Resolve indicator background color.
    //
    // 解析指示器背景颜色。
    final Color indicatorBg =
        styleOptions.indicatorBackgroundColor ??
        styleOptions.indicatorColor.withValues(alpha: 0.3);

    // Resolve indicator constraints.
    //
    // 解析指示器约束。
    final BoxConstraints indicatorConstraints =
        styleOptions.indicatorConstraints ??
        BoxConstraints(
          maxHeight: styleOptions.indicatorSize,
          maxWidth: styleOptions.indicatorSize,
        );

    // Constrain the content card (avoid being too wide on large screens).
    //
    // 约束内容卡片尺寸（避免大屏太宽）。
    final BoxConstraints constraints =
        styleOptions.constraints ??
        BoxConstraints(maxWidth: styleOptions.maxWidth);

    // Main content card.
    //
    // 内容卡片主体。
    Widget content = ConstrainedBox(
      constraints: constraints,
      child: Container(
        margin: styleOptions.margin,
        padding: styleOptions.padding,
        decoration: decoration,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: styleOptions.indicatorSize,
              height: styleOptions.indicatorSize,
              child: CircularProgressIndicator(
                value: progress,
                color: styleOptions.indicatorColor,
                backgroundColor: indicatorBg,
                constraints: indicatorConstraints,
              ),
            ),
            if (message != null) ...[
              SizedBox(height: styleOptions.messageSpacing),
              Text(message!, style: styleOptions.messageTextStyle),
            ],
          ],
        ),
      ),
    );

    // Accessibility semantics.
    //
    // 无障碍语义。
    if (styleOptions.semanticsLabel != null) {
      content = Semantics(label: styleOptions.semanticsLabel, child: content);
    }

    // Full-screen container to place the content.
    //
    // 全屏容器，用于定位内容卡片。
    Widget body = Container(
      width: size.width,
      height: size.height,
      alignment: alignment,
      child: content,
    );

    // Optional SafeArea wrapper.
    //
    // 可选 SafeArea 包裹。
    if (styleOptions.safeArea) {
      body = SafeArea(child: body);
    }

    return body;
  }
}
