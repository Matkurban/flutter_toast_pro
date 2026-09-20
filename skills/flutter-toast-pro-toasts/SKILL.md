---
name: flutter-toast-pro-toasts
description: >-
  Show and dismiss FlutterToastPro message, loading, and progress toasts.
  Use when calling FlutterToastPro.show, info, success, warning, error,
  loading, hideLoading, progress, hideProgress, dismiss, or dismissAll,
  or when using ToastAction, ToastPosition, ToastMessageType, ToastItem,
  or ToastManager.
---

# flutter_toast_pro toasts

Requires `ToastScope` in the tree (see `flutter-toast-pro-setup`).
Import `package:flutter_toast_pro/flutter_toast_pro.dart`.
The public facade is `FlutterToastPro`, not `Toast`.

## Guidelines

* Use `FlutterToastPro` static methods from app code. Prefer them over
  constructing items and calling `ToastManager` directly.
* `show`, `info`, `success`, `warning`, `error`, and `loading` return
  `Future<void>` that completes when that toast is dismissed.
* `progress`, `hideLoading`, `hideProgress`, `dismiss`, and `dismissAll`
  return `void`.
* `await FlutterToastPro.loading(...)` does not finish until
  `hideLoading()`, `dismiss(id)`, or `dismissAll()`. Pair every `loading`
  with a hide/dismiss.
* `info` / `success` / `warning` / `error` have no `swipeToDismiss`
  parameter. Only `show` does (default `true`).
* Message duration defaults to 3 seconds when omitted. Loading and
  progress have `duration: null` and stay until dismissed.
* Loading and progress are globally unique: showing another of the same
  type dismisses the previous one and completes its future.
* `progress` after the first call updates value and message in place.
  Later `position` and `extra` arguments are ignored.
* `maxVisibleToasts` drops the oldest **message** toasts only.
* Do not call `FlutterToastPro.attach` / `detach` from app code. Do not
  `dispose()` `ToastManager.instance`. Use `dismissAll()`, not `clear()`,
  when the UI must rebuild.
* `ToastAction.onPressed` does not dismiss the toast by itself.

## Examples

```dart
import 'package:flutter_toast_pro/flutter_toast_pro.dart';

void demoMessages() {
  FlutterToastPro.info('This is info');
  FlutterToastPro.success('Saved');
  FlutterToastPro.warning('Check input');
  FlutterToastPro.error('Failed');
}

Future<void> demoAction() {
  return FlutterToastPro.show(
    'Item deleted',
    type: ToastMessageType.info,
    duration: const Duration(seconds: 5),
    action: ToastAction(
      label: 'Undo',
      onPressed: () => FlutterToastPro.success('Restored'),
    ),
  );
}

Future<void> demoAwait() async {
  await FlutterToastPro.error('Connection failed');
}

Future<void> demoLoading() async {
  FlutterToastPro.loading(message: 'Please wait...');
  try {
    await fetchData();
  } finally {
    FlutterToastPro.hideLoading();
  }
}

Future<void> demoProgress() async {
  for (var i = 0; i <= 100; i++) {
    FlutterToastPro.progress(i / 100, message: 'Downloading $i%');
    await Future<void>.delayed(const Duration(milliseconds: 20));
  }
  FlutterToastPro.hideProgress();
  FlutterToastPro.success('Done');
}

void demoDismiss() {
  FlutterToastPro.dismissAll();
}
```

## References

* [FlutterToastPro](references/flutter-toast-pro.md)
* [ToastManager](references/toast-manager.md)
* [ToastItem types and ToastAction](references/toast-items.md)
* [ToastMessageType and ToastPosition](references/toast-enums.md)
