# Flutter Toast Pro

English | [中文](README.zh-CN.md)

Overlay-based toast, loading, and progress helper for Flutter.

Requires Flutter `>=3.44.0` and depends on `material_ui` and `cupertino_ui`.

## Live demo

[https://matkurban.github.io/flutter_toast_pro/](https://matkurban.github.io/flutter_toast_pro/)

## Features

- Stackable message toasts with enter/exit animation
- Info, success, warning, and error styles
- Optional action button (`ToastAction`)
- Modal loading and in-place progress indicators
- `Future`-based message and loading APIs (complete on dismiss)
- Theming via `ToastThemeData` and custom builders
- Glassmorphism on the default loading and progress cards
- `ToastScope` mounts an overlay only while toasts are active

## Installation

```yaml
dependencies:
  flutter_toast_pro: ^4.0.2
```

```bash
flutter pub add flutter_toast_pro
```

## Quick start

### 1. Mount `ToastScope`

Put `ToastScope` inside `MaterialApp` / `CupertinoApp` `builder`. Do not wrap the app from the outside — that can break when Flutter Inspector rebuilds the tree.

```dart
import 'package:flutter_toast_pro/flutter_toast_pro.dart';
import 'package:material_ui/material_ui.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      builder: (context, child) {
        return ToastScope(child: child);
      },
      home: const MyHomePage(),
    );
  }
}
```

```dart
// Avoid: easy to break when Inspector rebuilds
ToastScope(
  child: MaterialApp(...),
)
```

### 2. Show toasts

```dart
FlutterToastPro.info('This is an info message');
FlutterToastPro.success('Saved successfully!');
FlutterToastPro.warning('Please check your input');
FlutterToastPro.error('Something went wrong');

FlutterToastPro.show(
  'Item deleted',
  type: ToastMessageType.info,
  action: ToastAction(
    label: 'Undo',
    onPressed: () => restoreItem(),
  ),
);

await FlutterToastPro.error('Connection failed');

FlutterToastPro.loading(message: 'Please wait...');
await fetchData();
FlutterToastPro.hideLoading();

for (int i = 0; i <= 100; i++) {
  FlutterToastPro.progress(i / 100, message: 'Downloading $i%');
  await Future<void>.delayed(const Duration(milliseconds: 20));
}
FlutterToastPro.hideProgress();
```

Call `FlutterToastPro` only after `ToastScope` is in the widget tree.

## Message API

| Method | Returns | Description |
|--------|---------|-------------|
| `FlutterToastPro.show(message, {type, icon, duration, position, action, swipeToDismiss, extra})` | `Future<void>` | Configurable message toast |
| `FlutterToastPro.info(message, {icon, duration, position, action, extra})` | `Future<void>` | Info toast |
| `FlutterToastPro.success(message, {icon, duration, position, action, extra})` | `Future<void>` | Success toast |
| `FlutterToastPro.warning(message, {icon, duration, position, action, extra})` | `Future<void>` | Warning toast |
| `FlutterToastPro.error(message, {icon, duration, position, action, extra})` | `Future<void>` | Error toast |
| `FlutterToastPro.dismiss(id)` | `void` | Dismiss one toast by id |
| `FlutterToastPro.dismissAll()` | `void` | Dismiss every toast |

Message futures complete when that toast is dismissed (timer, swipe/tap when enabled, or `dismiss` / `dismissAll`).

`info` / `success` / `warning` / `error` do not take `swipeToDismiss`. Only `show` does (default `true`).

### Message parameters

| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| `message` | `String` | required | Display text |
| `type` | `ToastMessageType` | `info` (`show` only) | `info` / `success` / `warning` / `error` |
| `icon` | `IconData?` | per-type default | Leading icon |
| `duration` | `Duration?` | 3 seconds | Auto-dismiss; omitted values become 3 seconds |
| `position` | `ToastPosition?` | `ToastThemeData.position` (`top`) | `top` / `center` / `bottom` |
| `action` | `ToastAction?` | `null` | Trailing button; does not dismiss by itself |
| `swipeToDismiss` | `bool` | `true` (`show` only) | Combined with `ToastThemeData.enableSwipeToDismiss` |
| `extra` | `Map<String, dynamic>` | `const {}` | Forwarded to a custom `messageBuilder` |

Swipe and tap-to-dismiss run only when `MessageToastTheme.ignorePointer` is `false` (the theme default is `true`).

## Loading and progress

| Method | Returns | Description |
|--------|---------|-------------|
| `FlutterToastPro.loading({message, position, extra})` | `Future<void>` | Show a loading indicator (`position` defaults to `center`) |
| `FlutterToastPro.hideLoading()` | `void` | Dismiss the current loading indicator |
| `FlutterToastPro.progress(value, {message, position, extra})` | `void` | Show or update progress (`0.0`–`1.0`) |
| `FlutterToastPro.hideProgress()` | `void` | Dismiss the current progress indicator |

Loading and progress are globally unique: showing another of the same type replaces the previous one.

`await FlutterToastPro.loading(...)` completes only when that loading toast is dismissed. Always pair `loading` with `hideLoading` (or `dismiss` / `dismissAll`).

After the first `progress` call, later calls update `progress` and `message` in place. Later `position` and `extra` arguments are ignored.

## Theming

```dart
MaterialApp(
  builder: (context, child) {
    return ToastScope(
      theme: ToastThemeData(
        position: ToastPosition.top,
        maxVisibleToasts: 5,
        spacing: 8,
        animationDuration: const Duration(milliseconds: 300),
        enableGlassmorphism: true,
        enableSwipeToDismiss: true,
        messageTheme: const MessageToastTheme(
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          margin: EdgeInsets.symmetric(horizontal: 16),
          borderRadius: BorderRadius.all(Radius.circular(8)),
          showIcon: true,
          ignorePointer: false,
          successForegroundColor: Color.fromRGBO(52, 199, 89, 1),
          errorForegroundColor: Color.fromRGBO(255, 59, 48, 1),
        ),
        loadingTheme: const LoadingToastTheme(
          overlayColor: Color(0x33000000),
          indicatorSize: 28,
        ),
        progressTheme: const ProgressToastTheme(
          indicatorSize: 56,
          strokeWidth: 4,
        ),
      ),
      child: child,
    );
  },
  home: const MyHomePage(),
)
```

Notes that match the current implementation:

- `ToastThemeData`, `LoadingToastTheme`, and `ProgressToastTheme` have `copyWith`. `MessageToastTheme` does not — construct a new instance.
- Message colors are `*ForegroundColor` / `*BackgroundColor` (not `successColor` / `errorColor`).
- `MessageToastTheme` has no `blurSigma`. `enableGlassmorphism` blurs default loading and progress cards only.
- `maxVisibleToasts` applies to message toasts only.
- Full-screen dimming uses `LoadingToastTheme.overlayColor` or `ProgressToastTheme.overlayColor`.

## Custom builders

```dart
MaterialApp(
  builder: (context, child) {
    return ToastScope(
      messageBuilder: (context, item) {
        return DecoratedBox(
          decoration: BoxDecoration(
            color: Colors.black87,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              item.message,
              style: const TextStyle(color: Colors.white),
            ),
          ),
        );
      },
      loadingBuilder: (context, item) => Text(item.message ?? 'Loading'),
      progressBuilder: (context, item) => Text('${item.progress}'),
      child: child,
    );
  },
  home: const MyHomePage(),
)
```

Builder signatures:

- `ToastMessageBuilder` = `Widget Function(BuildContext, MessageToastItem)`
- `ToastLoadingBuilder` = `Widget Function(BuildContext, LoadingToastItem)`
- `ToastProgressBuilder` = `Widget Function(BuildContext, ProgressToastItem)`

Read `item.extra` for data passed through the show APIs. Do not import `package:flutter_toast_pro/src/ui/...` for default widgets; they are not part of the public API. `GlassContainer` is public if you want a frosted card in a custom builder.

## AI skills

This package ships [Agent Skills](https://dart.dev/tools/pub/package-skills) for coding agents.

After adding the dependency, in your app project run:

```bash
dart run skills@ get
```

Skills:

| Skill | Use when |
|-------|----------|
| `flutter-toast-pro-setup` | Mounting `ToastScope`, theming, custom builders, `GlassContainer` |
| `flutter-toast-pro-toasts` | Showing and dismissing messages, loading, and progress |

## Migration

The public facade is still `FlutterToastPro` (not `Toast`).

Mount `ToastScope` via `MaterialApp.builder` / `CupertinoApp.builder`.

### From v2.x

| v2.x | Current |
|------|---------|
| `FlutterToastProWrapper(child: MaterialApp(...))` | `MaterialApp(builder: (c, child) => ToastScope(child: child), ...)` |
| `FlutterToastPro.showMessage('text')` | `FlutterToastPro.show('text')` |
| `FlutterToastPro.showSuccessMessage('text')` | `FlutterToastPro.success('text')` |
| `FlutterToastPro.showWaringMessage('text')` | `FlutterToastPro.warning('text')` |
| `FlutterToastPro.showErrorMessage('text')` | `FlutterToastPro.error('text')` |
| `FlutterToastPro.showLoading()` | `FlutterToastPro.loading()` |
| `FlutterToastPro.showProgress(0.5)` | `FlutterToastPro.progress(0.5)` |
| `MessageType` | `ToastMessageType` |
| `ToastUiOptions(...)` | `ToastThemeData(...)` |
| `EffectType.primary` / `primaryLight` | Removed — colors come from theme / `ColorScheme` fallbacks |
| `rxdart` | Removed in v3 |

v4 replaces Flutter SDK widget imports with `material_ui` and `cupertino_ui` (Flutter `>=3.44.0`).

## License

Apache License 2.0. See `LICENSE`.
