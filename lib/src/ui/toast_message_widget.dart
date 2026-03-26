import 'package:flutter/material.dart';

import '../model/toast_message_type.dart';
import '../model/toast_action.dart';
import '../model/toast_theme.dart';

/// Default message toast widget with Material 3 tonal card styling.
///
/// Uses opaque surface-tinted backgrounds for reliable contrast on any
/// background – backdrop blur is intentionally NOT used for messages because
/// it looks poor when the underlying content is a uniform color.
class DefaultMessageWidget extends StatelessWidget {
  const DefaultMessageWidget({
    super.key,
    required this.message,
    required this.type,
    required this.theme,
    required this.enableGlass,
    this.icon,
    this.action,
  });

  final String message;
  final ToastMessageType type;
  final MessageToastTheme theme;
  final bool enableGlass; // kept for API compat; does not enable backdrop blur
  final IconData? icon;
  final ToastAction? action;

  /// Returns the semantic color for the given [ToastMessageType].
  Color _colorFor(ToastMessageType type, ColorScheme cs) {
    return switch (type) {
      ToastMessageType.info => theme.infoColor ?? cs.primary,
      ToastMessageType.success => theme.successColor ?? const Color(0xFF16A34A),
      ToastMessageType.warning => theme.warningColor ?? const Color(0xFFF59E0B),
      ToastMessageType.error => theme.errorColor ?? cs.error,
    };
  }

  /// Returns the default icon for the given [ToastMessageType].
  IconData _defaultIconFor(ToastMessageType type) {
    return switch (type) {
      ToastMessageType.info => Icons.info_outline_rounded,
      ToastMessageType.success => Icons.check_circle_outline_rounded,
      ToastMessageType.warning => Icons.warning_amber_rounded,
      ToastMessageType.error => Icons.error_outline_rounded,
    };
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final color = _colorFor(type, cs);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    // Material 3 tonal card: opaque tinted surface background.
    final bgColor = Color.alphaBlend(
      color.withValues(alpha: isDark ? 0.18 : 0.10),
      isDark ? cs.surfaceContainer : Colors.white,
    );

    final textColor = isDark ? Colors.white.withValues(alpha: 0.92) : color;

    final resolvedTextStyle = (theme.textStyle ?? const TextStyle()).copyWith(
      color: textColor,
      fontSize: 14,
      fontWeight: FontWeight.w500,
    );

    final borderRadius = theme.borderRadius.resolve(Directionality.of(context));

    return Container(
      margin: theme.margin,
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: borderRadius,
        border: Border.all(color: color.withValues(alpha: isDark ? 0.15 : 0.12), width: 0.5),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: isDark ? 0.25 : 0.08),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      padding: theme.padding,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (theme.showIcon) ...[
            Icon(icon ?? _defaultIconFor(type), color: color, size: 20),
            const SizedBox(width: 10),
          ],
          Flexible(child: Text(message, style: resolvedTextStyle, softWrap: true)),
          if (action != null) ...[
            const SizedBox(width: 12),
            GestureDetector(
              onTap: action!.onPressed,
              child: Text(
                action!.label,
                style: (theme.actionTextStyle ?? const TextStyle()).copyWith(
                  color: color,
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
