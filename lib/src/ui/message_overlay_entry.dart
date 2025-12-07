import 'package:flutter/material.dart';
import 'package:rxdart_flutter/rxdart_flutter.dart';

import '../model/effect_type.dart';
import '../model/message_style_options.dart';
import '../model/toast_data_model.dart';
import '../statement.dart';
import '../toast_event.dart';
import 'default_message_widget.dart';

OverlayEntry messageOverlayEntry({
  required OverlayPortalController controller,
  ToastMessageBuilder? builder,
  required Color overlayColor,
  required bool ignoring,
  required Size size,
  required EffectType effectType,
  required Alignment defaultAlignment,
  required MessageStyleOptions styleOptions,
}) {
  return OverlayEntry(
    builder: (BuildContext context) {
      return OverlayPortal(
        controller: controller,
        overlayLocation: .rootOverlay,
        overlayChildBuilder: (context) {
          return ValueStreamBuilder(
            stream: ToastEvent.showMessages,
            builder: (BuildContext context, ToastDataModel value, Widget? child) {
              if (value.type == .message) {
                return IgnorePointer(
                  ignoring: ignoring,
                  child: Container(
                    width: size.width,
                    height: size.height,
                    color: overlayColor,
                    child: SafeArea(
                      child:
                          builder?.call(
                            context,
                            value.message ?? "",
                            value.messageType,
                            value.effectType ?? effectType,
                            value.alignment ?? defaultAlignment,
                            value.extra,
                          ) ??
                          DefaultMessageWidget(
                            message: value.message ?? "",
                            type: value.messageType,
                            effectType: value.effectType ?? effectType,
                            alignment: value.alignment ?? defaultAlignment,
                            styleOptions: styleOptions,
                          ),
                    ),
                  ),
                );
              } else {
                return SizedBox.shrink();
              }
            },
          );
        },
      );
    },
  );
}
