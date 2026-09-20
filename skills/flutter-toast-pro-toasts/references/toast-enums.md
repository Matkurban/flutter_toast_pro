# Enums

Both enums are exported from `package:flutter_toast_pro/flutter_toast_pro.dart`.

---

## `ToastMessageType`

```dart
enum ToastMessageType {
  info,
  success,
  warning,
  error,
}
```

Used by `FlutterToastPro.show` (`type:`) and `MessageToastItem.type`.
The convenience methods pin the value:

| Method | Value |
|--------|-------|
| `FlutterToastPro.info` | `ToastMessageType.info` |
| `FlutterToastPro.success` | `ToastMessageType.success` |
| `FlutterToastPro.warning` | `ToastMessageType.warning` |
| `FlutterToastPro.error` | `ToastMessageType.error` |

Default widget icon when `icon` is null:

| Value | Icon |
|-------|------|
| `info` | `Icons.info_outline_rounded` |
| `success` | `Icons.check_circle_outline_rounded` |
| `warning` | `Icons.warning_amber_rounded` |
| `error` | `Icons.error_outline_rounded` |

Colors come from `MessageToastTheme.*ForegroundColor` /
`*BackgroundColor` (see `flutter-toast-pro-setup` theme reference).

There is no `MessageType` type. Use `ToastMessageType`.

---

## `ToastPosition`

```dart
enum ToastPosition {
  top(Alignment.topCenter),
  center(Alignment.center),
  bottom(Alignment.bottomCenter);

  const ToastPosition(this.alignment);

  final Alignment alignment;
}
```

| Value | `alignment` | Overlay placement | Swipe-to-dismiss direction |
|-------|-------------|-------------------|----------------------------|
| `top` | `Alignment.topCenter` | Top `SafeArea` column (bottom inset off) | Swipe **up** |
| `center` | `Alignment.center` | Centered column (with loading/progress) | Either vertical direction |
| `bottom` | `Alignment.bottomCenter` | Bottom `SafeArea` column (top inset off), items reversed | Swipe **down** |

Message toasts without an explicit position use
`ToastThemeData.position` (default `top`) when shown through
`FlutterToastPro.show` / `info` / `success` / `warning` / `error`.

`FlutterToastPro.loading` and the first `FlutterToastPro.progress` call
default to `ToastPosition.center`. Later `progress` calls keep the
existing item's position.

Swipe is implemented by the internal `DismissibleToast` (not exported).
Threshold: drag distance > 30% of 200 logical pixels, in the allowed
direction. Swipe still requires `enableSwipeToDismiss && swipeToDismiss`
and `MessageToastTheme.ignorePointer == false`.
