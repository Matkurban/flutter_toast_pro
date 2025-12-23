import 'package:flutter/material.dart';
import 'package:flutter_toast_pro/src/model/effect_type.dart';
import 'model/message_type.dart';

/// Toast message builder.
///
/// message 类型 toast 的自定义构建器。
///
/// Parameters / 参数：
/// - [context] BuildContext / 构建上下文
/// - [message] Message text / 消息文本
/// - [type] Message type / 消息类型
/// - [effectType] Effect type / 效果类型
/// - [alignment] Alignment in overlay / 覆盖层对齐
/// - [extra] Extra data / 扩展数据
///
/// Only used for message toasts.
///
/// 仅用于 message 类型 toast。
typedef ToastMessageBuilder =
    Widget Function(
      BuildContext context,
      String message,
      MessageType type,
      EffectType effectType,
      Alignment alignment,
      Map<String, dynamic> extra,
    );

/// Toast progress builder.
///
/// progress 类型 toast 的自定义构建器。
///
/// Parameters / 参数：
/// - [context] BuildContext / 构建上下文
/// - [progress] Progress value / 进度值
/// - [message] Optional message / 可选文案
/// - [alignment] Alignment in overlay / 覆盖层对齐
/// - [extra] Extra data / 扩展数据
///
/// Only used for progress toasts.
///
/// 仅用于 progress 类型 toast。
typedef ToastProgressBuilder =
    Widget Function(
      BuildContext context,
      double progress,
      String? message,
      Alignment alignment,
      Map<String, dynamic> extra,
    );

/// Toast loading builder.
///
/// loading 类型 toast 的自定义构建器。
///
/// Parameters / 参数：
/// - [context] BuildContext / 构建上下文
/// - [message] Optional message / 可选文案
/// - [alignment] Alignment in overlay / 覆盖层对齐
/// - [extra] Extra data / 扩展数据
///
/// Only used for loading toasts.
///
/// 仅用于 loading 类型 toast。
typedef ToastLoadingBuilder =
    Widget Function(
      BuildContext context,
      String? message,
      Alignment alignment,
      Map<String, dynamic> extra,
    );

/// Message text style builder.
///
/// message 文本样式构建器。
///
/// Parameters / 参数：
/// - [type] Message type / 消息类型
/// - [effectType] Effect type / 效果类型
typedef MessageTextStyleBuilder =
    TextStyle Function(MessageType type, EffectType effectType);
