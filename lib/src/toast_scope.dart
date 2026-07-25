import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'model/toast_theme.dart';
import 'toast.dart';
import 'toast_manager.dart';
import 'ui/toast_overlay.dart';

/// Root widget that enables the toast system for the subtree below it.
class ToastScope extends StatefulWidget {
  const ToastScope({
    super.key,
    this.overlayKey,
    this.child,
    this.theme = const ToastThemeData(),
    this.messageBuilder,
    this.loadingBuilder,
    this.progressBuilder,
    this.initialEntries = const <OverlayEntry>[],
  });

  /// [Overlay] key
  final Key? overlayKey;

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
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<ToastThemeData>('theme', theme));
    properties.add(IterableProperty<OverlayEntry>('initialEntries', initialEntries));
  }

  @override
  State<ToastScope> createState() => _ToastScopeState();
}

class _ToastScopeState extends State<ToastScope> {
  ToastManager get _manager => ToastManager.instance;
  bool _hasActiveToasts = false;

  @override
  void initState() {
    super.initState();
    _manager.theme = widget.theme;
    _manager.addListener(_onManagerChanged);
    FlutterToastPro.attach(_manager);
    if (_manager.items.isNotEmpty || widget.initialEntries.isNotEmpty) {
      _hasActiveToasts = true;
    }
  }

  @override
  void didUpdateWidget(covariant ToastScope oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.theme != widget.theme) {
      _manager.theme = widget.theme;
    }
  }

  @override
  void reassemble() {
    super.reassemble();
    FlutterToastPro.attach(_manager);
  }

  @override
  void dispose() {
    _manager.removeListener(_onManagerChanged);
    FlutterToastPro.detach(_manager);
    super.dispose();
  }

  void _onManagerChanged() {
    if (_manager.items.isNotEmpty || widget.initialEntries.isNotEmpty) {
      if (!_hasActiveToasts) {
        setState(() {
          _hasActiveToasts = true;
        });
      }
    }
  }

  void _onOverlayIdle() {
    if (_manager.items.isEmpty && widget.initialEntries.isEmpty) {
      if (_hasActiveToasts) {
        setState(() {
          _hasActiveToasts = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!_hasActiveToasts) {
      return widget.child ?? const SizedBox.shrink();
    }

    return Stack(
      children: [
        if (widget.child != null) widget.child!,
        Positioned.fill(
          child: Overlay(
            key: widget.overlayKey,
            initialEntries: [
              ...widget.initialEntries,
              OverlayEntry(
                builder: (context) => Material(
                  type: MaterialType.transparency,
                  child: ToastOverlay(
                    manager: _manager,
                    onIdle: _onOverlayIdle,
                    messageBuilder: widget.messageBuilder,
                    loadingBuilder: widget.loadingBuilder,
                    progressBuilder: widget.progressBuilder,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<bool>('hasActiveToasts', _hasActiveToasts));
    properties.add(IntProperty('itemsCount', _manager.items.length));
  }
}
