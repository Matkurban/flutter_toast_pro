import 'package:flutter/material.dart';
import 'package:flutter_toast_pro/src/model/toast_type.dart';
import 'package:rxdart_flutter/rxdart_flutter.dart';

import '../model/effect_type.dart';
import '../model/message_style_options.dart';
import '../model/overlay_options.dart';
import '../model/toast_data_model.dart';
import '../statement.dart';
import '../toast_event.dart';
import 'animated_toast_overlay.dart';
import 'default_message_widget.dart';

/// Creates the overlay entry for message toasts.
///
/// 创建 message toast 的 OverlayEntry。
OverlayEntry messageOverlayEntry({
  /// Controller for the OverlayPortal.
  ///
  /// OverlayPortal 控制器。
  required OverlayPortalController controller,

  /// Optional custom message builder.
  ///
  /// 可选自定义 message 构建器。
  ToastMessageBuilder? builder,

  /// Overlay behavior options (barrier, ignoring, alignment, animation, ...).
  ///
  /// 覆盖层行为配置（遮罩、事件穿透、对齐、动画等）。
  required OverlayOptions overlay,

  /// Default effect type for message.
  ///
  /// message 默认效果类型。
  required EffectType effectType,

  /// Style options for the built-in default message widget.
  ///
  /// 内置默认 message 组件的样式配置。
  required MessageStyleOptions styleOptions,
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
              final bool visible =
                  value.type == ToastType.message && value.message != null;
              if (!visible) {
                return const SizedBox.shrink();
              }

              // Resolve alignment (event overrides options).
              //
              // 解析对齐方式（事件优先于配置）。
              final Alignment alignment =
                  value.alignment ??
                  overlay.defaultAlignment ??
                  Alignment.topCenter;

              // Behavior toggles.
              //
              // 行为开关。
              final bool barrierDismissible = overlay.barrierDismissible;
              final bool tapToDismiss = overlay.tapToDismiss;

              // Build barrier + content.
              //
              // 构建遮罩 + 内容。
              Widget content = Container(
                width: size.width,
                height: size.height,
                color: overlay.overlayColor,
                child: (overlay.safeArea)
                    ? SafeArea(
                        child:
                            builder?.call(
                              context,
                              value.message ?? "",
                              value.messageType,
                              value.effectType ?? effectType,
                              alignment,
                              value.extra,
                            ) ??
                            DefaultMessageWidget(
                              message: value.message ?? "",
                              type: value.messageType,
                              effectType: value.effectType ?? effectType,
                              alignment: alignment,
                              styleOptions: styleOptions,
                            ),
                      )
                    : (builder?.call(
                            context,
                            value.message ?? "",
                            value.messageType,
                            value.effectType ?? effectType,
                            alignment,
                            value.extra,
                          ) ??
                          DefaultMessageWidget(
                            message: value.message ?? "",
                            type: value.messageType,
                            effectType: value.effectType ?? effectType,
                            alignment: alignment,
                            styleOptions: styleOptions,
                          )),
              );

              // Barrier dismiss.
              //
              // 点击遮罩关闭（barrierDismissible）。
              if (barrierDismissible) {
                content = Stack(
                  children: [
                    Positioned.fill(
                      child: Semantics(
                        label: overlay.semanticsLabel,
                        child: GestureDetector(
                          behavior: HitTestBehavior.opaque,
                          onTap: () =>
                              ToastEvent.hideMessages.add(ToastType.message),
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
              if (tapToDismiss) {
                content = GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  onTap: () => ToastEvent.hideMessages.add(ToastType.message),
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
