import 'dart:async';

import 'package:flutter/material.dart';

import 'statement.dart';
import 'toast_event.dart';
import 'model/toast_data_model.dart';
import 'model/toast_type.dart';
import 'ui/loading_overlay_entry.dart';
import 'ui/message_overlay_entry.dart';
import 'ui/progress_overlay_entry.dart';

class FlutterToastProWrapper extends StatefulWidget {
  const FlutterToastProWrapper({
    super.key,
    required this.child,
    this.messageBuilder,
    this.progressBuilder,
    this.loadingBuilder,
    this.textDirection,
    this.autoClose = true,
    this.closeDuration = const Duration(seconds: 2),
  });

  ///子组件
  final Widget child;

  final ToastMessageBuilder? messageBuilder;

  final ToastProgressBuilder? progressBuilder;

  final ToastLoadingBuilder? loadingBuilder;

  final TextDirection? textDirection;

  ///是否自动关闭
  ///仅用于[ToastType.message]消息
  final bool autoClose;

  ///自动关闭时间
  ///默认2秒后关闭
  final Duration closeDuration;

  @override
  State<FlutterToastProWrapper> createState() => _FlutterToastProWrapperState();
}

class _FlutterToastProWrapperState extends State<FlutterToastProWrapper> {
  late OverlayPortalController messageOverlayController;
  late OverlayPortalController progressOverlayController;
  late OverlayPortalController loadingOverlayController;

  Timer? closeTimer;

  @override
  void initState() {
    super.initState();
    messageOverlayController = OverlayPortalController(debugLabel: "flutter_toast_message");
    progressOverlayController = OverlayPortalController(debugLabel: "flutter_toast_progress");
    loadingOverlayController = OverlayPortalController(debugLabel: "flutter_toast_loading");
    ToastEvent.showMessages.listen(_showEventListen);
    ToastEvent.hideMessages.listen(_hideEventListen);
  }

  void _showEventListen(ToastDataModel data) {
    switch (data.type) {
      case ToastType.message:
        {
          if (data.message != null) {
            messageOverlayController.show();
            if (widget.autoClose) {
              if (closeTimer != null && closeTimer!.isActive) {
                closeTimer!.cancel();
                closeTimer = null;
                closeTimer = Timer((data.closeDuration ?? widget.closeDuration), () {
                  messageOverlayController.hide();
                  closeTimer = null;
                });
              } else {
                closeTimer = Timer((data.closeDuration ?? widget.closeDuration), () {
                  messageOverlayController.hide();
                  closeTimer = null;
                });
              }
            }
          }
        }
      case ToastType.loading:
        loadingOverlayController.show();
      case ToastType.progress:
        progressOverlayController.show();
    }
  }

  void _hideEventListen(ToastType type) {
    switch (type) {
      case ToastType.message:
        messageOverlayController.hide();
      case ToastType.loading:
        loadingOverlayController.hide();
      case ToastType.progress:
        progressOverlayController.hide();
    }
  }

  @override
  void dispose() {
    if (closeTimer != null) {
      closeTimer?.cancel();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: widget.textDirection ?? TextDirection.ltr,
      child: Overlay(
        initialEntries: [
          OverlayEntry(builder: (BuildContext context) => widget.child),
          messageOverlayEntry(controller: messageOverlayController, builder: widget.messageBuilder),
          loadingOverlayEntry(controller: loadingOverlayController, builder: widget.loadingBuilder),
          progressOverlayEntry(
            controller: progressOverlayController,
            builder: widget.progressBuilder,
          ),
        ],
      ),
    );
  }
}
