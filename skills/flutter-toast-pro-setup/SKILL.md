---
name: flutter-toast-pro-setup
description: >-
  Mount ToastScope, configure ToastThemeData and message/loading/progress
  themes, replace toast UI with custom builders, or use GlassContainer.
  Use when adding flutter_toast_pro, wrapping MaterialApp/CupertinoApp,
  theming toasts, enabling swipe-to-dismiss, or writing messageBuilder /
  loadingBuilder / progressBuilder.
---

# flutter_toast_pro setup

Import `package:flutter_toast_pro/flutter_toast_pro.dart`. App widgets in this
package use `package:material_ui/material_ui.dart` (Flutter >= 3.44). The
package is not dependency-free: it depends on `material_ui` and `cupertino_ui`.

For showing and dismissing toasts, also load `flutter-toast-pro-toasts`.

## Guidelines

* Mount `ToastScope` inside `MaterialApp.builder` or `CupertinoApp.builder`.
  Wrapping the app from the outside breaks when Flutter Inspector rebuilds.
* Call `FlutterToastPro.*` only after `ToastScope` is in the tree.
* When idle (no toasts and no `initialEntries`), `ToastScope` does not mount
  an `Overlay`. A null `child` then renders `SizedBox.shrink()`.
* Copy themes with `ToastThemeData.copyWith`, `LoadingToastTheme.copyWith`,
  or `ProgressToastTheme.copyWith`. `MessageToastTheme` has no `copyWith` —
  construct a new instance.
* Replace default UI only through `messageBuilder`, `loadingBuilder`, and
  `progressBuilder`. Do not import `package:flutter_toast_pro/src/ui/...`.
* `ToastThemeData.enableGlassmorphism` blurs loading and progress cards only.
  The default message widget does not apply backdrop blur.
* Message swipe and tap-to-dismiss run only when
  `MessageToastTheme.ignorePointer` is `false` (default is `true`). Swipe
  also requires `enableSwipeToDismiss && item.swipeToDismiss`.
* Full-screen dimming uses `LoadingToastTheme.overlayColor` or
  `ProgressToastTheme.overlayColor`. `MessageToastTheme.barrierColor` and
  `barrierDismissible` are not read by the default overlay.
* `maxVisibleToasts` applies to message toasts only.

## Mount ToastScope

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

## Theme and builders

```dart
MaterialApp(
  builder: (context, child) {
    return ToastScope(
      theme: const ToastThemeData(
        position: ToastPosition.top,
        maxVisibleToasts: 5,
        enableGlassmorphism: true,
        enableSwipeToDismiss: true,
        messageTheme: MessageToastTheme(
          ignorePointer: false,
          tapToDismiss: true,
          successForegroundColor: Color(0xFF16A34A),
          errorForegroundColor: Color(0xFFEF4444),
        ),
        loadingTheme: LoadingToastTheme(overlayColor: Color(0x33000000)),
      ),
      messageBuilder: (context, item) {
        return Text(item.message);
      },
      child: child,
    );
  },
  home: const MyHomePage(),
);
```

## References

Read these before changing constructor arguments or theme fields:

* [ToastScope](references/toast-scope.md)
* [ToastThemeData and sub-themes](references/toast-theme.md)
* [Custom builders](references/custom-builders.md)
* [GlassContainer](references/glass-container.md)
