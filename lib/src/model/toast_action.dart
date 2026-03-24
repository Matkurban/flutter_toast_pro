import 'package:flutter/material.dart';

/// An optional action button displayed on a toast.
@immutable
class ToastAction {
  const ToastAction({required this.label, required this.onPressed});

  /// Button label text.
  final String label;

  /// Callback when the action is tapped.
  final VoidCallback onPressed;
}
