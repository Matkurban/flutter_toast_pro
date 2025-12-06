import 'package:flutter/material.dart';
import 'package:flutter_toast_pro/src/model/effect_type.dart';

import '../model/message_type.dart';

class DefaultMessageWidget extends StatelessWidget {
  const DefaultMessageWidget({
    super.key,
    required this.message,
    required this.type,
    required this.effectType,
    required this.alignment,
  });

  final String message;

  final MessageType type;

  final EffectType effectType;

  final AlignmentGeometry alignment;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.sizeOf(context);
    Color bgColor;
    Color textColor;
    switch (type) {
      case MessageType.info:
        switch (effectType) {
          case EffectType.primaryLight:
            bgColor = Colors.black.withValues(alpha: 0.3);
          case EffectType.primary:
            bgColor = Colors.black;
        }
        textColor = Colors.white;

      case MessageType.success:
        switch (effectType) {
          case EffectType.primaryLight:
            bgColor = Color(0xFF67c23a).withValues(alpha: 0.3);
            textColor = Color(0xFF67c23a);
          case EffectType.primary:
            bgColor = Color(0xFF67c23a);
            textColor = Colors.white;
        }

      case MessageType.warning:
        switch (effectType) {
          case EffectType.primaryLight:
            bgColor = Color(0xFFe6a23d).withValues(alpha: 0.3);
            textColor = Color(0xFFe6a23d);
          case EffectType.primary:
            bgColor = Color(0xFFe6a23d);
            textColor = Colors.white;
        }

      case MessageType.error:
        switch (effectType) {
          case EffectType.primaryLight:
            bgColor = Color(0xFFf56c6c).withValues(alpha: 0.3);
            textColor = Color(0xFFf56c6c);
          case EffectType.primary:
            bgColor = Color(0xFFf56c6c);
            textColor = Colors.white;
        }
    }
    return Container(
      width: size.width,
      height: size.height,
      alignment: alignment,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(color: bgColor, borderRadius: BorderRadiusGeometry.circular(10)),
        child: Text(message, style: TextStyle(color: textColor)),
      ),
    );
  }
}
