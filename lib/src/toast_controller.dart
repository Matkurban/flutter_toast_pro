import 'package:flutter/material.dart';

import '../flutter_toast_pro.dart';
import 'model/toast_data_model.dart';
import 'model/toast_type.dart';
import 'toast_event.dart';

/// Public controller API for FlutterToastPro.
///
/// FlutterToastPro 的对外控制器 API。
sealed class FlutterToastPro {
  /// Show a message toast.
  ///
  /// 显示 message toast。
  static void showMessage(
    String message, {

    /// Override auto close duration for this message.
    ///
    /// 覆盖本次 message 的自动关闭时长。
    Duration? closeDuration,

    /// Message type.
    ///
    /// 消息类型。
    MessageType type = MessageType.info,

    /// Effect type override for this message.
    ///
    /// 覆盖本次 message 的效果类型。
    EffectType? effectType,

    /// Alignment override for this toast.
    ///
    /// 覆盖本次 toast 的对齐方式。
    Alignment? alignment,

    /// Extra data passed to custom builders.
    ///
    /// 传递给自定义 builder 的扩展数据。
    Map<String, dynamic> extra = const <String, dynamic>{},
  }) {
    ToastEvent.showMessages.add(
      ToastDataModel(
        type: ToastType.message,
        message: message,
        messageType: type,
        effectType: effectType,
        closeDuration: closeDuration,
        alignment: alignment,
        extra: extra,
      ),
    );
  }

  /// Show a success message toast.
  ///
  /// 显示 success message toast。
  static void showSuccessMessage(
    String message, {

    /// Override auto close duration for this message.
    ///
    /// 覆盖本次 message 的自动关闭时长。
    Duration? closeDuration,

    /// Effect type override for this message.
    ///
    /// 覆盖本次 message 的效果类型。
    EffectType? effectType,

    /// Alignment override for this toast.
    ///
    /// 覆盖本次 toast 的对齐方式。
    Alignment? alignment,

    /// Extra data passed to custom builders.
    ///
    /// 传递给自定义 builder 的扩展数据。
    Map<String, dynamic> extra = const <String, dynamic>{},
  }) {
    ToastEvent.showMessages.add(
      ToastDataModel(
        type: ToastType.message,
        message: message,
        messageType: MessageType.success,
        effectType: effectType,
        closeDuration: closeDuration,
        alignment: alignment,
        extra: extra,
      ),
    );
  }

  /// Show a warning message toast.
  ///
  /// 显示 warning message toast。
  ///
  /// Note: API name kept as `showWaringMessage` for backward compatibility.
  ///
  /// 注意：为兼容历史 API，这里保留 `showWaringMessage` 的命名。
  static void showWaringMessage(
    String message, {

    /// Override auto close duration for this message.
    ///
    /// 覆盖本次 message 的自动关闭时长。
    Duration? closeDuration,

    /// Effect type override for this message.
    ///
    /// 覆盖本次 message 的效果类型。
    EffectType? effectType,

    /// Alignment override for this toast.
    ///
    /// 覆盖本次 toast 的对齐方式。
    Alignment? alignment,

    /// Extra data passed to custom builders.
    ///
    /// 传递给自定义 builder 的扩展数据。
    Map<String, dynamic> extra = const <String, dynamic>{},
  }) {
    ToastEvent.showMessages.add(
      ToastDataModel(
        type: ToastType.message,
        message: message,
        messageType: MessageType.warning,
        effectType: effectType,
        closeDuration: closeDuration,
        alignment: alignment,
        extra: extra,
      ),
    );
  }

  /// Show an error message toast.
  ///
  /// 显示 error message toast。
  static void showErrorMessage(
    String message, {

    /// Override auto close duration for this message.
    ///
    /// 覆盖本次 message 的自动关闭时长。
    Duration? closeDuration,

    /// Effect type override for this message.
    ///
    /// 覆盖本次 message 的效果类型。
    EffectType? effectType,

    /// Alignment override for this toast.
    ///
    /// 覆盖本次 toast 的对齐方式。
    Alignment? alignment,

    /// Extra data passed to custom builders.
    ///
    /// 传递给自定义 builder 的扩展数据。
    Map<String, dynamic> extra = const <String, dynamic>{},
  }) {
    ToastEvent.showMessages.add(
      ToastDataModel(
        type: ToastType.message,
        message: message,
        messageType: MessageType.error,
        effectType: effectType,
        closeDuration: closeDuration,
        alignment: alignment,
        extra: extra,
      ),
    );
  }

  /// Manually hide message toast.
  ///
  /// 手动隐藏 message toast。
  ///
  /// If auto-close timer is still running, the toast will be closed immediately.
  ///
  /// 如果自动关闭计时器仍在运行，toast 也会立即关闭。
  static void hideMessage() {
    ToastEvent.hideMessages.add(ToastType.message);
  }

  /// Show progress toast.
  ///
  /// 显示 progress toast。
  static void showProgress(
    double progress, {

    /// Optional message.
    ///
    /// 可选文案。
    String? message,

    /// Alignment override for this toast.
    ///
    /// 覆盖本次 toast 的对齐方式。
    Alignment? alignment,

    /// Extra data passed to custom builders.
    ///
    /// 传递给自定义 builder 的扩展数据。
    Map<String, dynamic> extra = const <String, dynamic>{},
  }) {
    ToastEvent.showMessages.add(
      ToastDataModel(
        type: ToastType.progress,
        message: message,
        progress: progress,
        alignment: alignment,
        extra: extra,
      ),
    );
  }

  /// Hide progress toast.
  ///
  /// 隐藏 progress toast。
  static void hideProgress() {
    ToastEvent.hideMessages.add(ToastType.progress);
  }

  /// Show loading toast.
  ///
  /// 显示 loading toast。
  static void showLoading({
    /// Optional message.
    ///
    /// 可选文案。
    String? message,

    /// Alignment override for this toast.
    ///
    /// 覆盖本次 toast 的对齐方式。
    Alignment? alignment,

    /// Extra data passed to custom builders.
    ///
    /// 传递给自定义 builder 的扩展数据。
    Map<String, dynamic> extra = const <String, dynamic>{},
  }) {
    ToastEvent.showMessages.add(
      ToastDataModel(
        type: ToastType.loading,
        message: message,
        alignment: alignment,
        extra: extra,
      ),
    );
  }

  /// Hide loading toast.
  ///
  /// 隐藏 loading toast。
  static void hideLoading() {
    ToastEvent.hideMessages.add(ToastType.loading);
  }
}
