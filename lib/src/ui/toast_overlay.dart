import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../model/toast_item.dart';
import '../model/toast_position.dart';
import '../model/toast_theme.dart';
import '../toast_manager.dart';
import 'dismissible_toast.dart';
import 'toast_animation.dart';
import 'toast_loading_widget.dart';
import 'toast_message_widget.dart';
import 'toast_progress_widget.dart';

/// Custom builder for message toasts.
typedef ToastMessageBuilder = Widget Function(BuildContext context, MessageToastItem item);

/// Custom builder for loading toasts.
typedef ToastLoadingBuilder = Widget Function(BuildContext context, LoadingToastItem item);

/// Custom builder for progress toasts.
typedef ToastProgressBuilder = Widget Function(BuildContext context, ProgressToastItem item);

/// The full-screen overlay that renders all active toasts.
///
/// Listens to [ToastManager] and rebuilds whenever the toast list changes.
class ToastOverlay extends StatefulWidget {
  const ToastOverlay({
    super.key,
    required this.manager,
    this.onIdle,
    this.messageBuilder,
    this.loadingBuilder,
    this.progressBuilder,
  });

  final ToastManager manager;
  final VoidCallback? onIdle;
  final ToastMessageBuilder? messageBuilder;
  final ToastLoadingBuilder? loadingBuilder;
  final ToastProgressBuilder? progressBuilder;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<ToastManager>('manager', manager));
  }

  @override
  State<ToastOverlay> createState() => _ToastOverlayState();
}

class _ToastOverlayState extends State<ToastOverlay> {
  /// Keys for each active toast so we can drive their exit animation.
  final Map<String, GlobalKey<ToastAnimationWrapperState>> _animKeys = {};

  /// The set of ids currently animating out (to avoid double-dismiss).
  final Set<String> _dismissing = {};

  /// Snapshot of toast ids we rendered last frame (for diff).
  List<String> _previousIds = [];

  ToastThemeData get _theme => widget.manager.theme;

  @override
  void initState() {
    super.initState();
    _previousIds = widget.manager.items.map((t) => t.id).toList();
    widget.manager.addListener(_onManagerChanged);
  }

