import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../model/toast_theme.dart';
import 'glass_container.dart';

/// Default loading toast widget with Material 3 + glassmorphism styling.
class DefaultLoadingWidget extends StatelessWidget {
  const DefaultLoadingWidget({
    super.key,
    required this.theme,
    required this.enableGlass,
    this.message,
  });

  final LoadingToastTheme theme;
  final bool enableGlass;
  final String? message;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final bgColor =
        theme.backgroundColor ??
        (isDark
            ? Colors.black.withValues(alpha: 0.65)
            : Colors.white.withValues(alpha: 0.85));

    final indicatorColor =
        theme.indicatorColor ??
        (isDark ? Colors.white : Theme.of(context).colorScheme.primary);

    final textColor = isDark ? Colors.white70 : Colors.black87;

    return GlassContainer(
      enableBlur: enableGlass,
      blurSigma: theme.blurSigma,
      backgroundColor: bgColor,
      borderRadius: theme.borderRadius.resolve(Directionality.of(context)),
      padding: theme.padding,
      margin: theme.margin,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CupertinoActivityIndicator(
            radius: theme.indicatorSize / 2,
            color: indicatorColor,
          ),
          if (message != null) ...[
            SizedBox(height: theme.messageSpacing),
            Text(
              message!,
              style:
                  theme.messageTextStyle ??
                  TextStyle(color: textColor, fontSize: 13),
              textAlign: TextAlign.center,
            ),
          ],
        ],
      ),
    );
  }
}
