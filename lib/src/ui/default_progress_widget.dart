import 'package:flutter/material.dart';

class DefaultProgressWidget extends StatelessWidget {
  const DefaultProgressWidget({super.key, required this.progress, this.message, this.alignment});

  final double? progress;

  final String? message;

  final AlignmentGeometry? alignment;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.sizeOf(context);
    return Container(
      width: size.width,
      height: size.height,
      alignment: alignment,
      child: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.black.withValues(alpha: 0.3),
          borderRadius: BorderRadiusGeometry.circular(10),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: 48,
              height: 48,
              child: CircularProgressIndicator(
                value: progress,
                constraints: BoxConstraints(maxHeight: 48, maxWidth: 48),
              ),
            ),
            if (message != null) Text(message!),
          ],
        ),
      ),
    );
  }
}
