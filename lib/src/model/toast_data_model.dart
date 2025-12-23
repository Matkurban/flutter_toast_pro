import 'package:flutter/material.dart';
import 'package:flutter_toast_pro/src/model/effect_type.dart';

import 'message_type.dart';
import 'toast_type.dart';

/// Toast data model emitted through the event bus.
///
/// 通过事件总线传递的 toast 数据模型。
class ToastDataModel {
  /// Toast type.
  ///
  /// toast 类型。
  final ToastType type;

  /// Message text.
  ///
  /// 消息文本。
  final String? message;

  /// Message type (only meaningful when [type] is [ToastType.message]).
  ///
  /// 消息类型（仅当 [type] 为 [ToastType.message] 时有意义）。
  final MessageType messageType;

  /// Effect type override.
  ///
  /// 效果类型覆盖值。
  final EffectType? effectType;

  /// Progress value (only meaningful when [type] is [ToastType.progress]).
  ///
  /// 进度值（仅当 [type] 为 [ToastType.progress] 时有意义）。
  final double? progress;

  /// Auto close duration for message toasts.
  ///
  /// message toast 的自动关闭时长。
  final Duration? closeDuration;

  /// Alignment override for this toast.
  ///
  /// 本次 toast 的对齐方式（覆盖默认对齐）。
  final Alignment? alignment;

  /// Extra data passed to custom builders.
  ///
  /// 传递给自定义 builder 的扩展数据。
  final Map<String, dynamic> extra;

  /// Create a toast data model.
  ///
  /// 创建 toast 数据模型。
  ToastDataModel({
    /// Toast type.
    ///
    /// toast 类型。
    required this.type,

    /// Message text.
    ///
    /// 消息文本。
    this.message,

    /// Message type.
    ///
    /// 消息类型。
    this.messageType = MessageType.info,

    /// Effect type override.
    ///
    /// 效果类型覆盖值。
    this.effectType,

    /// Progress value.
    ///
    /// 进度值。
    this.progress,

    /// Auto close duration.
    ///
    /// 自动关闭时长。
    this.closeDuration,

    /// Alignment override.
    ///
    /// 对齐方式覆盖值。
    this.alignment = Alignment.topCenter,

    /// Extra data.
    ///
    /// 扩展数据。
    this.extra = const <String, dynamic>{},
  });

  /// Creates an empty model representing `ToastType.none`.
  ///
  /// 创建一个表示 `ToastType.none` 的空模型。
  factory ToastDataModel.empty() {
    return ToastDataModel(type: ToastType.none);
  }
}
