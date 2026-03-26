import 'package:flutter/material.dart';

import 'toast_position.dart';

/// Top-level theme data for FlutterToastPro.
@immutable
class ToastThemeData {
  const ToastThemeData({
    this.position = ToastPosition.top,
    this.maxVisibleToasts = 5,
    this.spacing = 8.0,
    this.animationDuration = const Duration(milliseconds: 300),
    this.animationCurve = Curves.easeOutCubic,
    this.reverseAnimationDuration,
    this.reverseAnimationCurve = Curves.easeInCubic,
    this.enableGlassmorphism = true,
    this.enableSwipeToDismiss = true,
    this.messageTheme = const MessageToastTheme(),
    this.loadingTheme = const LoadingToastTheme(),
    this.progressTheme = const ProgressToastTheme(),
  });

  /// Default position for message toasts.
  final ToastPosition position;

  /// Maximum number of toasts visible simultaneously.
  final int maxVisibleToasts;

  /// Vertical spacing between stacked toasts.
  final double spacing;

  /// Duration of the enter animation.
  final Duration animationDuration;

  /// Curve of the enter animation.
  final Curve animationCurve;

  /// Duration of the exit animation (defaults to [animationDuration]).
  final Duration? reverseAnimationDuration;

  /// Curve of the exit animation.
  final Curve reverseAnimationCurve;

  /// Whether to apply glassmorphism (backdrop blur) to toast cards.
  final bool enableGlassmorphism;

  /// Whether message toasts can be swiped away.
  final bool enableSwipeToDismiss;

  /// Theme for message toasts.
  final MessageToastTheme messageTheme;

  /// Theme for loading toasts.
  final LoadingToastTheme loadingTheme;

  /// Theme for progress toasts.
  final ProgressToastTheme progressTheme;

  ToastThemeData copyWith({
    ToastPosition? position,
    int? maxVisibleToasts,
    double? spacing,
    Duration? animationDuration,
    Curve? animationCurve,
    Duration? reverseAnimationDuration,
    Curve? reverseAnimationCurve,
    bool? enableGlassmorphism,
    bool? enableSwipeToDismiss,
    MessageToastTheme? messageTheme,
    LoadingToastTheme? loadingTheme,
    ProgressToastTheme? progressTheme,
  }) {
    return ToastThemeData(
      position: position ?? this.position,
      maxVisibleToasts: maxVisibleToasts ?? this.maxVisibleToasts,
      spacing: spacing ?? this.spacing,
      animationDuration: animationDuration ?? this.animationDuration,
      animationCurve: animationCurve ?? this.animationCurve,
      reverseAnimationDuration: reverseAnimationDuration ?? this.reverseAnimationDuration,
      reverseAnimationCurve: reverseAnimationCurve ?? this.reverseAnimationCurve,
      enableGlassmorphism: enableGlassmorphism ?? this.enableGlassmorphism,
      enableSwipeToDismiss: enableSwipeToDismiss ?? this.enableSwipeToDismiss,
      messageTheme: messageTheme ?? this.messageTheme,
      loadingTheme: loadingTheme ?? this.loadingTheme,
      progressTheme: progressTheme ?? this.progressTheme,
    );
  }
}

/// Theme for message toasts.
@immutable
class MessageToastTheme {
  const MessageToastTheme({
    this.padding = const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    this.margin = const EdgeInsets.symmetric(horizontal: 16),
    this.borderRadius = const BorderRadius.all(Radius.circular(16)),
    this.blurSigma = 20.0,
    this.showIcon = true,
    this.elevation = 0,
    this.textStyle,
    this.actionTextStyle,
    this.infoColor,
    this.successColor,
    this.warningColor,
    this.errorColor,
    this.overlayColor = Colors.transparent,
    this.ignorePointer = true,
    this.barrierDismissible = false,
    this.tapToDismiss = true,
  });

  /// Inner padding of the toast card.
  final EdgeInsetsGeometry padding;

  /// Outer margin of the toast card.
  final EdgeInsetsGeometry margin;

  /// Border radius of the toast card.
  final BorderRadiusGeometry borderRadius;

