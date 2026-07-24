import 'package:flutter/material.dart';

import 'model/toast_message_type.dart';
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
  static ToastManager? _toastManager;

  static ToastManager get _manager {
    assert(
      _toastManager != null,
      'Toast was used before ToastScope was mounted. '
      'Wrap your app with ToastScope.',
    );
    return _toastManager!;
  }

  /// Called by [ToastScope] to attach the manager.
  static void attach(ToastManager manager) => _toastManager = manager;

  /// Called by [ToastScope] to detach the manager.
  static void detach([ToastManager? manager]) {
    if (manager == null || _toastManager == manager) {
      _toastManager = null;
    }
  }

  // ---------------------------------------------------------------------------
  // Message toasts
  // ---------------------------------------------------------------------------

  /// Show a message toast.
  static Future<void> show(
    String message, {
    ToastMessageType type = ToastMessageType.info,
    IconData? icon,
    Duration? duration,
    ToastPosition? position,
    ToastAction? action,
    bool swipeToDismiss = true,
    Map<String, dynamic> extra = const <String, dynamic>{},
  }) {
    return _manager.show(
      MessageToastItem(
        message: message,
        type: type,
        icon: icon,
        duration: duration ?? const Duration(seconds: 3),
        position: position ?? _manager.theme.position,
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
      type: ToastMessageType.info,
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
      type: ToastMessageType.success,
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
      type: ToastMessageType.warning,
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
      type: ToastMessageType.error,
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
    return _manager.show(LoadingToastItem(message: message, position: position, extra: extra));
  }

  /// Dismiss the current loading indicator.
  static void hideLoading() => _manager.dismissLoading();

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
    final existing = _manager.items.whereType<ProgressToastItem>().firstOrNull;
    if (existing != null) {
      _manager.updateProgress(progress, message: message);
    } else {
      _manager.show(
        ProgressToastItem(progress: progress, message: message, position: position, extra: extra),
      );
    }
  }

  /// Dismiss the current progress indicator.
  static void hideProgress() => _manager.dismissProgress();

  // ---------------------------------------------------------------------------
  // Generic dismiss
  // ---------------------------------------------------------------------------

  /// Dismiss a specific toast by [id].
  static void dismiss(String id) => _manager.dismiss(id);

  /// Dismiss all toasts.
  static void dismissAll() => _manager.dismissAll();
}
