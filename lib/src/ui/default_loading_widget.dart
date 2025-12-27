import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';

import '../model/loading_style_options.dart';

/// Default loading widget used when no custom [ToastLoadingBuilder] is provided.
///
/// 当未提供自定义 [ToastLoadingBuilder] 时使用的默认 loading 组件。
class DefaultLoadingWidget extends StatelessWidget {
  /// Create a default loading widget.
  ///
  /// 创建默认 loading 组件。
  const DefaultLoadingWidget({
    super.key,
    this.message,
    this.position,
    this.styleOptions = const LoadingStyleOptions(),
  });

  /// Optional message shown below the indicator.
  ///
  /// 可选文案，显示在指示器下方。
  final String? message;

  /// Alignment of the loading widget within the overlay.
  ///
  /// loading 组件在覆盖层中的对齐位置。
  final Alignment? position;

  /// Style options for the built-in loading UI.
  ///
  /// 内置 loading UI 的样式配置。
  final LoadingStyleOptions styleOptions;

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

    // Resolve indicator colors.
    //
    // 解析指示器颜色列表。
    final List<Color> colors =
        styleOptions.indicatorColors ??
        const [
          Colors.blue,
          Colors.purple,
          Colors.red,
          Colors.orange,
          Colors.green,
        ];

    // Main content card.
    //
    // 内容卡片主体。
    Widget content = Container(
      margin: styleOptions.margin,
      padding: styleOptions.padding,
      decoration: decoration,
      alignment: styleOptions.alignment,
      constraints: styleOptions.constraints,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: styleOptions.indicatorSize,
            height: styleOptions.indicatorSize,
            child: LoadingIndicator(
              indicatorType:
                  styleOptions.indicatorType ?? Indicator.ballSpinFadeLoader,
              colors: colors,
            ),
          ),
          if (message != null) ...[
            SizedBox(height: styleOptions.messageSpacing),
            Text(message!, style: styleOptions.messageTextStyle),
          ],
        ],
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
      alignment: position,
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
