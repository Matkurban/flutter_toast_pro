# Flutter Toast Pro

[English](README.md) | 中文

基于 Overlay 的 Flutter 消息、加载与进度提示。

要求 Flutter `>=3.44.0`，依赖 `material_ui` 与 `cupertino_ui`。

## 特性

- 可堆叠的消息 Toast，带进出场动画
- info / success / warning / error 四种样式
- 可选操作按钮（`ToastAction`）
- 模态加载与可原地更新的进度指示
- 消息与 loading 为 `Future` API（关闭时 complete）
- 通过 `ToastThemeData` 与自定义 builder 主题化
- 默认 loading / progress 卡片支持毛玻璃
- 无 Toast 时 `ToastScope` 不挂 Overlay

## 安装

```yaml
dependencies:
  flutter_toast_pro: ^4.0.2
```

```bash
flutter pub add flutter_toast_pro
```

## 快速开始

### 1. 挂载 `ToastScope`

将 `ToastScope` 放在 `MaterialApp` / `CupertinoApp` 的 `builder` 里。不要包在应用外层——Flutter Inspector 重建时容易出问题。

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
// 避免：Inspector 重建时容易出问题
ToastScope(
  child: MaterialApp(...),
)
```

### 2. 显示 Toast

```dart
FlutterToastPro.info('这是一条信息提示');
FlutterToastPro.success('保存成功');
FlutterToastPro.warning('请检查输入');
FlutterToastPro.error('出错了');

FlutterToastPro.show(
  '已删除',
  type: ToastMessageType.info,
  action: ToastAction(
    label: '撤销',
    onPressed: () => restoreItem(),
  ),
);

await FlutterToastPro.error('连接失败');

FlutterToastPro.loading(message: '请稍候...');
await fetchData();
FlutterToastPro.hideLoading();

for (int i = 0; i <= 100; i++) {
  FlutterToastPro.progress(i / 100, message: '下载中 $i%');
  await Future<void>.delayed(const Duration(milliseconds: 20));
}
FlutterToastPro.hideProgress();
```

必须先把 `ToastScope` 挂到树上，再调用 `FlutterToastPro`。

## 消息 API

| 方法 | 返回值 | 说明 |
|------|--------|------|
| `FlutterToastPro.show(message, {type, icon, duration, position, action, swipeToDismiss, extra})` | `Future<void>` | 可配置的消息 Toast |
| `FlutterToastPro.info(message, {icon, duration, position, action, extra})` | `Future<void>` | 信息 |
| `FlutterToastPro.success(message, {icon, duration, position, action, extra})` | `Future<void>` | 成功 |
| `FlutterToastPro.warning(message, {icon, duration, position, action, extra})` | `Future<void>` | 警告 |
| `FlutterToastPro.error(message, {icon, duration, position, action, extra})` | `Future<void>` | 错误 |
| `FlutterToastPro.dismiss(id)` | `void` | 按 id 关闭一条 |
| `FlutterToastPro.dismissAll()` | `void` | 关闭全部 |

消息的 `Future` 在该 Toast 关闭时完成（计时器、启用后的滑动/点击，或 `dismiss` / `dismissAll`）。

`info` / `success` / `warning` / `error` **没有** `swipeToDismiss` 参数。只有 `show` 有（默认 `true`）。

### 消息参数

| 参数 | 类型 | 默认值 | 说明 |
|------|------|--------|------|
| `message` | `String` | 必填 | 显示文本 |
| `type` | `ToastMessageType` | `info`（仅 `show`） | `info` / `success` / `warning` / `error` |
| `icon` | `IconData?` | 按类型默认图标 | 左侧图标 |
| `duration` | `Duration?` | 3 秒 | 自动关闭；省略时按 3 秒处理 |
| `position` | `ToastPosition?` | `ToastThemeData.position`（`top`） | `top` / `center` / `bottom` |
| `action` | `ToastAction?` | `null` | 尾部按钮；点击不会自动关闭 |
| `swipeToDismiss` | `bool` | `true`（仅 `show`） | 与 `ToastThemeData.enableSwipeToDismiss` 同时生效 |
| `extra` | `Map<String, dynamic>` | `const {}` | 传给自定义 `messageBuilder` |

滑动关闭和点击关闭只有在 `MessageToastTheme.ignorePointer` 为 `false` 时才会生效（主题默认是 `true`）。

## 加载与进度

| 方法 | 返回值 | 说明 |
|------|--------|------|
| `FlutterToastPro.loading({message, position, extra})` | `Future<void>` | 显示加载（`position` 默认 `center`） |
| `FlutterToastPro.hideLoading()` | `void` | 关闭当前加载 |
| `FlutterToastPro.progress(value, {message, position, extra})` | `void` | 显示或更新进度（`0.0`–`1.0`） |
| `FlutterToastPro.hideProgress()` | `void` | 关闭当前进度 |

加载和进度全局唯一：再显示同类型会替换上一条。

`await FlutterToastPro.loading(...)` 只会在该 loading 被关闭后结束。务必与 `hideLoading`（或 `dismiss` / `dismissAll`）成对使用。

第一次 `progress` 之后，后续调用只原地更新 `progress` 和 `message`，忽略本次传入的 `position` 和 `extra`。

## 主题

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

与当前实现一致的要点：

- `ToastThemeData`、`LoadingToastTheme`、`ProgressToastTheme` 有 `copyWith`。`MessageToastTheme` 没有，需要新建实例。
- 消息颜色字段是 `*ForegroundColor` / `*BackgroundColor`，没有 `successColor` / `errorColor`。
- `MessageToastTheme` 没有 `blurSigma`。`enableGlassmorphism` 只对默认 loading / progress 卡片做毛玻璃。
- `maxVisibleToasts` 只限制消息 Toast。
- 全屏遮罩颜色来自 `LoadingToastTheme.overlayColor` 或 `ProgressToastTheme.overlayColor`。

## 自定义 Builder

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
      loadingBuilder: (context, item) => Text(item.message ?? '加载中'),
      progressBuilder: (context, item) => Text('${item.progress}'),
      child: child,
    );
  },
  home: const MyHomePage(),
)
```

