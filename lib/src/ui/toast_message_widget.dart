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
  Color _foregroundColor(ToastMessageType type, ColorScheme colorScheme) {
    return switch (type) {
      ToastMessageType.info => theme.infoForegroundColor ?? colorScheme.primary,
      ToastMessageType.success => theme.successForegroundColor ?? const Color(0xFF16A34A),
      ToastMessageType.warning => theme.warningForegroundColor ?? const Color(0xFFF59E0B),
      ToastMessageType.error => theme.errorForegroundColor ?? colorScheme.error,
    };
  }

  Color _backgroundColor(ToastMessageType type, ColorScheme colorScheme) {
    return switch (type) {
      ToastMessageType.info => theme.infoBackgroundColor ?? colorScheme.primary,
      ToastMessageType.success => theme.successBackgroundColor ?? const Color(0xFF16A34A),
      ToastMessageType.warning => theme.warningBackgroundColor ?? const Color(0xFFF59E0B),
      ToastMessageType.error => theme.errorBackgroundColor ?? colorScheme.error,
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
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    final Color foregroundColor = _foregroundColor(type, colorScheme);
    final Color backgroundColor = _backgroundColor(type, colorScheme);

    return Container(
      margin: theme.margin,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: theme.borderRadius,
        boxShadow: [
          BoxShadow(
            color: backgroundColor.withValues(alpha: 0.08),
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
            Icon(icon ?? _defaultIconFor(type), color: foregroundColor, size: 20),
            const SizedBox(width: 10),
          ],
          Flexible(
            child: Text(
              message,
              style: (theme.textStyle ?? const TextStyle()).copyWith(
                color: foregroundColor,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
              softWrap: true,
            ),
          ),
          if (action != null) ...[
            const SizedBox(width: 12),
            GestureDetector(
              onTap: action!.onPressed,
              child: Text(
                action!.label,
                style: (theme.actionTextStyle ?? const TextStyle()).copyWith(
                  color: foregroundColor,
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
