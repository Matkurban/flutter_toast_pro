# ToastManager

`ChangeNotifier` in `lib/src/toast_manager.dart`. Fully exported.
Process-wide singleton. The UI (`ToastScope`) listens to it.

Prefer `FlutterToastPro` from app code. Use this type when you need
`items`, a custom `id`, or in-place `updateProgress`.

---

## Constructors and singleton

```dart
static final ToastManager instance = ToastManager._internal();

factory ToastManager({ToastThemeData theme = const ToastThemeData()}) {
  instance.theme = theme;
  return instance;
}
```

The factory always returns `instance` and overwrites `instance.theme`.
The private generative constructor is `ToastManager._internal()`.

Do not construct a second manager. There is only one list of toasts.

---

## Fields

| Member | Type | Notes |
|--------|------|-------|
| `theme` | `ToastThemeData` | Mutable. `ToastScope` writes this in `initState` / `didUpdateWidget`. `FlutterToastPro.attach` also assigns `manager.theme`. Default `const ToastThemeData()`. |
| `items` | `List<ToastItem>` getter | `List.unmodifiable(_items)`. Newest last. |

Private: `_items`, `_timers` (`Map<String, Timer>` keyed by toast id).

---

## `show`

```dart
Future<void> show(ToastItem item)
```

1. If `item` is `LoadingToastItem`, remove every existing
   `LoadingToastItem` (cancel timer, complete its completer).
2. If `item` is `ProgressToastItem`, same for existing progress items.
3. Append `item`.
4. If `item` is `MessageToastItem`, dismiss oldest messages until
   `theme.maxVisibleToasts` is met.
5. If `item.duration != null`, start a `Timer` that calls
   `dismiss(item.id)`.
6. `notifyListeners()`.
7. Return `item.completer.future`.

---

## `dismiss`

```dart
void dismiss(String id)
```

If no item has `id`, returns immediately. Otherwise removes it, cancels
its timer, completes its completer if needed, and notifies listeners.

---

## `dismissAll`

```dart
void dismissAll()
```

Completes all completers, clears `_items` and `_timers` (cancelling
timers), then `notifyListeners()`.

---

## `dismissLoading`

```dart
void dismissLoading()
```

Finds the first `LoadingToastItem` and `dismiss`es its `id`. No-op if
none.

---

## `dismissProgress`

```dart
void dismissProgress()
```

Finds the first `ProgressToastItem` and `dismiss`es its `id`. No-op if
none.

---

## `updateProgress`

```dart
void updateProgress(double progress, {String? message})
```

If no `ProgressToastItem` exists, returns. Otherwise replaces it with a
**new** `ProgressToastItem` that keeps `id`, `position`, and `extra`,
sets `progress`, and sets `message` to `message ?? old.message`.

Each `ToastItem` constructs a new `Completer`. The replacement's
completer is **not** the original. The new completer's future is
immediately `.ignore()`'d. A `Future` from the first `show()` will
**not** complete when this replacement is later dismissed (dismiss
completes the **current** item's completer).

`FlutterToastPro.progress` returns `void` and does not expose that
future. Use `hideProgress()` to close the indicator.

Then `notifyListeners()`.

---

## `clear`

```dart
void clear()
```

Cancels timers, completes completers, clears `_items` and `_timers`.
Does **not** call `notifyListeners()`. Overlay / `ToastScope` will not
rebuild from this call alone. Use `dismissAll()` from UI code.

Does not dispose the singleton.

---

## `dispose`

```dart
@override
void dispose()
```

Calls `clear()` then `super.dispose()`. Disposing `ToastManager.instance`
breaks later `ToastScope` / `FlutterToastPro` use. Do not dispose the
singleton.

---

## Private helpers (not part of the public API)

* `_removeSingletonType<T>()` — used by `show` for loading/progress.
* `_enforceMaxVisible()` — message-only cap.
* `_cancelTimer(String id)` — cancel and remove one timer.
