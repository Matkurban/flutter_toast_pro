# ToastScope

Public widget from `package:flutter_toast_pro/flutter_toast_pro.dart`
(`export 'src/toast_scope.dart' show ToastScope`). `_ToastScopeState` is
private. `ToastOverlay` is not exported.

Enables the toast system for the subtree. Uses the process-wide
`ToastManager.instance`.

## Constructor

```dart
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
```

| Parameter | Type | Default | Role |
|-----------|------|---------|------|
| `key` | `Key?` | `null` | Widget key. |
| `overlayKey` | `Key?` | `null` | Key of the `Overlay` created while toasts are active. |
| `child` | `Widget?` | `null` | App content under the toast overlay. |
| `theme` | `ToastThemeData` | `const ToastThemeData()` | Theme copied onto `ToastManager.instance` in `initState` and when the widget updates. |
| `messageBuilder` | `ToastMessageBuilder?` | `null` | Replaces the default message widget. |
| `loadingBuilder` | `ToastLoadingBuilder?` | `null` | Replaces the default loading widget. |
| `progressBuilder` | `ToastProgressBuilder?` | `null` | Replaces the default progress widget. |
| `initialEntries` | `List<OverlayEntry>` | `const <OverlayEntry>[]` | Extra overlay entries inserted before the toast `OverlayEntry`. If non-empty, the overlay mounts even when no toasts are showing. |

## Fields

All constructor parameters are stored as public final fields with the same names.

## Methods

### `createState`

Returns `_ToastScopeState`. Callers do not invoke this.

### `debugFillProperties`

Adds `theme` and `initialEntries` to Flutter DevTools diagnostics. The state
object also reports `hasActiveToasts` and `itemsCount`.

## Lifecycle (what the state does)

1. `initState`: sets `ToastManager.instance.theme = widget.theme`, adds a
   listener, calls `FlutterToastPro.attach(_manager)` (copies theme onto the
   singleton). Sets `_hasActiveToasts` if items or `initialEntries` are
   already present.
2. `didUpdateWidget`: if `theme` identity changes, writes the new theme onto
   the singleton.
3. `reassemble` (hot reload): calls `FlutterToastPro.attach` again.
4. `dispose`: removes the listener, then `FlutterToastPro.detach` (no-op).
5. On first active toast (or non-empty `initialEntries`): `setState` mounts a
   `Stack` + `Overlay` + toast layer.
6. When the overlay reports idle (`manager.items` empty and `initialEntries`
   empty): unmounts the `Overlay`.

## Build output

* Idle: `widget.child ?? const SizedBox.shrink()`.
* Active: `Stack` of optional `child` plus a `Positioned.fill` `Overlay`.
  The toast layer is a transparent `Material` wrapping the internal
  overlay widget. Builders on `ToastScope` are forwarded there.

## Mounting rule

```dart
// Required
MaterialApp(
  builder: (context, child) => ToastScope(child: child),
  home: const Home(),
);

// Also valid
CupertinoApp(
  builder: (context, child) => ToastScope(child: child),
  home: const Home(),
);
```

Do not wrap `MaterialApp` / `CupertinoApp` from the outside.
