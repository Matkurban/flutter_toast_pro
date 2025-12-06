import 'package:flutter/material.dart';
import '../flutter_toast_pro.dart';
import 'model/toast_data_model.dart';
import 'toast_event.dart';
import 'model/toast_type.dart';

sealed class FlutterToastPro {
  ///显示消息
  static void showMessage(
    String message, {
    Duration? closeDuration,
    MessageType type = MessageType.info,
    EffectType? effectType,
    Alignment? alignment,
    Map<String, dynamic> extra = const <String, dynamic>{},
  }) {
    ToastEvent.showMessages.add(
      ToastDataModel(
        type: .message,
        message: message,
        messageType: type,
        effectType: effectType,
        closeDuration: closeDuration,
        alignment: alignment,
        extra: extra,
      ),
    );
  }

  ///显示成功消息
  static void showSuccessMessage(
    String message, {
    Duration? closeDuration,
    EffectType? effectType,
    Alignment? alignment,
    Map<String, dynamic> extra = const <String, dynamic>{},
  }) {
    ToastEvent.showMessages.add(
      ToastDataModel(
        type: .message,
        message: message,
        messageType: .success,
        effectType: effectType,
        closeDuration: closeDuration,
        alignment: alignment,
        extra: extra,
      ),
    );
  }

  ///显示警告消息
  static void showWaringMessage(
    String message, {
    Duration? closeDuration,
    EffectType? effectType,
    Alignment? alignment,
    Map<String, dynamic> extra = const <String, dynamic>{},
  }) {
    ToastEvent.showMessages.add(
      ToastDataModel(
        type: .message,
        message: message,
        messageType: .warning,
        effectType: effectType,
        closeDuration: closeDuration,
        alignment: alignment,
        extra: extra,
      ),
    );
  }

  ///显示成功消息
  static void showErrorMessage(
    String message, {
    Duration? closeDuration,
    EffectType? effectType,
    Alignment? alignment,
    Map<String, dynamic> extra = const <String, dynamic>{},
  }) {
    ToastEvent.showMessages.add(
      ToastDataModel(
        type: .message,
        message: message,
        messageType: .error,
        effectType: effectType,
        closeDuration: closeDuration,
        alignment: alignment,
        extra: extra,
      ),
    );
  }

  ///手动隐藏消息
  ///如果手动关闭消息时自动关闭时间还未结束也会立即关闭
  static void hideMessage() {
    ToastEvent.hideMessages.add(ToastType.message);
  }

  ///显示进度
  static void showProgress(
    double progress, {
    String? message,
    Alignment? alignment,
    Map<String, dynamic> extra = const <String, dynamic>{},
  }) {
    ToastEvent.showMessages.add(
      ToastDataModel(
        type: .progress,
        message: message,
        progress: progress,
        alignment: alignment,
        extra: extra,
      ),
    );
  }

  ///关闭进度
  static void hideProgress() {
    ToastEvent.hideMessages.add(ToastType.progress);
  }

  ///显示加载中
  static void showLoading({
    String? message,
    Alignment? alignment,
    Map<String, dynamic> extra = const <String, dynamic>{},
  }) {
    ToastEvent.showMessages.add(
      ToastDataModel(type: .loading, message: message, alignment: alignment, extra: extra),
    );
  }

  ///关闭加载中
  static void hideLoading() {
    ToastEvent.hideMessages.add(ToastType.loading);
  }
}
