import 'package:flutter/material.dart';

import 'model/toast_theme.dart';
import 'toast.dart';
import 'toast_manager.dart';
import 'ui/toast_overlay.dart';

/// Root widget that enables the toast system for the subtree below it.
///
/// Wrap your [MaterialApp] (or [CupertinoApp]) with [ToastScope]:
///
/// ```dart
/// ToastScope(
///   child: MaterialApp(home: MyHomePage()),
/// )
/// ```
///
/// Then use the [FlutterToastPro] API anywhere:
///
/// ```dart
/// Toast.success('Saved!');
/// ```
class ToastScope extends StatefulWidget {
  const ToastScope({
    super.key,
    this.child,
    this.theme = const ToastThemeData(),
    this.messageBuilder,
    this.loadingBuilder,
    this.progressBuilder,
    this.initialEntries = const <OverlayEntry>[],
  });

  /// Your app widget.
  final Widget? child;

  /// Theme configuration for all toast types.
  final ToastThemeData theme;

  /// Custom builder for message toasts.
  final ToastMessageBuilder? messageBuilder;

  /// Custom builder for loading toasts.
  final ToastLoadingBuilder? loadingBuilder;

  /// Custom builder for progress toasts.
  final ToastProgressBuilder? progressBuilder;

  final List<OverlayEntry> initialEntries;

  @override
  State<ToastScope> createState() => _ToastScopeState();
}

class _ToastScopeState extends State<ToastScope> {
  late final ToastManager _manager;

  @override
  void initState() {
    super.initState();
    _manager = ToastManager(theme: widget.theme);
    FlutterToastPro.attach(_manager);
  }

  @override
  void didUpdateWidget(covariant ToastScope oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.theme != widget.theme) {
      _manager.theme = widget.theme;
    }
  }

  @override
  void dispose() {
    FlutterToastPro.detach();
    _manager.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Overlay(
      initialEntries: [
        if (widget.child != null) OverlayEntry(builder: (context) => widget.child!),
        OverlayEntry(
          builder: (context) => ListenableBuilder(
            listenable: _manager,
            builder: (context, _) {
              if (_manager.items.isEmpty) {
                return const SizedBox.shrink();
              }
              return Material(
                type: .transparency,
                child: ToastOverlay(
                  manager: _manager,
                  messageBuilder: widget.messageBuilder,
                  loadingBuilder: widget.loadingBuilder,
                  progressBuilder: widget.progressBuilder,
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