  @override
  void didUpdateWidget(covariant ToastOverlay oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.manager != widget.manager) {
      oldWidget.manager.removeListener(_onManagerChanged);
      widget.manager.addListener(_onManagerChanged);
      _previousIds = widget.manager.items.map((t) => t.id).toList();
    }
  }

  @override
  void dispose() {
    widget.manager.removeListener(_onManagerChanged);
    super.dispose();
  }

  void _checkIdle() {
    if (widget.manager.items.isEmpty && _animKeys.isEmpty && _dismissing.isEmpty) {
      widget.onIdle?.call();
    }
  }

  void _onManagerChanged() {
    if (!mounted) return;

    // Detect removed items and trigger exit animation.
    final currentIds = widget.manager.items.map((t) => t.id).toSet();
    for (final oldId in _previousIds) {
      if (!currentIds.contains(oldId) && !_dismissing.contains(oldId)) {
        _animateOut(oldId);
      }
    }
    _previousIds = currentIds.toList();

    setState(() {});
    _checkIdle();
  }

  void _animateOut(String id) {
    final key = _animKeys[id];
    if (key?.currentState != null) {
      _dismissing.add(id);
      key!.currentState!.animateOut().then((_) {
        _dismissing.remove(id);
        _animKeys.remove(id);
        if (mounted) {
          setState(() {});
          _checkIdle();
        }
      });
    } else {
      _animKeys.remove(id);
      _checkIdle();
    }
  }

  void _dismiss(String id) {
    widget.manager.dismiss(id);
  }

  // ---------------------------------------------------------------------------
  // Build
  // ---------------------------------------------------------------------------

  @override
  Widget build(BuildContext context) {
    final items = widget.manager.items;

    // Separate by type / position.
    final topMessages = <ToastItem>[];
    final bottomMessages = <ToastItem>[];
    final centerItems = <ToastItem>[]; // loading / progress / center messages

    for (final item in items) {
      if (item is MessageToastItem) {
        switch (item.position) {
          case ToastPosition.top:
            topMessages.add(item);
          case ToastPosition.bottom:
            bottomMessages.add(item);
          case ToastPosition.center:
            centerItems.add(item);
        }
      } else {
        centerItems.add(item);
      }
    }

    // Check if we have any loading / progress toast for barrier.
    final hasBarrier = items.any((t) => t is LoadingToastItem || t is ProgressToastItem);

    return Stack(
      children: [
        // Barrier (only for loading / progress).
        if (hasBarrier) Positioned.fill(child: _buildBarrier(items)),

        // Top messages.
        if (topMessages.isNotEmpty)
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: SafeArea(
              bottom: false,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(height: _theme.spacing),
                  for (final item in topMessages) _buildToastEntry(item),
                ],
              ),
            ),
          ),

        // Center items (loading, progress, center-positioned messages).
        if (centerItems.isNotEmpty)
          Positioned.fill(
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [for (final item in centerItems) _buildToastEntry(item)],
              ),
            ),
          ),

        // Bottom messages.
        if (bottomMessages.isNotEmpty)
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: SafeArea(
              top: false,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  for (final item in bottomMessages.reversed) _buildToastEntry(item),
                  SizedBox(height: _theme.spacing),
                ],
              ),
            ),
          ),
      ],
    );
  }

  // ---------------------------------------------------------------------------
  // Barrier
  // ---------------------------------------------------------------------------

  Widget _buildBarrier(List<ToastItem> items) {
    Color barrierColor = Colors.transparent;
    bool ignorePointer = true;
    bool barrierDismissible = false;
    String? dismissId;

    for (final item in items) {
      if (item is LoadingToastItem) {
        barrierColor = _theme.loadingTheme.overlayColor;
        ignorePointer = _theme.loadingTheme.ignorePointer;
        barrierDismissible = _theme.loadingTheme.barrierDismissible;
        dismissId = item.id;
        break;
      }
      if (item is ProgressToastItem) {
        barrierColor = _theme.progressTheme.overlayColor;
        ignorePointer = _theme.progressTheme.ignorePointer;
        barrierDismissible = _theme.progressTheme.barrierDismissible;
        dismissId = item.id;
        break;
      }
    }

    Widget barrier = AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      color: barrierColor,
    );

    if (barrierDismissible && dismissId != null) {
      final id = dismissId;
      barrier = GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () => _dismiss(id),
        child: barrier,
      );
    }

    return IgnorePointer(ignoring: ignorePointer, child: barrier);
  }

  // ---------------------------------------------------------------------------
  // Individual toast entry
  // ---------------------------------------------------------------------------

  Widget _buildToastEntry(ToastItem item) {
    // Get or create animation key.
    _animKeys.putIfAbsent(item.id, () => GlobalKey<ToastAnimationWrapperState>());
    final animKey = _animKeys[item.id]!;

    Widget content = _buildToastContent(item);

    // Wrap in dismissible gesture (only for messages).
    if (item is MessageToastItem) {
      final enableSwipe = _theme.enableSwipeToDismiss && item.swipeToDismiss;

      if (_theme.messageTheme.tapToDismiss) {
        content = GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () => _dismiss(item.id),
          child: content,
        );
      }

      content = DismissibleToast(
        position: item.position,
        enabled: enableSwipe,
        onDismissed: () => _dismiss(item.id),
        child: content,
      );

      // Message ignoring.
      content = IgnorePointer(ignoring: _theme.messageTheme.ignorePointer, child: content);
    }

    // Spacing between stacked items.
    content = Padding(
      padding: EdgeInsets.only(bottom: _theme.spacing),
      child: content,
    );

    return ToastAnimationWrapper(
      key: animKey,
      position: item.position,
      duration: _theme.animationDuration,
      reverseDuration: _theme.reverseAnimationDuration ?? _theme.animationDuration,
      curve: _theme.animationCurve,
      reverseCurve: _theme.reverseAnimationCurve,
      onDismissed: () {
        // Already handled by manager.
      },
      child: content,
    );
  }

  // ---------------------------------------------------------------------------
  // Toast content (delegates to default or custom builder)
  // ---------------------------------------------------------------------------

  Widget _buildToastContent(ToastItem item) {
    return switch (item) {
      MessageToastItem() =>
        widget.messageBuilder?.call(context, item) ??
            DefaultMessageWidget(
              message: item.message,
              type: item.type,
              theme: _theme.messageTheme,
              enableGlass: _theme.enableGlassmorphism,
              icon: item.icon,
              action: item.action,
            ),
      LoadingToastItem() =>
        widget.loadingBuilder?.call(context, item) ??
            DefaultLoadingWidget(
              theme: _theme.loadingTheme,
              enableGlass: _theme.enableGlassmorphism,
              message: item.message,
            ),
      ProgressToastItem() =>
        widget.progressBuilder?.call(context, item) ??
            DefaultProgressWidget(
              progress: item.progress,
              theme: _theme.progressTheme,
              enableGlass: _theme.enableGlassmorphism,
              message: item.message,
            ),
    };
  }
}
