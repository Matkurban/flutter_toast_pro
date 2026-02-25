import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
    this.alignment,
    this.styleOptions = const LoadingStyleOptions(),
  });

  /// Optional message shown below the indicator.
  ///
  /// 可选文案，显示在指示器下方。
  final String? message;

  /// Alignment of the loading widget within the overlay.
  ///
  /// loading 组件在覆盖层中的对齐位置。
  final Alignment? alignment;

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

    // Main content card.
    //
    // 内容卡片主体。
    Widget content = Container(
      margin: styleOptions.margin,
      padding: styleOptions.padding,
      decoration: decoration,
      constraints: styleOptions.constraints,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CupertinoActivityIndicator(
            radius: styleOptions.indicatorSize,
            color: styleOptions.indicatorColor,
          ),
          if (message != null) ...[
            SizedBox(height: styleOptions.messageSpacing),
            Text(
              message!,
              style:
                  styleOptions.messageTextStyle ??
                  TextStyle(color: Colors.white, fontSize: 12),
            ),
          ],
        ],
      ),
    );

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
