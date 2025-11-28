import 'package:flutter/material.dart';
import 'package:rxdart_flutter/rxdart_flutter.dart';

import '../model/toast_data_model.dart';
import '../model/toast_type.dart';
import '../statement.dart';
import '../toast_event.dart';
import 'default_progress_widget.dart';

OverlayEntry progressOverlayEntry({
  required OverlayPortalController controller,
  ToastProgressBuilder? builder,
  required Color overlayColor,
  required bool ignoring,
  required Size size,
}) {
  return OverlayEntry(
    builder: (BuildContext context) {
      return OverlayPortal(
        controller: controller,
        overlayLocation: OverlayChildLocation.rootOverlay,
        overlayChildBuilder: (context) {
          return ValueStreamBuilder(
            stream: ToastEvent.showMessages,
            builder: (BuildContext context, ToastDataModel value, Widget? child) {
              if (value.type == ToastType.progress) {
                return IgnorePointer(
                  ignoring: ignoring,
                  child: Container(
                    width: size.width,
                    height: size.height,
                    color: overlayColor,
                    child:
                        builder?.call(
                          context,
                          value.progress ?? 0,
                          value.message,
                          value.alignment,
                          value.extra,
                        ) ??
                        DefaultProgressWidget(
                          progress: value.progress,
                          message: value.message,
                          alignment: value.alignment,
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