签名：

- `ToastMessageBuilder` = `Widget Function(BuildContext, MessageToastItem)`
- `ToastLoadingBuilder` = `Widget Function(BuildContext, LoadingToastItem)`
- `ToastProgressBuilder` = `Widget Function(BuildContext, ProgressToastItem)`

通过 `item.extra` 读取 show API 传入的附加数据。不要 import `package:flutter_toast_pro/src/ui/...` 使用默认控件，它们不是公开 API。自定义卡片需要毛玻璃时可以使用公开的 `GlassContainer`。

## AI skills

本包随附 [Agent Skills](https://dart.dev/tools/pub/package-skills)，供编码 agent 使用。

在应用项目中加入依赖后执行：

```bash
dart run skills@ get
```

| Skill | 适用场景 |
|-------|----------|
| `flutter-toast-pro-setup` | 挂载 `ToastScope`、主题、自定义 builder、`GlassContainer` |
| `flutter-toast-pro-toasts` | 显示与关闭消息、加载、进度 |

## 迁移

公开入口类仍是 `FlutterToastPro`（不是 `Toast`）。

通过 `MaterialApp.builder` / `CupertinoApp.builder` 挂载 `ToastScope`。

### 从 v2.x

| v2.x | 当前 |
|------|------|
| `FlutterToastProWrapper(child: MaterialApp(...))` | `MaterialApp(builder: (c, child) => ToastScope(child: child), ...)` |
| `FlutterToastPro.showMessage('text')` | `FlutterToastPro.show('text')` |
| `FlutterToastPro.showSuccessMessage('text')` | `FlutterToastPro.success('text')` |
| `FlutterToastPro.showWaringMessage('text')` | `FlutterToastPro.warning('text')` |
| `FlutterToastPro.showErrorMessage('text')` | `FlutterToastPro.error('text')` |
| `FlutterToastPro.showLoading()` | `FlutterToastPro.loading()` |
| `FlutterToastPro.showProgress(0.5)` | `FlutterToastPro.progress(0.5)` |
| `MessageType` | `ToastMessageType` |
| `ToastUiOptions(...)` | `ToastThemeData(...)` |
| `EffectType.primary` / `primaryLight` | 已移除，颜色来自主题 / `ColorScheme` 回退值 |
| `rxdart` | v3 已移除 |

v4 将 Flutter SDK 控件 import 替换为 `material_ui` 与 `cupertino_ui`（Flutter `>=3.44.0`）。

## 许可证

Apache License 2.0，见 `LICENSE`。
