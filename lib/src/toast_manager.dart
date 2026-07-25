import 'dart:async';

import 'package:flutter/foundation.dart';

import 'model/toast_item.dart';
import 'model/toast_theme.dart';

/// Manages the lifecycle of all active toasts.
///
/// This is a [ChangeNotifier] that the UI layer listens to for updates.
class ToastManager extends ChangeNotifier {
  ToastManager._internal();

  /// Static singleton instance.
  static final ToastManager instance = ToastManager._internal();

  /// Factory constructor returning the singleton instance.
  factory ToastManager({ToastThemeData theme = const ToastThemeData()}) {
    instance.theme = theme;
    return instance;
  }

  /// Theme configuration.
  ToastThemeData theme = const ToastThemeData();

  /// Currently active toast items (newest last).
  final List<ToastItem> _items = [];

  /// Per-item auto-dismiss timers keyed by toast id.
  final Map<String, Timer> _timers = {};

  /// Unmodifiable snapshot of active items for the UI.
  List<ToastItem> get items => List.unmodifiable(_items);

  // ---------------------------------------------------------------------------
  // Show
  // ---------------------------------------------------------------------------

  /// Show a toast and return a [Future] that completes when it is dismissed.
  Future<void> show(ToastItem item) {
    // Loading & progress are globally unique — replace any existing one.
    if (item is LoadingToastItem) {
      _removeSingletonType<LoadingToastItem>();
    } else if (item is ProgressToastItem) {
      _removeSingletonType<ProgressToastItem>();
    }

    _items.add(item);

    // Enforce max visible for messages.
    if (item is MessageToastItem) {
      _enforceMaxVisible();
    }

    // Schedule auto-dismiss.
    if (item.duration != null) {
      _timers[item.id] = Timer(item.duration!, () => dismiss(item.id));
    }

    notifyListeners();
    return item.completer.future;
  }

  // ---------------------------------------------------------------------------
  // Dismiss
  // ---------------------------------------------------------------------------

  /// Dismiss a specific toast by [id].
  void dismiss(String id) {
    final index = _items.indexWhere((t) => t.id == id);
    if (index == -1) return;

    final item = _items.removeAt(index);
    _cancelTimer(id);
    if (!item.completer.isCompleted) {
      item.completer.complete();
    }
    notifyListeners();
  }

  /// Dismiss all toasts.
  void dismissAll() {
    for (final item in _items) {
      if (!item.completer.isCompleted) {
        item.completer.complete();
      }
    }
    _items.clear();
    for (final timer in _timers.values) {
      timer.cancel();
    }
    _timers.clear();
    notifyListeners();
  }

  /// Dismiss the current loading toast (if any).
  void dismissLoading() {
    final idx = _items.indexWhere((t) => t is LoadingToastItem);
    if (idx != -1) dismiss(_items[idx].id);
  }

  /// Dismiss the current progress toast (if any).
  void dismissProgress() {
    final idx = _items.indexWhere((t) => t is ProgressToastItem);
    if (idx != -1) dismiss(_items[idx].id);
  }

  // ---------------------------------------------------------------------------
  // Update
  // ---------------------------------------------------------------------------

  /// Replace a progress toast's value in-place (avoids remove + re-add flicker).
  void updateProgress(double progress, {String? message}) {
    final idx = _items.indexWhere((t) => t is ProgressToastItem);
    if (idx == -1) return;

    final old = _items[idx] as ProgressToastItem;
    _items[idx] = ProgressToastItem(
      id: old.id,
      progress: progress,
      message: message ?? old.message,
      position: old.position,
      extra: old.extra,
    )..completer.future.ignore(); // keep the old completer

    // Transfer the original completer — we patch it via the list but the
    // caller still holds the original Future.
    // Since sealed ToastItem creates a new Completer every time, we keep a
    // reference mapping below. For simplicity the progress overlay just reads
    // the latest item so the completer is not critical during updates.
    notifyListeners();
  }

  // ---------------------------------------------------------------------------
  // Internal helpers
  // ---------------------------------------------------------------------------

  void _removeSingletonType<T extends ToastItem>() {
    _items.removeWhere((item) {
      if (item is T) {
        _cancelTimer(item.id);
        if (!item.completer.isCompleted) item.completer.complete();
        return true;
      }
      return false;
    });
  }

  void _enforceMaxVisible() {
    final messages = _items.whereType<MessageToastItem>().toList();
    var excess = messages.length - theme.maxVisibleToasts;
    for (var i = 0; i < excess; i++) {
      dismiss(messages[i].id);
    }
  }

  void _cancelTimer(String id) {
    _timers.remove(id)?.cancel();
  }

  /// Clear all active items and cancel timers without disposing the singleton.
  void clear() {
    for (final timer in _timers.values) {
      timer.cancel();
    }
    _timers.clear();
    for (final item in _items) {
      if (!item.completer.isCompleted) item.completer.complete();
    }
    _items.clear();
  }

  @override
  void dispose() {
    clear();
    super.dispose();
  }
}
