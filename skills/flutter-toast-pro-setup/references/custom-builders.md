# Custom builders

Exported from `package:flutter_toast_pro/flutter_toast_pro.dart`
(`export 'src/ui/toast_overlay.dart' show ToastMessageBuilder, ToastLoadingBuilder, ToastProgressBuilder`).

The `ToastOverlay` **class** is not public. Pass builders on `ToastScope`.

## Typedefs

```dart
typedef ToastMessageBuilder = Widget Function(
  BuildContext context,
  MessageToastItem item,
);

typedef ToastLoadingBuilder = Widget Function(
  BuildContext context,
  LoadingToastItem item,
);

typedef ToastProgressBuilder = Widget Function(
  BuildContext context,
  ProgressToastItem item,
);
```

| Builder on `ToastScope` | Item type | When used |
|-------------------------|-----------|-----------|
| `messageBuilder` | `MessageToastItem` | Every message toast. `null` uses the default message card. |
| `loadingBuilder` | `LoadingToastItem` | The single loading toast. `null` uses the default loading card. |
| `progressBuilder` | `ProgressToastItem` | The single progress toast. `null` uses the default progress card. |

A builder replaces the **card** only. Overlay still handles position,
stacking, enter/exit animation, message swipe/tap wrapping, and the
loading/progress barrier.

## `extra`

`FlutterToastPro.show` / `info` / `success` / `warning` / `error` /
`loading` / `progress` accept `extra` (`Map<String, dynamic>`, default
`const <String, dynamic>{}`). It is stored on the item and ignored by
default widgets. Read `item.extra` in a custom builder.

`FlutterToastPro.progress` copies `extra` from the existing item on
in-place updates; a later `extra:` argument is ignored.

## Example

```dart
ToastScope(
  messageBuilder: (context, item) {
    final accent = item.extra['accent'] as Color? ?? Colors.black87;
    return DecoratedBox(
      decoration: BoxDecoration(
        color: accent,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Text(item.message, style: const TextStyle(color: Colors.white)),
      ),
    );
  },
  loadingBuilder: (context, item) {
    return Text(item.message ?? 'Loading');
  },
  progressBuilder: (context, item) {
    return Text('${item.message ?? ''} ${(item.progress * 100).round()}%');
  },
  child: child,
);
```

Item fields available to builders are documented in
`flutter-toast-pro-toasts` → `references/toast-items.md`.
