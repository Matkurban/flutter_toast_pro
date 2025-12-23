import 'dart:async';

import 'package:flutter/material.dart';

import 'defaults.dart';
import 'model/toast_data_model.dart';
import 'model/toast_type.dart';
import 'model/toast_ui_options.dart';
import 'statement.dart';
import 'toast_event.dart';
import 'ui/loading_overlay_entry.dart';
import 'ui/message_overlay_entry.dart';
import 'ui/progress_overlay_entry.dart';

/// Root wrapper that installs toast overlays above your app.
///
/// 用于在应用最上层安装 toast 覆盖层的根组件。
class FlutterToastProWrapper extends StatefulWidget {
  /// Create the toast wrapper.
  ///
  /// 创建 toast 包装组件。
  const FlutterToastProWrapper({
    super.key,
    required this.child,
    this.uiOptions = const ToastUiOptions(),
    this.messageBuilder,
    this.progressBuilder,
    this.loadingBuilder,
  });

  /// Standard UI options.
  ///
  /// 标准 UI 配置（包含 message/loading/progress 各自的 overlay+style 设置）。
  final ToastUiOptions uiOptions;

  /// Your app widget.
  ///
  /// 应用的子组件（通常是 MaterialApp/CupertinoApp）。
  final Widget child;

  /// Custom message builder.
  ///
  /// 自定义 message toast 构建器。
  final ToastMessageBuilder? messageBuilder;

  /// Custom progress builder.
  ///
  /// 自定义 progress toast 构建器。
  final ToastProgressBuilder? progressBuilder;

  /// Custom loading builder.
  ///
  /// 自定义 loading toast 构建器。
  final ToastLoadingBuilder? loadingBuilder;

  @override
  State<FlutterToastProWrapper> createState() => _FlutterToastProWrapperState();
}

class _FlutterToastProWrapperState extends State<FlutterToastProWrapper> {
  /// Overlay controller for message toasts.
  ///
  /// message toast 的 Overlay 控制器。
  late final OverlayPortalController messageOverlayController;

  /// Overlay controller for progress toasts.
  ///
  /// progress toast 的 Overlay 控制器。
  late final OverlayPortalController progressOverlayController;

  /// Overlay controller for loading toasts.
  ///
  /// loading toast 的 Overlay 控制器。
  late final OverlayPortalController loadingOverlayController;

  /// Subscription for show events.
  ///
  /// show 事件订阅。
  StreamSubscription<ToastDataModel>? _showSub;

  /// Subscription for hide events.
  ///
  /// hide 事件订阅。
  StreamSubscription<ToastType>? _hideSub;

  /// Timer used to auto-close message toasts.
  ///
  /// 用于 message toast 自动关闭的计时器。
  Timer? closeTimer;

  @override
  void initState() {
    super.initState();

    // Init overlay controllers.
    //
    // 初始化 overlay 控制器。
    messageOverlayController = OverlayPortalController(
      debugLabel: "flutter_toast_message",
    );
    progressOverlayController = OverlayPortalController(
      debugLabel: "flutter_toast_progress",
    );
    loadingOverlayController = OverlayPortalController(
      debugLabel: "flutter_toast_loading",
    );

    // Listen to events.
    //
    // 监听事件。
    _showSub = ToastEvent.showMessages.listen(_showEventListen);
    _hideSub = ToastEvent.hideMessages.listen(_hideEventListen);
  }

  /// Schedule message auto-close.
  ///
  /// 安排 message 自动关闭。
  void _scheduleMessageClose(Duration duration) {
    closeTimer?.cancel();
    closeTimer = Timer(duration, () {
      ToastEvent.showMessages.add(ToastDataModel.empty());
      messageOverlayController.hide();
      closeTimer = null;
    });
  }

  /// Current UI options.
  ///
  /// 当前 UI 配置。
  ToastUiOptions get _ui => widget.uiOptions;

  /// Handle show events.
  ///
  /// 处理 show 事件。
  void _showEventListen(ToastDataModel data) {
    switch (data.type) {
      case ToastType.message:
        if (data.message != null) {
          messageOverlayController.show();
          if (_ui.message.autoClose) {
            _scheduleMessageClose(
              data.closeDuration ?? _ui.message.closeDuration,
            );
          }
        }
        break;
      case ToastType.loading:
        closeTimer?.cancel();
        closeTimer = null;
        loadingOverlayController.show();
        break;
      case ToastType.progress:
        closeTimer?.cancel();
        closeTimer = null;
        progressOverlayController.show();
        break;
      case ToastType.none:
        closeTimer?.cancel();
        closeTimer = null;
        break;
    }
  }

  /// Handle hide events.
  ///
  /// 处理 hide 事件。
  void _hideEventListen(ToastType type) {
    switch (type) {
      case ToastType.message:
        closeTimer?.cancel();
        closeTimer = null;
        messageOverlayController.hide();
        break;
      case ToastType.loading:
        ToastEvent.showMessages.add(ToastDataModel.empty());
        loadingOverlayController.hide();
        break;
      case ToastType.progress:
        ToastEvent.showMessages.add(ToastDataModel.empty());
        progressOverlayController.hide();
        break;
      case ToastType.none:
        break;
    }
  }

  @override
  void dispose() {
    closeTimer?.cancel();
    _showSub?.cancel();
    _hideSub?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ui = _ui;

    // Resolve default message style.
    //
    // 解析 message 默认样式。
    final messageStyle =
        ui.message.style ?? FlutterToastProDefaults.messageStyle();

    return Directionality(
      textDirection: ui.textDirection,
      child: Overlay(
        initialEntries: [
          OverlayEntry(builder: (BuildContext context) => widget.child),
          messageOverlayEntry(
            controller: messageOverlayController,
            builder: widget.messageBuilder,
            overlay: ui.message.overlay,
            effectType: ui.message.effectType,
            styleOptions: messageStyle,
          ),
          loadingOverlayEntry(
            controller: loadingOverlayController,
            builder: widget.loadingBuilder,
            overlay: ui.loading.overlay,
            styleOptions: ui.loading.style,
          ),
          progressOverlayEntry(
            controller: progressOverlayController,
            builder: widget.progressBuilder,
            overlay: ui.progress.overlay,
            styleOptions: ui.progress.style,
          ),
        ],
      ),
    );
  }
}
