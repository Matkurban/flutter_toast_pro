import 'dart:ui';

import 'package:flutter/material.dart';

/// A container with glassmorphism (frosted glass) effect.
///
/// When [enableBlur] is `false`, falls back to a simple decorated container.
class GlassContainer extends StatelessWidget {
  const GlassContainer({
    super.key,
    required this.child,
    this.enableBlur = true,
    this.blurSigma = 20.0,
    this.backgroundColor,
    this.borderRadius = const BorderRadius.all(Radius.circular(16)),
    this.padding,
    this.margin,
    this.border,
    this.elevation = 0,
    this.constraints,
  });

  final Widget child;
  final bool enableBlur;
  final double blurSigma;
  final Color? backgroundColor;
  final BorderRadiusGeometry borderRadius;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final Border? border;
  final double elevation;
  final BoxConstraints? constraints;

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    final isDark = brightness == Brightness.dark;

    final bgColor =
        backgroundColor ??
        (isDark
            ? Colors.white.withValues(alpha: 0.12)
            : Colors.white.withValues(alpha: 0.72));

    final resolvedBorder =
        border ??
        Border.all(
          color: isDark
              ? Colors.white.withValues(alpha: 0.1)
              : Colors.white.withValues(alpha: 0.5),
          width: 0.5,
        );

    Widget content = Container(
      margin: margin,
      constraints: constraints,
      decoration: BoxDecoration(
        color: enableBlur ? bgColor : bgColor.withValues(alpha: 0.95),
        borderRadius: borderRadius,
        border: resolvedBorder,
        boxShadow: elevation > 0
            ? [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.08),
                  blurRadius: elevation * 2,
                  offset: Offset(0, elevation),
                ),
              ]
            : null,
      ),
      padding: padding,
      child: child,
    );

    if (!enableBlur || blurSigma <= 0) return content;

    return ClipRRect(
      borderRadius: borderRadius.resolve(Directionality.of(context)),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: blurSigma, sigmaY: blurSigma),
        child: content,
      ),
    );
  }
}
