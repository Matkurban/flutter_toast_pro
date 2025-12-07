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

  ///默认的 message 颜色
  static MessageStyleOptions defaultMessageStyleOptions() {
    return MessageStyleOptions(
      info: InfoMessageColorOption(
        primaryLight: ColorOption(
          backgroundColor: Colors.black.withValues(alpha: 0.3),
          foregroundColor: Colors.white,
        ),
        primary: ColorOption(backgroundColor: Colors.black, foregroundColor: Colors.white),
      ),
      success: SuccessMessageColorOption(
        primaryLight: ColorOption(
          backgroundColor: Color(0xFF67c23a).withValues(alpha: 0.3),
          foregroundColor: Color(0xFF67c23a),
        ),
        primary: ColorOption(backgroundColor: Color(0xFF67c23a), foregroundColor: Colors.white),
      ),
      warning: WarningMessageColorOption(
        primaryLight: ColorOption(
          backgroundColor: Color(0xFFe6a23d).withValues(alpha: 0.3),
          foregroundColor: Color(0xFFe6a23d),
        ),
        primary: ColorOption(backgroundColor: Color(0xFFe6a23d), foregroundColor: Colors.white),
      ),
      error: ErrorMessageColorOption(
        primaryLight: ColorOption(
          backgroundColor: Color(0xFFEF4444).withValues(alpha: 0.3),
          foregroundColor: Color(0xFFEF4444),
        ),
        primary: ColorOption(backgroundColor: Color(0xFFEF4444), foregroundColor: Colors.white),
      ),
      padding: EdgeInsetsGeometry.symmetric(horizontal: 16, vertical: 12),
      borderRadius: BorderRadiusGeometry.circular(10),
    );
  }
}