  /// Sigma value for glassmorphism backdrop blur.
  final double blurSigma;

  /// Whether to show the type-specific icon.
  final bool showIcon;

  /// Elevation (shadow depth) of the toast card.
  final double elevation;

  /// Text style for the message. Color is overridden per-type.
  final TextStyle? textStyle;

  /// Text style for the action button.
  final TextStyle? actionTextStyle;

  /// Override color for info toasts.
  final Color? infoColor;

  /// Override color for success toasts.
  final Color? successColor;

  /// Override color for warning toasts.
  final Color? warningColor;

  /// Override color for error toasts.
  final Color? errorColor;

  /// Overlay background color (barrier).
  final Color overlayColor;

  /// Whether the overlay ignores pointer events.
  final bool ignorePointer;

  /// Whether tapping the barrier dismisses the toast.
  final bool barrierDismissible;

  /// Whether tapping the toast content dismisses it.
  final bool tapToDismiss;

  MessageToastTheme copyWith({
    EdgeInsetsGeometry? padding,
    EdgeInsetsGeometry? margin,
    BorderRadiusGeometry? borderRadius,
    double? blurSigma,
    bool? showIcon,
    double? elevation,
    TextStyle? textStyle,
    TextStyle? actionTextStyle,
    Color? infoColor,
    Color? successColor,
    Color? warningColor,
    Color? errorColor,
    Color? overlayColor,
    bool? ignorePointer,
    bool? barrierDismissible,
    bool? tapToDismiss,
  }) {
    return MessageToastTheme(
      padding: padding ?? this.padding,
      margin: margin ?? this.margin,
      borderRadius: borderRadius ?? this.borderRadius,
      blurSigma: blurSigma ?? this.blurSigma,
      showIcon: showIcon ?? this.showIcon,
      elevation: elevation ?? this.elevation,
      textStyle: textStyle ?? this.textStyle,
      actionTextStyle: actionTextStyle ?? this.actionTextStyle,
      infoColor: infoColor ?? this.infoColor,
      successColor: successColor ?? this.successColor,
      warningColor: warningColor ?? this.warningColor,
      errorColor: errorColor ?? this.errorColor,
      overlayColor: overlayColor ?? this.overlayColor,
      ignorePointer: ignorePointer ?? this.ignorePointer,
      barrierDismissible: barrierDismissible ?? this.barrierDismissible,
      tapToDismiss: tapToDismiss ?? this.tapToDismiss,
    );
  }
}

/// Theme for loading toasts.
@immutable
class LoadingToastTheme {
  const LoadingToastTheme({
    this.padding = const EdgeInsets.all(24),
    this.margin,
    this.borderRadius = const BorderRadius.all(Radius.circular(20)),
    this.blurSigma = 20.0,
    this.backgroundColor,
    this.indicatorSize = 28.0,
    this.indicatorColor,
    this.messageTextStyle,
    this.messageSpacing = 12.0,
    this.overlayColor = const Color(0x33000000),
    this.ignorePointer = false,
    this.barrierDismissible = false,
  });

  /// Inner padding of the loading card.
  final EdgeInsetsGeometry padding;

  /// Outer margin.
  final EdgeInsetsGeometry? margin;

  /// Border radius of the loading card.
  final BorderRadiusGeometry borderRadius;

  /// Sigma value for glassmorphism backdrop blur.
  final double blurSigma;

  /// Background color override (null uses theme-derived defaults).
  final Color? backgroundColor;

  /// Indicator radius.
  final double indicatorSize;

  /// Indicator color override.
  final Color? indicatorColor;

  /// Text style for the optional message.
  final TextStyle? messageTextStyle;

  /// Spacing between indicator and message text.
  final double messageSpacing;

  /// Overlay background color (barrier).
  final Color overlayColor;

  /// Whether the overlay ignores pointer events.
  final bool ignorePointer;

  /// Whether tapping the barrier dismisses the loading.
  final bool barrierDismissible;

