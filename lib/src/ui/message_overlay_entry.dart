import 'package:flutter/material.dart';
import 'package:rxdart_flutter/rxdart_flutter.dart';

import '../model/toast_data_model.dart';
import '../model/toast_type.dart';
import '../statement.dart';
import '../toast_event.dart';
import 'default_message_widget.dart';

OverlayEntry messageOverlayEntry({
  required OverlayPortalController controller,
  ToastMessageBuilder? builder,
  required Color overlayColor,
  required bool ignoring,
  required Size size,
}) {
  return OverlayEntry(
    builder: (BuildContext context) {
      return OverlayPortal(
        controller: controller,
        overlayLocation: OverlayChildLocation.nearestOverlay,
        overlayChildBuilder: (context) {
          return ValueStreamBuilder(
            stream: ToastEvent.showMessages,
            builder: (BuildContext context, ToastDataModel value, Widget? child) {
              if (value.type == ToastType.message) {
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
                            value.alignment,
                            value.extra,
                          ) ??
                          DefaultMessageWidget(
                            message: value.message ?? "",
                            type: value.messageType,
                            alignment: value.alignment,
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
