import 'package:flutter/material.dart';

/// Position where toasts appear on screen.
enum ToastPosition {
  /// Top of the screen.
  top(Alignment.topCenter),

  /// Center of the screen.
  center(Alignment.center),

  /// Bottom of the screen.
  bottom(Alignment.bottomCenter);

  const ToastPosition(this.alignment);

  /// The alignment corresponding to this position.
  final Alignment alignment;
}
