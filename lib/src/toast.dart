import 'package:flutter/material.dart';

import 'model/message_type.dart';
import 'model/toast_action.dart';
import 'model/toast_item.dart';
import 'model/toast_position.dart';
import 'toast_manager.dart';

/// Public API for showing and dismissing toasts.
///
/// Before calling any method, ensure [ToastScope] is in the widget tree.
///
/// ```dart
/// FlutterToastPro.show('Hello');
/// FlutterToastPro.success('Saved!');
/// await FlutterToastPro.loading(message: 'Please wait…');
/// ```
sealed class FlutterToastPro {
  /// The global [ToastManager] attached by [ToastScope].
  /// Throws if [ToastScope] has not been mounted yet.
  static ToastManager? _manager;

  static ToastManager get _m {
    assert(
      _manager != null,
      'Toast was used before ToastScope was mounted. '
      'Wrap your app with ToastScope.',
    );
    return _manager!;
  }

  /// Called by [ToastScope] to attach the manager.
  static void attach(ToastManager manager) => _manager = manager;

  /// Called by [ToastScope] to detach the manager.
  static void detach() => _manager = null;

  // ---------------------------------------------------------------------------
  // Message toasts
  // ---------------------------------------------------------------------------

  /// Show a message toast.
  static Future<void> show(
    String message, {
    MessageType type = MessageType.info,
    IconData? icon,
    Duration? duration,
    ToastPosition? position,
    ToastAction? action,
    bool swipeToDismiss = true,
    Map<String, dynamic> extra = const <String, dynamic>{},
  }) {
    return _m.show(
      MessageToastItem(
        message: message,
        type: type,
        icon: icon,
        duration: duration ?? const Duration(seconds: 3),
        position: position ?? _m.theme.position,
        action: action,
        swipeToDismiss: swipeToDismiss,
        extra: extra,
      ),
    );
  }

  /// Show an info toast.
  static Future<void> info(
    String message, {
    IconData? icon,
    Duration? duration,
    ToastPosition? position,
    ToastAction? action,
    Map<String, dynamic> extra = const <String, dynamic>{},
  }) {
    return show(
      message,
      type: MessageType.info,
      icon: icon,
      duration: duration,
      position: position,
      action: action,
      extra: extra,
    );
  }

  /// Show a success toast.
  static Future<void> success(
    String message, {
    IconData? icon,
    Duration? duration,
    ToastPosition? position,
    ToastAction? action,
    Map<String, dynamic> extra = const <String, dynamic>{},
  }) {
    return show(
      message,
      type: MessageType.success,
      icon: icon,
      duration: duration,
      position: position,
      action: action,
      extra: extra,
    );
  }

  /// Show a warning toast.
  static Future<void> warning(
    String message, {
    IconData? icon,
    Duration? duration,
    ToastPosition? position,
    ToastAction? action,
    Map<String, dynamic> extra = const <String, dynamic>{},
  }) {
    return show(
      message,
      type: MessageType.warning,
      icon: icon,
      duration: duration,
      position: position,
      action: action,
      extra: extra,
    );
  }

  /// Show an error toast.
  static Future<void> error(
    String message, {
    IconData? icon,
    Duration? duration,
    ToastPosition? position,
    ToastAction? action,
    Map<String, dynamic> extra = const <String, dynamic>{},
  }) {
    return show(
      message,
      type: MessageType.error,
      icon: icon,
      duration: duration,
      position: position,
      action: action,
      extra: extra,
    );
  }

  // ---------------------------------------------------------------------------
  // Loading toast
  // ---------------------------------------------------------------------------

  /// Show a loading indicator.
  ///
  /// Returns a [Future] that completes when the loading is dismissed.
  static Future<void> loading({
    String? message,
    ToastPosition position = ToastPosition.center,
    Map<String, dynamic> extra = const <String, dynamic>{},
  }) {
    return _m.show(
      LoadingToastItem(message: message, position: position, extra: extra),
    );
  }

  /// Dismiss the current loading indicator.
  static void hideLoading() => _m.dismissLoading();

  // ---------------------------------------------------------------------------
  // Progress toast
  // ---------------------------------------------------------------------------

  /// Show or update a progress indicator.
  ///
  /// Call repeatedly with increasing [progress] (0.0–1.0).
  static void progress(
    double progress, {
    String? message,
    ToastPosition position = ToastPosition.center,
    Map<String, dynamic> extra = const <String, dynamic>{},
  }) {
    // If a progress toast already exists, update in-place.
    final existing = _m.items.whereType<ProgressToastItem>().firstOrNull;
    if (existing != null) {
      _m.updateProgress(progress, message: message);
    } else {
      _m.show(
        ProgressToastItem(
          progress: progress,
          message: message,
          position: position,
          extra: extra,
        ),
      );
    }
  }

  /// Dismiss the current progress indicator.
  static void hideProgress() => _m.dismissProgress();

  // ---------------------------------------------------------------------------
  // Generic dismiss
  // ---------------------------------------------------------------------------

  /// Dismiss a specific toast by [id].
  static void dismiss(String id) => _m.dismiss(id);

  /// Dismiss all toasts.
  static void dismissAll() => _m.dismissAll();
}
