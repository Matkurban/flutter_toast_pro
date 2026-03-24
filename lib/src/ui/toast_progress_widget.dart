import 'package:flutter/material.dart';

import '../model/toast_theme.dart';
import 'glass_container.dart';

/// Default progress toast widget with Material 3 + glassmorphism styling.
class DefaultProgressWidget extends StatelessWidget {
  const DefaultProgressWidget({
    super.key,
    required this.progress,
    required this.theme,
    required this.enableGlass,
    this.message,
  });

  final double progress;
  final ProgressToastTheme theme;
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

    final indicatorBg =
        theme.indicatorBackgroundColor ?? indicatorColor.withValues(alpha: 0.2);

    final textColor = isDark ? Colors.white70 : Colors.black87;

    final pct = (progress * 100).round();

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
          SizedBox(
            width: theme.indicatorSize,
            height: theme.indicatorSize,
            child: Stack(
              alignment: Alignment.center,
              children: [
                CircularProgressIndicator(
                  value: progress,
                  color: indicatorColor,
                  backgroundColor: indicatorBg,
                  strokeWidth: theme.strokeWidth,
                ),
                Text(
                  '$pct%',
                  style: TextStyle(
                    color: isDark ? Colors.white : Colors.black87,
                    fontSize: theme.indicatorSize * 0.22,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          if (message != null) ...[
            const SizedBox(height: 12),
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
