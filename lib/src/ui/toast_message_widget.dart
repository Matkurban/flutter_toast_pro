import 'package:flutter/material.dart';

import '../model/message_type.dart';
import '../model/toast_action.dart';
import '../model/toast_theme.dart';
import 'glass_container.dart';

/// Default message toast widget with Material 3 + glassmorphism styling.
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
  final MessageType type;
  final MessageToastTheme theme;
  final bool enableGlass;
  final IconData? icon;
  final ToastAction? action;

  /// Returns the semantic color for the given [MessageType].
  Color _colorFor(MessageType type, ColorScheme cs) {
    return switch (type) {
      MessageType.info => theme.infoColor ?? cs.primary,
      MessageType.success => theme.successColor ?? const Color(0xFF16A34A),
      MessageType.warning => theme.warningColor ?? const Color(0xFFF59E0B),
      MessageType.error => theme.errorColor ?? const Color(0xFFEF4444),
    };
  }

  /// Returns the default icon for the given [MessageType].
  IconData _defaultIconFor(MessageType type) {
    return switch (type) {
      MessageType.info => Icons.info_outline_rounded,
      MessageType.success => Icons.check_circle_outline_rounded,
      MessageType.warning => Icons.warning_amber_rounded,
      MessageType.error => Icons.error_outline_rounded,
    };
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final color = _colorFor(type, cs);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final bgColor = enableGlass
        ? (isDark
              ? color.withValues(alpha: 0.15)
              : color.withValues(alpha: 0.08))
        : (isDark
              ? color.withValues(alpha: 0.25)
              : color.withValues(alpha: 0.12));

    final textColor = isDark ? Colors.white : color;
    final iconColor = color;

    final resolvedTextStyle = (theme.textStyle ?? const TextStyle()).copyWith(
      color: textColor,
      fontSize: 14,
      fontWeight: FontWeight.w500,
    );

    return GlassContainer(
      enableBlur: enableGlass,
      blurSigma: theme.blurSigma,
      backgroundColor: bgColor,
      borderRadius: theme.borderRadius.resolve(Directionality.of(context)),
      padding: theme.padding,
      margin: theme.margin,
      elevation: theme.elevation,
      border: Border.all(
        color: color.withValues(alpha: isDark ? 0.2 : 0.15),
        width: 0.5,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (theme.showIcon) ...[
            Icon(icon ?? _defaultIconFor(type), color: iconColor, size: 20),
            const SizedBox(width: 10),
          ],
          Flexible(
            child: Text(message, style: resolvedTextStyle, softWrap: true),
          ),
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
