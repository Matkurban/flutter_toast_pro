import 'package:flutter/material.dart';

import 'model/message_style_options.dart';

/// Central place for package defaults.
sealed class FlutterToastProDefaults {
  static MessageStyleOptions messageStyle({
    EdgeInsetsGeometry padding = const EdgeInsets.symmetric(
      horizontal: 16,
      vertical: 12,
    ),
    EdgeInsetsGeometry? margin,
    BorderRadiusGeometry borderRadius = const BorderRadius.all(
      Radius.circular(10),
    ),
  }) {
    return MessageStyleOptions(
      info: InfoMessageColorOption(
        primaryLight: ColorOption(
          backgroundColor: Colors.black.withValues(alpha: 0.3),
          foregroundColor: Colors.white,
        ),
        primary: ColorOption(
          backgroundColor: Colors.black,
          foregroundColor: Colors.white,
        ),
      ),
      success: SuccessMessageColorOption(
        primaryLight: ColorOption(
          backgroundColor: const Color(0xFF67c23a).withValues(alpha: 0.3),
          foregroundColor: const Color(0xFF67c23a),
        ),
        primary: ColorOption(
          backgroundColor: const Color(0xFF67c23a),
          foregroundColor: Colors.white,
        ),
      ),
      warning: WarningMessageColorOption(
        primaryLight: ColorOption(
          backgroundColor: const Color(0xFFe6a23d).withValues(alpha: 0.3),
          foregroundColor: const Color(0xFFe6a23d),
        ),
        primary: ColorOption(
          backgroundColor: const Color(0xFFe6a23d),
          foregroundColor: Colors.white,
        ),
      ),
      error: ErrorMessageColorOption(
        primaryLight: ColorOption(
          backgroundColor: const Color(0xFFEF4444).withValues(alpha: 0.3),
          foregroundColor: const Color(0xFFEF4444),
        ),
        primary: ColorOption(
          backgroundColor: const Color(0xFFEF4444),
          foregroundColor: Colors.white,
        ),
      ),
      padding: padding,
      margin: margin,
      borderRadius: borderRadius,
    );
  }
}
