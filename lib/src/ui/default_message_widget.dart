import 'package:flutter/material.dart';

import '../model/effect_type.dart';
import '../model/message_style_options.dart';
import '../model/message_type.dart';

class DefaultMessageWidget extends StatelessWidget {
  const DefaultMessageWidget({
    super.key,
    required this.message,
    required this.type,
    required this.effectType,
    required this.alignment,
    required this.styleOptions,
  });

  final String message;

  final MessageType type;

  final EffectType effectType;

  final AlignmentGeometry alignment;

  final MessageStyleOptions styleOptions;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.sizeOf(context);
    Color bgColor;
    Color textColor;
    switch (type) {
      case MessageType.info:
        switch (effectType) {
          case EffectType.primaryLight:
            bgColor = styleOptions.info.primaryLight.backgroundColor;
            textColor = styleOptions.info.primaryLight.foregroundColor;
          case EffectType.primary:
            bgColor = styleOptions.info.primary.backgroundColor;
            textColor = styleOptions.info.primary.foregroundColor;
        }

      case MessageType.success:
        switch (effectType) {
          case EffectType.primaryLight:
            bgColor = styleOptions.success.primaryLight.backgroundColor;
            textColor = styleOptions.success.primaryLight.foregroundColor;
          case EffectType.primary:
            bgColor = styleOptions.success.primary.backgroundColor;
            textColor = styleOptions.success.primary.foregroundColor;
        }

      case MessageType.warning:
        switch (effectType) {
          case EffectType.primaryLight:
            bgColor = styleOptions.warning.primaryLight.backgroundColor;
            textColor = styleOptions.warning.primaryLight.foregroundColor;
          case EffectType.primary:
            bgColor = styleOptions.warning.primary.backgroundColor;
            textColor = styleOptions.warning.primary.foregroundColor;
        }

      case MessageType.error:
        switch (effectType) {
          case EffectType.primaryLight:
            bgColor = styleOptions.error.primaryLight.backgroundColor;
            textColor = styleOptions.error.primaryLight.foregroundColor;
          case EffectType.primary:
            bgColor = styleOptions.error.primary.backgroundColor;
            textColor = styleOptions.error.primary.foregroundColor;
        }
    }
    return Container(
      width: size.width,
      height: size.height,
      alignment: alignment,
      padding: styleOptions.margin,
      child: Container(
        padding: styleOptions.padding,
        decoration: BoxDecoration(color: bgColor, borderRadius: styleOptions.borderRadius),
        child: Text(
          message,
          style:
              styleOptions.textStyleBuilder
                  ?.call(type, effectType)
                  .merge(TextStyle(color: textColor)) ??
              TextStyle(color: textColor),
        ),
      ),
    );
  }
}
