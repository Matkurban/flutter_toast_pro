import 'package:flutter/material.dart';
import 'package:rxdart_flutter/rxdart_flutter.dart';

import '../model/toast_data_model.dart';
import '../model/toast_type.dart';
import '../toast_event.dart';
import '../statement.dart';
import 'default_progress_widget.dart';

OverlayEntry progressOverlayEntry({
  required OverlayPortalController controller,
  ToastProgressBuilder? builder,
}) {
  return OverlayEntry(
    builder: (BuildContext context) {
      return OverlayPortal(
        controller: controller,
        overlayLocation: OverlayChildLocation.rootOverlay,
        overlayChildBuilder: (context) {
          return IgnorePointer(
            child: ValueStreamBuilder(
              stream: ToastEvent.showMessages,
              builder: (BuildContext context, ToastDataModel value, Widget? child) {
                if (value.type == ToastType.progress) {
                  return SafeArea(
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
                  );
                } else {
                  return SizedBox.shrink();
                }
              },
            ),
          );
        },
      );
    },
  );
}
