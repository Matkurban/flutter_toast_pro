import 'package:flutter/material.dart';

import '../model/message_type.dart';

class DefaultMessageWidget extends StatelessWidget {
  const DefaultMessageWidget({
    super.key,
    required this.message,
    required this.type,
    required this.alignment,
  });

  final String message;

  final MessageType type;

  final AlignmentGeometry alignment;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.sizeOf(context);
    Color bgColor;
    Color textColor;
    switch (type) {
      case MessageType.info:
        bgColor = Color(0xfffdfbfb);
        textColor = Colors.black;
      case MessageType.success:
        bgColor = Color(0xff3ce55c);
        textColor = Colors.white;
      case MessageType.warning:
        bgColor = Color(0xffd89a4a);
        textColor = Colors.white;
      case MessageType.error:
        bgColor = Color(0xffe32b2b);
        textColor = Colors.white;
    }
    return Container(
      width: size.width,
      height: size.height,
      alignment: alignment,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadiusGeometry.circular(10),
        ),
        child: Text(message, style: TextStyle(color: textColor)),
      ),
    );
  }
}
