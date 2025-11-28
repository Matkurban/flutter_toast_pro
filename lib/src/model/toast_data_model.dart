import 'package:flutter/material.dart';

import 'message_type.dart';
import 'toast_type.dart';

class ToastDataModel {
  ///消息的类型
  final ToastType type;

  ///消息
  final String? message;

  ///消息的类型
  final MessageType messageType;

  ///进度
  final double? progress;

  ///自动关闭时间
  final Duration? closeDuration;

  ///消息显示的位置
  final AlignmentGeometry alignment;

  ///扩展数据
  final Map<String, dynamic> extra;

  ToastDataModel({
    required this.type,
    this.message,
    this.messageType = MessageType.info,
    this.progress,
    this.closeDuration,
    this.alignment = Alignment.topCenter,
    this.extra = const <String, dynamic>{},
  });

  factory ToastDataModel.empty() {
    return ToastDataModel(type: ToastType.none);
  }
}
