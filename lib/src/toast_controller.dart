import 'package:flutter/material.dart';

import 'model/message_type.dart';
import 'model/toast_data_model.dart';
import 'toast_event.dart';
import 'model/toast_type.dart';

sealed class FlutterToastPro {
  ///显示消息
  static void showMessage(
    String message, {
    Duration? closeDuration,
    MessageType type = MessageType.info,
    AlignmentGeometry alignment = Alignment.topCenter,
    Map<String, dynamic> extra = const <String, dynamic>{},
  }) {
    ToastEvent.showMessages.add(
      ToastDataModel(
        type: ToastType.message,
        message: message,
        messageType: type,
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
    AlignmentGeometry alignment = Alignment.topCenter,
    Map<String, dynamic> extra = const <String, dynamic>{},
  }) {
    ToastEvent.showMessages.add(
      ToastDataModel(
        type: ToastType.message,
        message: message,
        messageType: MessageType.success,
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
    AlignmentGeometry alignment = Alignment.topCenter,
    Map<String, dynamic> extra = const <String, dynamic>{},
  }) {
    ToastEvent.showMessages.add(
      ToastDataModel(
        type: ToastType.message,
        message: message,
        messageType: MessageType.warning,
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
    AlignmentGeometry alignment = Alignment.topCenter,
    Map<String, dynamic> extra = const <String, dynamic>{},
  }) {
    ToastEvent.showMessages.add(
      ToastDataModel(
        type: ToastType.message,
        message: message,
        messageType: MessageType.error,
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
    AlignmentGeometry alignment = Alignment.center,
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

  ///关闭进度
  static void hideProgress() {
    ToastEvent.hideMessages.add(ToastType.progress);
  }

  ///显示加载中
  static void showLoading({
    String? message,
    AlignmentGeometry alignment = Alignment.center,
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

  ///关闭加载中
  static void hideLoading() {
    ToastEvent.hideMessages.add(ToastType.loading);
  }
}
