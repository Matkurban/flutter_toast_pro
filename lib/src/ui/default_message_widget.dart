import 'package:flutter/material.dart';

import '../model/effect_type.dart';
import '../model/message_style_options.dart';
import '../model/message_type.dart';

/// Default message widget used when no custom [ToastMessageBuilder] is provided.
///
/// 当未提供自定义 [ToastMessageBuilder] 时使用的默认 message 组件。
class DefaultMessageWidget extends StatelessWidget {
  /// Create a default message widget.
  ///
  /// 创建默认 message 组件。
  const DefaultMessageWidget({
    super.key,
    required this.message,
    required this.type,
    required this.effectType,
    required this.alignment,
    required this.styleOptions,
  });

  /// Message text.
  ///
  /// 消息文本内容。
  final String message;

  /// Message type (info/success/warning/error).
  ///
  /// 消息类型（info/success/warning/error）。
  final MessageType type;

  /// Effect type (primary/primaryLight).
  ///
  /// 效果类型（primary/primaryLight）。
  final EffectType effectType;

  /// Alignment of the message within the overlay.
  ///
  /// message 在覆盖层中的对齐位置。
  final AlignmentGeometry alignment;

  /// Style options for message widget.
  ///
  /// message 组件样式配置。
  final MessageStyleOptions styleOptions;

  /// Resolve the color tone based on [type] and [effectType].
  ///
  /// 根据 [type] 与 [effectType] 计算最终使用的颜色配置。
  ColorOption _toneFor(MessageType type, EffectType effectType) {
    switch (type) {
      case MessageType.info:
        return effectType == EffectType.primaryLight
            ? styleOptions.info.primaryLight
            : styleOptions.info.primary;
      case MessageType.success:
        return effectType == EffectType.primaryLight
            ? styleOptions.success.primaryLight
            : styleOptions.success.primary;
      case MessageType.warning:
        return effectType == EffectType.primaryLight
            ? styleOptions.warning.primaryLight
            : styleOptions.warning.primary;
      case MessageType.error:
        return effectType == EffectType.primaryLight
            ? styleOptions.error.primaryLight
            : styleOptions.error.primary;
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    final ColorOption tone = _toneFor(type, effectType);

    // Base text style without enforced color.
    //
    // 基础文本样式（不强制颜色）。
    final TextStyle baseStyle =
        styleOptions.textStyleBuilder?.call(type, effectType) ??
        const TextStyle();

    return Container(
      width: size.width,
      height: size.height,
      alignment: alignment,
      child: Container(
        margin: styleOptions.margin,
        padding: styleOptions.padding,
        decoration: BoxDecoration(
          color: tone.backgroundColor,
          borderRadius: styleOptions.borderRadius,
        ),
        child: Text(
          message,
          // Merge in resolved foreground color.
          //
          // merge 最终前景色。
          style: baseStyle.merge(TextStyle(color: tone.foregroundColor)),
          // Allow wrapping by default (messages can be long).
          //
          // 默认允许换行（message 可能较长）。
          softWrap: true,
        ),
      ),
    );
  }
}
