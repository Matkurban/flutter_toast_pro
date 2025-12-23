import 'package:flutter/material.dart';
import 'package:rxdart_flutter/rxdart_flutter.dart';

import '../model/loading_style_options.dart';
import '../model/overlay_options.dart';
import '../model/toast_data_model.dart';
import '../model/toast_type.dart';
import '../statement.dart';
import '../toast_event.dart';
import 'animated_toast_overlay.dart';
import 'default_loading_widget.dart';

/// Creates the overlay entry for loading toasts.
///
/// 创建 loading toast 的 OverlayEntry。
OverlayEntry loadingOverlayEntry({
  /// Controller for the OverlayPortal.
  ///
  /// OverlayPortal 控制器。
  required OverlayPortalController controller,

  /// Optional custom loading builder.
  ///
  /// 可选自定义 loading 构建器。
  ToastLoadingBuilder? builder,

  /// Overlay behavior options (barrier, ignoring, alignment, animation, ...).
  ///
  /// 覆盖层行为配置（遮罩、事件穿透、对齐、动画等）。
  required OverlayOptions overlay,

  /// Style options used by the built-in default loading widget.
  ///
  /// 内置默认 loading 组件使用的样式配置。
  LoadingStyleOptions styleOptions = const LoadingStyleOptions(),
}) {
  return OverlayEntry(
    builder: (BuildContext context) {
      // Full screen size used by the overlay.
      //
      // 覆盖层的全屏尺寸。
      final Size size = MediaQuery.sizeOf(context);
      return OverlayPortal(
        controller: controller,
        overlayLocation: .rootOverlay,
        overlayChildBuilder: (context) {
          return ValueStreamBuilder(
            stream: ToastEvent.showMessages,
            builder: (BuildContext context, ToastDataModel value, Widget? child) {
              // Only show when current event type matches.
              //
              // 仅当当前事件类型匹配时显示。
              final bool visible = value.type == ToastType.loading;
              if (!visible) {
                return const SizedBox.shrink();
              }

              // Resolve alignment (event overrides options).
              //
              // 解析对齐方式（事件优先于配置）。
              final Alignment alignment =
                  value.alignment ??
                  overlay.defaultAlignment ??
                  Alignment.center;

              // Build barrier + content.
              //
              // 构建遮罩 + 内容。
              Widget content = Container(
                color: overlay.overlayColor,
                width: size.width,
                height: size.height,
                child:
                    builder?.call(
                      context,
                      value.message,
                      alignment,
                      value.extra,
                    ) ??
                    DefaultLoadingWidget(
                      message: value.message,
                      alignment: alignment,
                      styleOptions: styleOptions,
                    ),
              );

              // Optional SafeArea wrapper.
              //
              // 可选 SafeArea 包裹。
              if (overlay.safeArea) {
                content = SafeArea(child: content);
              }

              // Barrier dismiss.
              //
              // 点击遮罩关闭（barrierDismissible）。
              if (overlay.barrierDismissible) {
                content = Stack(
                  children: [
                    Positioned.fill(
                      child: Semantics(
                        label: overlay.semanticsLabel,
                        child: GestureDetector(
                          behavior: HitTestBehavior.opaque,
                          onTap: () =>
                              ToastEvent.hideMessages.add(ToastType.loading),
                        ),
                      ),
                    ),
                    Positioned.fill(
                      child: IgnorePointer(
                        // When barrierDismissible is true, barrier must receive taps.
                        //
                        // 当允许点击遮罩关闭时，遮罩必须能接收点击。
                        ignoring: !overlay.ignoring,
                        child: content,
                      ),
                    ),
                  ],
                );
              } else {
                // Pointer ignoring.
                //
                // 指针事件穿透。
                content = IgnorePointer(
                  ignoring: overlay.ignoring,
                  child: content,
                );
              }

              // Tap to dismiss (content).
              //
              // 点击内容关闭（tapToDismiss）。
              if (overlay.tapToDismiss) {
                content = GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  onTap: () => ToastEvent.hideMessages.add(ToastType.loading),
                  child: content,
                );
              }

              // Enter/exit animation.
              //
              // 进入/退出动画。
              return AnimatedToastOverlay(
                visible: visible,
                options: overlay.animation,
                child: content,
              );
            },
          );
        },
      );
    },
  );
}
