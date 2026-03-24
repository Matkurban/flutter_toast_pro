import 'dart:async';

import 'package:flutter/material.dart';

import 'message_type.dart';
import 'toast_action.dart';
import 'toast_position.dart';

/// Unique auto-incrementing id generator for toast items.
int _nextId = 0;

String _generateId() => 'toast_${_nextId++}';

/// Base class for all toast items managed by [ToastManager].
sealed class ToastItem {
  ToastItem({
    String? id,
    required this.position,
    this.duration,
    DateTime? createdAt,
  }) : id = id ?? _generateId(),
       createdAt = createdAt ?? DateTime.now(),
       completer = Completer<void>();

  /// Unique identifier.
  final String id;

  /// Where the toast appears on screen.
  final ToastPosition position;

  /// How long the toast stays visible. `null` means it must be dismissed manually.
  final Duration? duration;

  /// Creation timestamp.
  final DateTime createdAt;

  /// Completes when the toast is dismissed.
  final Completer<void> completer;
}

/// A message toast (info / success / warning / error).
class MessageToastItem extends ToastItem {
  MessageToastItem({
    super.id,
    required this.message,
    this.type = MessageType.info,
    this.icon,
    this.action,
    super.position = ToastPosition.top,
    super.duration = const Duration(seconds: 3),
    this.swipeToDismiss = true,
    this.extra = const <String, dynamic>{},
  });

  /// Display text.
  final String message;

  /// Severity type which decides the color scheme.
  final MessageType type;

  /// Optional leading icon (uses default per-type icon when null).
  final IconData? icon;

  /// Optional action button (e.g. "Undo").
  final ToastAction? action;

  /// Whether this toast can be dismissed by swiping.
  final bool swipeToDismiss;

  /// Arbitrary extra data forwarded to custom builders.
  final Map<String, dynamic> extra;
}

/// A loading indicator toast (globally unique – showing a new one replaces the old).
class LoadingToastItem extends ToastItem {
  LoadingToastItem({
    super.id,
    this.message,
    super.position = ToastPosition.center,
    this.extra = const <String, dynamic>{},
  }) : super(duration: null);

  /// Optional message displayed below the indicator.
  final String? message;

  /// Arbitrary extra data forwarded to custom builders.
  final Map<String, dynamic> extra;
}

/// A progress indicator toast (globally unique).
class ProgressToastItem extends ToastItem {
  ProgressToastItem({
    super.id,
    required this.progress,
    this.message,
    super.position = ToastPosition.center,
    this.extra = const <String, dynamic>{},
  }) : super(duration: null);

  /// Progress value from 0.0 to 1.0.
  final double progress;

  /// Optional message displayed below the indicator.
  final String? message;

  /// Arbitrary extra data forwarded to custom builders.
  final Map<String, dynamic> extra;
}
