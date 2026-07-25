# Flutter Toast Pro

> A high-performance, beautiful toast / loading / progress plugin for Flutter — with **zero external dependencies**, glassmorphism styling, stackable messages, and swipe-to-dismiss.

> 高性能、精美的 Flutter 消息提示插件 — **零外部依赖**，毛玻璃效果，消息堆叠，滑动关闭。

## ✨ Features 特性

- 🎯 **Zero dependencies** — pure Flutter, no rxdart or third-party packages
- 🧊 **Glassmorphism** — frosted glass effect with `BackdropFilter`, toggleable
- 📚 **Stackable toasts** — multiple messages displayed simultaneously with smooth animations
- 👆 **Swipe to dismiss** — swipe up/down to close message toasts
- 🎨 **Material 3** — auto-adapts to light/dark theme via `ColorScheme`
- ⏱️ **Future-based API** — `await FlutterToastPro.success('Done')` resolves when toast is dismissed
- 🔧 **Fully customizable** — theme everything or provide your own builders
- 🏷️ **Action buttons** — attach "Undo"-style actions to any toast
- 📍 **Flexible positioning** — top, center, or bottom per-toast

## 📦 Installation 安装

```yaml
dependencies:
  flutter_toast_pro: ^3.1.3
```

```bash
flutter pub add flutter_toast_pro
```

## 🚀 Quick Start 快速开始

### 1. Wrap your app 包裹应用

Mount `ToastScope` inside `MaterialApp` / `CupertinoApp` `builder`. Do **not** wrap the app from the outside — that can break when Flutter Inspector rebuilds the tree.

将 `ToastScope` 挂在 `MaterialApp` / `CupertinoApp` 的 `builder` 里。**不要**包在外层 — Inspector 重建时容易出问题。

```dart
import 'package:flutter_toast_pro/flutter_toast_pro.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // ✅ Recommended
    return MaterialApp(
      builder: (context, child) {
        return ToastScope(
          child: child,
        );
      },
      home: const MyHomePage(),
    );
  }
}
```

```dart
// ❌ Easy to break when Inspector rebuilds
ToastScope(
  child: MaterialApp(...),
)
```

### 2. Show toasts anywhere 随处调用

```dart
// Basic messages
FlutterToastPro.info('This is an info message');
FlutterToastPro.success('Saved successfully!');
FlutterToastPro.warning('Please check your input');
FlutterToastPro.error('Something went wrong');

// With action button
FlutterToastPro.show(
  'Item deleted',
  type: ToastMessageType.info,
  action: ToastAction(
    label: 'Undo',
    onPressed: () => restoreItem(),
  ),
);

// Await dismissal
await FlutterToastPro.error('Connection failed');
print('User dismissed the error toast');

// Loading
FlutterToastPro.loading(message: 'Please wait...');
await fetchData();
FlutterToastPro.hideLoading();

// Progress
for (int i = 0; i <= 100; i++) {
  FlutterToastPro.progress(i / 100, message: 'Downloading $i%');
  await Future.delayed(Duration(milliseconds: 20));
}
FlutterToastPro.hideProgress();
```

## 🔔 Message API 消息接口

| Method | Type | Description |
|--------|------|-------------|
| `FlutterToastPro.show(message, {type, icon, duration, position, action})` | Configurable | General-purpose toast 通用消息 |
| `FlutterToastPro.info(message)` | Info | Informational toast 信息提示 |
| `FlutterToastPro.success(message)` | Success | Success toast 成功提示 |
| `FlutterToastPro.warning(message)` | Warning | Warning toast 警告提示 |
| `FlutterToastPro.error(message)` | Error | Error toast 错误提示 |
| `FlutterToastPro.dismiss(id)` | — | Dismiss a specific toast 关闭指定消息 |
| `FlutterToastPro.dismissAll()` | — | Dismiss all toasts 关闭全部消息 |

All message methods return `Future<void>` that completes when the toast is dismissed.

所有消息方法返回 `Future<void>`，在 toast 被关闭时完成。

### Parameters 参数

| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| `message` | `String` | required | Display text 显示文本 |
| `type` | `ToastMessageType` | `info` | Severity (info/success/warning/error) 类型 |
| `icon` | `IconData?` | per-type default | Custom icon 自定义图标 |
| `duration` | `Duration?` | 3 seconds | Auto-dismiss duration 自动关闭时长 |
| `position` | `ToastPosition?` | theme default | top / center / bottom 位置 |
| `action` | `ToastAction?` | null | Action button 操作按钮 |
| `swipeToDismiss` | `bool` | true | Enable swipe gesture 启用滑动关闭 |

## ⏳ Loading & Progress 加载与进度

| Method | Description |
|--------|-------------|
| `FlutterToastPro.loading({message})` | Show modal loading indicator 显示加载指示器 |
| `FlutterToastPro.hideLoading()` | Dismiss loading 隐藏加载 |
| `FlutterToastPro.progress(value, {message})` | Show/update progress (0.0–1.0) 显示/更新进度 |
| `FlutterToastPro.hideProgress()` | Dismiss progress 隐藏进度 |

Loading and progress are **globally unique** — showing a new one replaces the previous.

加载和进度是**全局唯一**的 — 显示新的会替换之前的。

## 🎨 Theming 主题配置

```dart
MaterialApp(
  builder: (context, child) {
    return ToastScope(
      theme: ToastThemeData(
        position: ToastPosition.top,
        maxVisibleToasts: 5,
        spacing: 8,
        animationDuration: Duration(milliseconds: 300),
        enableGlassmorphism: true,    // frosted glass effect
        enableSwipeToDismiss: true,   // swipe to close
        messageTheme: MessageToastTheme(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          margin: EdgeInsets.symmetric(horizontal: 16),
          borderRadius: BorderRadius.circular(16),
          blurSigma: 20,
          showIcon: true,
          elevation: 0,
          // Override colors per-type:
          successColor: Color(0xFF16A34A),
          errorColor: Color(0xFFEF4444),
        ),
        loadingTheme: LoadingToastTheme(
          overlayColor: Color(0x33000000),
          indicatorSize: 28,
        ),
        progressTheme: ProgressToastTheme(
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

## 🛠 Custom Builders 自定义构建器

Replace any default widget with your own:

使用自定义 Builder 完全替换默认 UI：

```dart
MaterialApp(
  builder: (context, child) {
    return ToastScope(
      messageBuilder: (context, item) {
        return Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.black87,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(item.message, style: TextStyle(color: Colors.white)),
        );
      },
      loadingBuilder: (context, item) => MyCustomLoading(message: item.message),
      progressBuilder: (context, item) => MyCustomProgress(value: item.progress),
      child: child,
    );
  },
  home: const MyHomePage(),
)
```

## 🔄 Migration from v2.x 从 v2.x 迁移

Mount `ToastScope` via `MaterialApp.builder` — do not wrap `MaterialApp` from the outside.

请通过 `MaterialApp.builder` 挂载 `ToastScope`，不要外层包裹。

| v2.x | v3.x |
|------|------|
| `FlutterToastProWrapper(child: MaterialApp(...))` | `MaterialApp(builder: (c, child) => ToastScope(child: child), ...)` |
| `FlutterToastPro.showMessage('text')` | `FlutterToastPro.show('text')` |
| `FlutterToastPro.showSuccessMessage('text')` | `FlutterToastPro.success('text')` |
| `FlutterToastPro.showWaringMessage('text')` | `FlutterToastPro.warning('text')` |
| `FlutterToastPro.showErrorMessage('text')` | `FlutterToastPro.error('text')` |
| `FlutterToastPro.showLoading()` | `FlutterToastPro.loading()` |
| `FlutterToastPro.hideLoading()` | `FlutterToastPro.hideLoading()` |
| `FlutterToastPro.showProgress(0.5)` | `FlutterToastPro.progress(0.5)` |
| `FlutterToastPro.hideProgress()` | `FlutterToastPro.hideProgress()` |
| `MessageType` | `ToastMessageType` |
| `ToastUiOptions(...)` | `ToastThemeData(...)` |
| `EffectType.primary / primaryLight` | Removed — uses Material 3 ColorScheme |
| `rxdart` dependency | Removed — zero dependencies |


## 📄 License 许可证
Released under the terms described in `LICENSE`.
遵循 `LICENSE` 文件中的开源许可。
