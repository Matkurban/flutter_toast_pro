# Toast items and ToastAction

Exported from `package:flutter_toast_pro/flutter_toast_pro.dart`.

`ToastItem` is `sealed`. The only subtypes are `MessageToastItem`,
`LoadingToastItem`, and `ProgressToastItem`.

Ids default to `'toast_${n}'` from a library-private incrementing
counter (`_nextId`). Passing `id` reuses that string.

---

## `ToastItem`

```dart
sealed class ToastItem {
  ToastItem({
    String? id,
    required this.position,
    this.duration,
    DateTime? createdAt,
  })  : id = id ?? _generateId(),
        createdAt = createdAt ?? DateTime.now(),
        completer = Completer<void>();

  final String id;
  final ToastPosition position;
  final Duration? duration;
  final DateTime createdAt;
  final Completer<void> completer;
}
```

| Field | Type | Notes |
|-------|------|-------|
| `id` | `String` | Unique key for dismiss and animation. |
| `position` | `ToastPosition` | Required on the base constructor. Subclasses supply defaults. |
| `duration` | `Duration?` | `null` means no auto-dismiss timer. |
| `createdAt` | `DateTime` | Defaults to `DateTime.now()`. |
| `completer` | `Completer<void>` | Completed on dismiss / replace / `dismissAll` / `clear`. New instance per constructed item. |

Do not subclass outside this library (`sealed`).

---

## `MessageToastItem`

```dart
class MessageToastItem extends ToastItem {
  MessageToastItem({
    super.id,
    required this.message,
    this.type = ToastMessageType.info,
    this.icon,
    this.action,
    super.position = ToastPosition.top,
    super.duration = const Duration(seconds: 3),
    this.swipeToDismiss = true,
    this.extra = const <String, dynamic>{},
  });

  final String message;
  final ToastMessageType type;
  final IconData? icon;
  final ToastAction? action;
  final bool swipeToDismiss;
  final Map<String, dynamic> extra;
}
```

| Field | Type | Default | Notes |
|-------|------|---------|-------|
| `message` | `String` | required | Card text. |
| `type` | `ToastMessageType` | `info` | Default widget colors and icon. |
| `icon` | `IconData?` | `null` | Default widget uses a type icon when null. |
| `action` | `ToastAction?` | `null` | Optional trailing label. |
| `position` | `ToastPosition` | `top` | `FlutterToastPro.show` overrides this with theme.position when the caller omits position. |
| `duration` | `Duration?` | `3 seconds` | `FlutterToastPro.show` also applies `duration ?? Duration(seconds: 3)`. |
| `swipeToDismiss` | `bool` | `true` | AND-ed with `ToastThemeData.enableSwipeToDismiss`. |
| `extra` | `Map<String, dynamic>` | `const {}` | Custom `messageBuilder` payload. |

`FlutterToastPro.info` / `success` / `warning` / `error` always create
items with `swipeToDismiss: true` (via `show`).

---

## `LoadingToastItem`

```dart
class LoadingToastItem extends ToastItem {
  LoadingToastItem({
    super.id,
    this.message,
    super.position = ToastPosition.center,
    this.extra = const <String, dynamic>{},
  }) : super(duration: null);

  final String? message;
  final Map<String, dynamic> extra;
}
```

`duration` is always `null` (forced in the initializer list). Showing a
new loading item removes any existing `LoadingToastItem`.

---

## `ProgressToastItem`

```dart
class ProgressToastItem extends ToastItem {
  ProgressToastItem({
    super.id,
    required this.progress,
    this.message,
    super.position = ToastPosition.center,
    this.extra = const <String, dynamic>{},
  }) : super(duration: null);

  final double progress;
  final String? message;
  final Map<String, dynamic> extra;
}
```

`duration` is always `null`. `progress` is documented as `0.0`–`1.0`;
the class does not clamp. The default widget shows
`'${(progress * 100).round()}%'`.

`ToastManager.updateProgress` builds a new instance with the same `id`,
`position`, and `extra`.

---

## `ToastAction`

```dart
@immutable
class ToastAction {
  const ToastAction({
    required this.label,
    required this.onPressed,
  });

  final String label;
  final VoidCallback onPressed;
}
```

| Field | Type | Notes |
|-------|------|-------|
| `label` | `String` | Button text. |
| `onPressed` | `VoidCallback` | Invoked on tap. Does **not** dismiss the toast. |

Used only on message toasts. The default widget wraps the label in a
`GestureDetector`. If `MessageToastTheme.ignorePointer` is `true`
(default), the action does not receive pointers.

```dart
FlutterToastPro.show(
  'Deleted',
  action: ToastAction(
    label: 'Undo',
    onPressed: restoreItem,
  ),
);
```
