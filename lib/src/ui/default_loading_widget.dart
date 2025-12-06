import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';

class DefaultLoadingWidget extends StatelessWidget {
  const DefaultLoadingWidget({super.key, this.message, this.alignment});

  final String? message;

  final Alignment? alignment;

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
          mainAxisSize: .min,
          children: [
            SizedBox(
              width: 48,
              height: 48,
              child: LoadingIndicator(
                indicatorType: Indicator.ballSpinFadeLoader,
                colors: [Colors.blue, Colors.purple, Colors.red, Colors.orange, Colors.green],
              ),
            ),
            if (message != null) Text(message!),
          ],
        ),
      ),
    );
  }
}
