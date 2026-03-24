# Flutter Toast Pro

> A high-performance, beautiful toast / loading / progress plugin for Flutter — with **zero external dependencies**, glassmorphism styling, stackable messages, and swipe-to-dismiss.

> 高性能、精美的 Flutter 消息提示插件 — **零外部依赖**，毛玻璃效果，消息堆叠，滑动关闭。

## ✨ Features 特性

- 🎯 **Zero dependencies** — pure Flutter, no rxdart or third-party packages
- 🧊 **Glassmorphism** — frosted glass effect with `BackdropFilter`, toggleable
- 📚 **Stackable toasts** — multiple messages displayed simultaneously with smooth animations
- 👆 **Swipe to dismiss** — swipe up/down to close message toasts
- 🎨 **Material 3** — auto-adapts to light/dark theme via `ColorScheme`
- ⏱️ **Future-based API** — `await Toast.success('Done')` resolves when toast is dismissed
- 🔧 **Fully customizable** — theme everything or provide your own builders
- 🏷️ **Action buttons** — attach "Undo"-style actions to any toast
- 📍 **Flexible positioning** — top, center, or bottom per-toast

## 📦 Installation 安装

```yaml
dependencies:
  flutter_toast_pro: ^3.0.0
```

```bash
flutter pub add flutter_toast_pro
```

## 🚀 Quick Start 快速开始

### 1. Wrap your app 包裹应用

```dart
import 'package:flutter_toast_pro/flutter_toast_pro.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ToastScope(
      child: MaterialApp(
        home: MyHomePage(),
      ),
    );
  }
}
```

### 2. Show toasts anywhere 随处调用

```dart
// Basic messages
Toast.info('This is an info message');
Toast.success('Saved successfully!');
Toast.warning('Please check your input');
Toast.error('Something went wrong');

// With action button
Toast.show(
  'Item deleted',
  type: MessageType.info,
  action: ToastAction(
    label: 'Undo',
    onPressed: () => restoreItem(),
  ),
);

// Await dismissal
await Toast.error('Connection failed');
print('User dismissed the error toast');

// Loading
Toast.loading(message: 'Please wait...');
await fetchData();
Toast.hideLoading();

// Progress
for (int i = 0; i <= 100; i++) {
  Toast.progress(i / 100, message: 'Downloading $i%');
  await Future.delayed(Duration(milliseconds: 20));
}
Toast.hideProgress();
```

## 🔔 Message API 消息接口

| Method | Type | Description |
|--------|------|-------------|
| `Toast.show(message, {type, icon, duration, position, action})` | Configurable | General-purpose toast 通用消息 |
| `Toast.info(message)` | Info | Informational toast 信息提示 |
| `Toast.success(message)` | Success | Success toast 成功提示 |
| `Toast.warning(message)` | Warning | Warning toast 警告提示 |
| `Toast.error(message)` | Error | Error toast 错误提示 |
| `Toast.dismiss(id)` | — | Dismiss a specific toast 关闭指定消息 |
| `Toast.dismissAll()` | — | Dismiss all toasts 关闭全部消息 |

All message methods return `Future<void>` that completes when the toast is dismissed.

所有消息方法返回 `Future<void>`，在 toast 被关闭时完成。

### Parameters 参数

| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| `message` | `String` | required | Display text 显示文本 |
| `type` | `MessageType` | `info` | Severity (info/success/warning/error) 类型 |
| `icon` | `IconData?` | per-type default | Custom icon 自定义图标 |
| `duration` | `Duration?` | 3 seconds | Auto-dismiss duration 自动关闭时长 |
| `position` | `ToastPosition?` | theme default | top / center / bottom 位置 |
| `action` | `ToastAction?` | null | Action button 操作按钮 |
| `swipeToDismiss` | `bool` | true | Enable swipe gesture 启用滑动关闭 |

## ⏳ Loading & Progress 加载与进度

| Method | Description |
|--------|-------------|
| `Toast.loading({message})` | Show modal loading indicator 显示加载指示器 |
| `Toast.hideLoading()` | Dismiss loading 隐藏加载 |
| `Toast.progress(value, {message})` | Show/update progress (0.0–1.0) 显示/更新进度 |
| `Toast.hideProgress()` | Dismiss progress 隐藏进度 |

Loading and progress are **globally unique** — showing a new one replaces the previous.

加载和进度是**全局唯一**的 — 显示新的会替换之前的。

## 🎨 Theming 主题配置

```dart
ToastScope(
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
  child: MaterialApp(...),
)
```

## 🛠 Custom Builders 自定义构建器

Replace any default widget with your own:

使用自定义 Builder 完全替换默认 UI：

```dart
ToastScope(
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
  child: MaterialApp(...),
)
```

## 🔄 Migration from v2.x 从 v2.x 迁移

| v2.x | v3.0 |
|------|------|
| `FlutterToastProWrapper(child: ...)` | `ToastScope(child: ...)` |
| `FlutterToastPro.showMessage('text')` | `Toast.show('text')` |
| `FlutterToastPro.showSuccessMessage('text')` | `Toast.success('text')` |
| `FlutterToastPro.showWaringMessage('text')` | `Toast.warning('text')` |
| `FlutterToastPro.showErrorMessage('text')` | `Toast.error('text')` |
| `FlutterToastPro.showLoading()` | `Toast.loading()` |
| `FlutterToastPro.hideLoading()` | `Toast.hideLoading()` |
| `FlutterToastPro.showProgress(0.5)` | `Toast.progress(0.5)` |
| `FlutterToastPro.hideProgress()` | `Toast.hideProgress()` |
| `ToastUiOptions(...)` | `ToastThemeData(...)` |
| `EffectType.primary / primaryLight` | Removed — uses Material 3 ColorScheme |
| `rxdart` dependency | Removed — zero dependencies |


## 📄 License 许可证
Released under the terms described in `LICENSE`.
遵循 `LICENSE` 文件中的开源许可。
