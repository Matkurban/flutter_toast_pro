import 'package:flutter/material.dart';
import 'package:rxdart_flutter/rxdart_flutter.dart';

import '../model/toast_data_model.dart';
import '../model/toast_type.dart';
import '../statement.dart';
import '../toast_event.dart';
import 'default_loading_widget.dart';

OverlayEntry loadingOverlayEntry({
  required OverlayPortalController controller,
  ToastLoadingBuilder? builder,
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
            builder:
                (BuildContext context, ToastDataModel value, Widget? child) {
                  if (value.type == ToastType.loading) {
                    return IgnorePointer(
                      ignoring: ignoring,
                      child: Container(
                        color: overlayColor,
                        width: size.width,
                        height: size.height,
                        child:
                            builder?.call(
                              context,
                              value.message,
                              value.alignment,
                              value.extra,
                            ) ??
                            DefaultLoadingWidget(
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