  LoadingToastTheme copyWith({
    EdgeInsetsGeometry? padding,
    EdgeInsetsGeometry? margin,
    BorderRadiusGeometry? borderRadius,
    double? blurSigma,
    Color? backgroundColor,
    double? indicatorSize,
    Color? indicatorColor,
    TextStyle? messageTextStyle,
    double? messageSpacing,
    Color? overlayColor,
    bool? ignorePointer,
    bool? barrierDismissible,
  }) {
    return LoadingToastTheme(
      padding: padding ?? this.padding,
      margin: margin ?? this.margin,
      borderRadius: borderRadius ?? this.borderRadius,
      blurSigma: blurSigma ?? this.blurSigma,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      indicatorSize: indicatorSize ?? this.indicatorSize,
      indicatorColor: indicatorColor ?? this.indicatorColor,
      messageTextStyle: messageTextStyle ?? this.messageTextStyle,
      messageSpacing: messageSpacing ?? this.messageSpacing,
      overlayColor: overlayColor ?? this.overlayColor,
      ignorePointer: ignorePointer ?? this.ignorePointer,
      barrierDismissible: barrierDismissible ?? this.barrierDismissible,
    );
  }
}

/// Theme for progress toasts.
@immutable
class ProgressToastTheme {
  const ProgressToastTheme({
    this.padding = const EdgeInsets.all(24),
    this.margin,
    this.borderRadius = const BorderRadius.all(Radius.circular(20)),
    this.blurSigma = 20.0,
    this.backgroundColor,
    this.indicatorSize = 56.0,
    this.indicatorColor,
    this.indicatorBackgroundColor,
    this.strokeWidth = 4.0,
    this.messageTextStyle,
    this.overlayColor = const Color(0x33000000),
    this.ignorePointer = false,
    this.barrierDismissible = false,
  });

  /// Inner padding of the progress card.
  final EdgeInsetsGeometry padding;

  /// Outer margin.
  final EdgeInsetsGeometry? margin;

  /// Border radius.
  final BorderRadiusGeometry borderRadius;

  /// Sigma value for glassmorphism backdrop blur.
  final double blurSigma;

  /// Background color override (null uses theme-derived defaults).
  final Color? backgroundColor;

  /// Size of the progress indicator.
  final double indicatorSize;

  /// Progress indicator foreground color.
  final Color? indicatorColor;

  /// Progress indicator background color.
  final Color? indicatorBackgroundColor;

  /// Stroke width of the circular indicator.
  final double strokeWidth;

  /// Text style for the optional message.
  final TextStyle? messageTextStyle;

  /// Overlay background color (barrier).
  final Color overlayColor;

  /// Whether the overlay ignores pointer events.
  final bool ignorePointer;

  /// Whether tapping the barrier dismisses the progress.
  final bool barrierDismissible;

  ProgressToastTheme copyWith({
    EdgeInsetsGeometry? padding,
    EdgeInsetsGeometry? margin,
    BorderRadiusGeometry? borderRadius,
    double? blurSigma,
    Color? backgroundColor,
    double? indicatorSize,
    Color? indicatorColor,
    Color? indicatorBackgroundColor,
    double? strokeWidth,
    TextStyle? messageTextStyle,
    Color? overlayColor,
    bool? ignorePointer,
    bool? barrierDismissible,
  }) {
    return ProgressToastTheme(
      padding: padding ?? this.padding,
      margin: margin ?? this.margin,
      borderRadius: borderRadius ?? this.borderRadius,
      blurSigma: blurSigma ?? this.blurSigma,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      indicatorSize: indicatorSize ?? this.indicatorSize,
      indicatorColor: indicatorColor ?? this.indicatorColor,
      indicatorBackgroundColor: indicatorBackgroundColor ?? this.indicatorBackgroundColor,
      strokeWidth: strokeWidth ?? this.strokeWidth,
      messageTextStyle: messageTextStyle ?? this.messageTextStyle,
      overlayColor: overlayColor ?? this.overlayColor,
      ignorePointer: ignorePointer ?? this.ignorePointer,
      barrierDismissible: barrierDismissible ?? this.barrierDismissible,
    );
  }
}
