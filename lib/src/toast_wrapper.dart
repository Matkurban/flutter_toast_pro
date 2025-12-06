import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_toast_pro/src/model/effect_type.dart';

import 'model/toast_data_model.dart';
import 'model/toast_type.dart';
import 'statement.dart';
import 'toast_event.dart';
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
    this.textDirection = TextDirection.ltr,
    this.autoClose = true,
    this.closeDuration = const Duration(seconds: 2),
    this.messageOverlayColor = Colors.transparent,
    this.loadingOverlayColor = Colors.transparent,
    this.progressOverlayColor = Colors.transparent,
    this.messageIgnoring = true,
    this.loadingIgnoring = false,
    this.progressIgnoring = false,
    this.effectType = EffectType.primaryLight,
    this.defaultMessageAlignment = Alignment.topCenter,
    this.defaultProgressAlignment = Alignment.center,
    this.defaultLoadingAlignment = Alignment.center,
  });

  ///子组件
  final Widget child;

  ///消息自定义
  final ToastMessageBuilder? messageBuilder;

  ///进度自定义
  final ToastProgressBuilder? progressBuilder;

  ///加载中自定义
  final ToastLoadingBuilder? loadingBuilder;

  ///文本方向
  final TextDirection textDirection;

  ///是否自动关闭
  ///仅用于[ToastType.message]消息
  final bool autoClose;

  ///自动关闭时间
  ///默认2秒后关闭
  final Duration closeDuration;

  ///消息覆盖层颜色
  final Color messageOverlayColor;

  ///加载中覆盖层颜色
  final Color loadingOverlayColor;

  ///进度覆盖层颜色
  final Color progressOverlayColor;

  ///消息覆盖层是否吸收事件
  ///默认false吸收事件即覆盖层下的组件可以接受事件
  final bool messageIgnoring;

  ///加载中覆盖层是否吸收事件
  ///默认true吸收事件即覆盖层下的组件无法接受事件
  final bool loadingIgnoring;

  ///进度覆盖层是否吸收事件
  ///默认true吸收事件即覆盖层下的组件无法接受事件
  final bool progressIgnoring;

  ///背景颜色深度类型
  ///[EffectType.primaryLight]浅色
  ///[EffectType.primary]深色
  final EffectType effectType;

  ///消息默认的位置
  final Alignment defaultMessageAlignment;

  /// 进度默认的位置
  final Alignment defaultProgressAlignment;

  /// 加载中默认的位置
  final Alignment defaultLoadingAlignment;

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
                  ToastEvent.showMessages.add(ToastDataModel.empty());
                  messageOverlayController.hide();
                  closeTimer = null;
                });
              } else {
                closeTimer = Timer((data.closeDuration ?? widget.closeDuration), () {
                  ToastEvent.showMessages.add(ToastDataModel.empty());
                  messageOverlayController.hide();
                  closeTimer = null;
                });
              }
            }
          }
        }
      case ToastType.loading:
        {
          if (closeTimer != null && closeTimer!.isActive) {
            closeTimer!.cancel();
            closeTimer = null;
          }
          loadingOverlayController.show();
        }

      case ToastType.progress:
        {
          if (closeTimer != null && closeTimer!.isActive) {
            closeTimer!.cancel();
            closeTimer = null;
          }
          progressOverlayController.show();
        }

      case ToastType.none:
        {
          if (closeTimer != null && closeTimer!.isActive) {
            closeTimer!.cancel();
            closeTimer = null;
          }
        }
        break;
    }
  }

  void _hideEventListen(ToastType type) {
    switch (type) {
      case ToastType.message:
        messageOverlayController.hide();
      case ToastType.loading:
        ToastEvent.showMessages.add(ToastDataModel.empty());
        loadingOverlayController.hide();
      case ToastType.progress:
        ToastEvent.showMessages.add(ToastDataModel.empty());
        progressOverlayController.hide();
      case ToastType.none:
        break;
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
    final Size size = MediaQuery.sizeOf(context);
    return Directionality(
      textDirection: widget.textDirection,
      child: Overlay(
        initialEntries: [
          OverlayEntry(builder: (BuildContext context) => widget.child),
          messageOverlayEntry(
            controller: messageOverlayController,
            builder: widget.messageBuilder,
            overlayColor: widget.messageOverlayColor,
            ignoring: widget.messageIgnoring,
            size: size,
            effectType: widget.effectType,
            defaultAlignment: widget.defaultMessageAlignment,
          ),
          loadingOverlayEntry(
            controller: loadingOverlayController,
            builder: widget.loadingBuilder,
            overlayColor: widget.loadingOverlayColor,
            ignoring: widget.loadingIgnoring,
            size: size,
            defaultAlignment: widget.defaultLoadingAlignment,
          ),
          progressOverlayEntry(
            controller: progressOverlayController,
            builder: widget.progressBuilder,
            overlayColor: widget.progressOverlayColor,
            ignoring: widget.progressIgnoring,
            size: size,
            defaultAlignment: widget.defaultProgressAlignment,
          ),
        ],
      ),
    );
  }
}
