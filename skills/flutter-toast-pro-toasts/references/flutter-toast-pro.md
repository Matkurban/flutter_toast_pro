# FlutterToastPro

Sealed class in `lib/src/toast.dart`. No public constructor. All members
are static. Uses `ToastManager.instance` internally.

```dart
sealed class FlutterToastPro { ... }
```

---

## `attach`

```dart
static void attach(ToastManager manager)
```

Copies `manager.theme` onto `ToastManager.instance`. Called by
`ToastScope`. App code must not call this.

Returns `void`.

---

## `detach`

```dart
static void detach([ToastManager? manager])
```

No-op. The optional `manager` is ignored. Kept so DevTools / hot reload
never leave the singleton unset. Called by `ToastScope.dispose`. App
code must not call this.

Returns `void`.

---

## `show`

```dart
static Future<void> show(
  String message, {
  ToastMessageType type = ToastMessageType.info,
  IconData? icon,
  Duration? duration,
  ToastPosition? position,
  ToastAction? action,
  bool swipeToDismiss = true,
  Map<String, dynamic> extra = const <String, dynamic>{},
})
```

Creates a `MessageToastItem` and returns `ToastManager.show`, which
completes when that item is dismissed.

| Parameter | Type | Default | Notes |
|-----------|------|---------|-------|
| `message` | `String` | required | Display text. |
| `type` | `ToastMessageType` | `info` | Colors and default icon. |
| `icon` | `IconData?` | `null` | Overrides the type default icon. |
| `duration` | `Duration?` | `null` → `Duration(seconds: 3)` | Stored duration is never null for items created here. |
| `position` | `ToastPosition?` | `null` → `ToastManager.instance.theme.position` | Theme default is `ToastPosition.top`. |
| `action` | `ToastAction?` | `null` | Optional button. Does not auto-dismiss. |
| `swipeToDismiss` | `bool` | `true` | Combined with `ToastThemeData.enableSwipeToDismiss`. Blocked when `MessageToastTheme.ignorePointer` is `true`. |
| `extra` | `Map<String, dynamic>` | `const {}` | For custom `messageBuilder` only. |

---

## `info` / `success` / `warning` / `error`

```dart
static Future<void> info(
  String message, {
  IconData? icon,
  Duration? duration,
  ToastPosition? position,
  ToastAction? action,
  Map<String, dynamic> extra = const <String, dynamic>{},
})
```

`success`, `warning`, and `error` have the **same** named parameters.
Each forwards to `show` with a fixed `type`:

| Method | `type` |
|--------|--------|
| `info` | `ToastMessageType.info` |
| `success` | `ToastMessageType.success` |
| `warning` | `ToastMessageType.warning` |
| `error` | `ToastMessageType.error` |

There is **no** `swipeToDismiss` parameter. The item always gets
`show`'s default `swipeToDismiss: true`.

Returns `Future<void>` (same as `show`).

---

## `loading`

```dart
static Future<void> loading({
  String? message,
  ToastPosition position = ToastPosition.center,
  Map<String, dynamic> extra = const <String, dynamic>{},
})
```

Shows a `LoadingToastItem` (`duration: null`). Any existing loading
toast is removed and its future is completed first.

The returned future completes when this loading toast is dismissed
(`hideLoading`, `dismiss`, `dismissAll`, or replacement by a later
`loading` call).

| Parameter | Type | Default |
|-----------|------|---------|
| `message` | `String?` | `null` |
| `position` | `ToastPosition` | `ToastPosition.center` |
| `extra` | `Map<String, dynamic>` | `const {}` |

---

## `hideLoading`

```dart
static void hideLoading()
```

Dismisses the current `LoadingToastItem`, if any. No-op otherwise.
Returns `void`.

---

## `progress`

```dart
static void progress(
  double progress, {
  String? message,
  ToastPosition position = ToastPosition.center,
  Map<String, dynamic> extra = const <String, dynamic>{},
})
```

`progress` is a value in `0.0`–`1.0` (not clamped by this method).

* If a `ProgressToastItem` already exists: calls
  `ToastManager.updateProgress(progress, message: message)`. Existing
  `id`, `position`, and `extra` are kept. The `position` and `extra`
  arguments on this call are ignored. `message: null` keeps the old
  message (`message ?? old.message` inside `updateProgress`).
* Otherwise: shows a new `ProgressToastItem` with the given
  `progress`, `message`, `position`, and `extra`.

Returns `void`. Do not `await` this method.

---

## `hideProgress`

```dart
static void hideProgress()
```

Dismisses the current `ProgressToastItem`, if any. No-op otherwise.
Returns `void`.

---

## `dismiss`

```dart
static void dismiss(String id)
```

Dismisses the item whose `id` matches. No-op if missing. Completes that
item's completer and notifies listeners. Returns `void`.

Message items created through `FlutterToastPro` get ids like `toast_0`.
Those ids are not returned by `show` / `info` / … App code that needs a
known id should construct a `MessageToastItem(id: ...)` and call
`ToastManager.instance.show`.

---

## `dismissAll`

```dart
static void dismissAll()
```

Completes every active item's completer, clears items and timers,
notifies listeners. Returns `void`.
