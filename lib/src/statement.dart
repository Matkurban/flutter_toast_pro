import 'package:flutter/material.dart';
import 'model/message_type.dart';

///显示消息的声明
///[message] 消息的内容
///[extra] 扩展数据
///只用于普通消息
typedef ToastMessageBuilder =
    Widget Function(
      BuildContext context,
      String message,
      MessageType type,
      AlignmentGeometry alignment,
      Map<String, dynamic> extra,
    );

///显示进度消息的声明
///[message] 加载中消息的内容
///[progress] 进度数据
///[extra] 扩展数据
///只用于进度消息
typedef ToastProgressBuilder =
    Widget Function(
      BuildContext context,
      double progress,
      String? message,
      AlignmentGeometry alignment,
      Map<String, dynamic> extra,
    );

///显示加载中的声明
///[message] 消息的内容
///[extra] 扩展数据
///只用于加载中消息
typedef ToastLoadingBuilder =
    Widget Function(
      BuildContext context,
      String? message,
      AlignmentGeometry alignment,
      Map<String, dynamic> extra,
    );
