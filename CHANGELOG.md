## 3.1.2

- fix bugs

## 3.1.1

- fix bugs

## 3.1.0

- add `initialEntries` parameter
- add `overlayKey` parameter

## 3.1.0

- update default color

## 3.0.2

-- MessageType --> ToastMessageType

## 3.0.1

### 🐛 Bug Fixes

* Fixed `Unsupported operation: removeAt` crash when stacking more toasts than `maxVisibleToasts`. The internal `_enforceMaxVisible` was calling `removeAt` on an unmodifiable list.
* Fixed message toast visual: replaced `BackdropFilter` glassmorphism with Material 3 tonal card styling (opaque tinted background + shadow) for reliable contrast on any background.

## 3.0.0

### ⚠️ Breaking Changes

* **Complete API redesign** — `FlutterToastPro` → `Toast`, `FlutterToastProWrapper` → `ToastScope`
* **Removed rxdart dependency** — zero external dependencies, pure Flutter + Dart
* **Removed `EffectType`** — replaced by Material 3 `ColorScheme` auto-adaptation
* **Removed old options classes** — `ToastUiOptions`, `ToastMessageOptions`, `OverlayOptions`, etc. replaced by unified `ToastThemeData`

### ✨ New Features

* **Stackable toasts** — multiple message toasts displayed simultaneously with smooth stacking animations
* **Glassmorphism** — frosted glass (backdrop blur) styling, toggle via `enableGlassmorphism`
* **Swipe to dismiss** — swipe up/down to close message toasts, toggle via `enableSwipeToDismiss`
* **Future-based API** — all `Toast.show/success/warning/error/loading` return `Future<void>` that completes on dismiss
* **Action buttons** — attach `ToastAction(label, onPressed)` to any message toast (e.g. "Undo")
* **Per-toast positioning** — `ToastPosition.top`, `.center`, `.bottom` per call
* **Material 3 design** — auto light/dark theme adaptation via `Theme.of(context).colorScheme`
* **Default icons** — type-specific icons (info, check, warning, error) shown by default
* **Custom builders** — `ToastMessageBuilder`, `ToastLoadingBuilder`, `ToastProgressBuilder`
* **In-place progress updates** — calling `Toast.progress()` repeatedly updates smoothly without flicker

### 🗑️ Removed

* `rxdart` and `rxdart_flutter` dependencies
* `FlutterToastPro` sealed class (replaced by `Toast`)
* `FlutterToastProWrapper` (replaced by `ToastScope`)
* `FlutterToastProDefaults`
* `EffectType`, `ToastType` enums
* `ToastEvent` global event bus
* All old option classes: `ToastUiOptions`, `ToastMessageOptions`, `ToastLoadingOptions`, `ToastProgressOptions`, `OverlayOptions`, `ToastAnimationOptions`, `MessageStyleOptions`, `LoadingStyleOptions`, `ProgressStyleOptions`

## 2.2.0

* Add new features and improvements to the toast system, including enhanced customization options and improved performance

## 2.1.1

* fix bug

## 2.1.0

* Add support for more properties

## 2.0.0

* Enhance toast system with new loading and progress options, and improve message type definitions

## 1.2.0

* Add more customization options for default styles

## 1.0.2

* Customizable overlay colors and event handling to enhance Toast

## 1.0.1

* Fix the error that MessageType is not exported

## 1.0.0

* release 1.0.0 version
