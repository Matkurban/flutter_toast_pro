# flutter_toast

一个基于 `OverlayPortal` 的轻量级 Toast / Loading / Progress 解决方案。通过一个 `FlutterToastProWrapper` 包裹根部 Widget，即可在任意位置调用静态方法触发消息，无需上下文传递，默认 UI 简洁同时支持完全自定义 Builder。

## ✨ 功能亮点
- 同时支持普通消息、加载遮罩、进度提示三大类型
- 提供 info/success/warning/error 四种语义色彩并可自定义对齐、时长、扩展数据
- 通过 `FlutterToastProWrapper` 注入，纯静态调用，不侵入业务控件树
- 自带默认样式，亦可按需传入 `messageBuilder` / `loadingBuilder` / `progressBuilder`
- 基于 `rxdart` 的事件总线，天然适配多页面/多 Navigator 场景

## 📦 安装
在 `pubspec.yaml` 中加入依赖，或直接运行 `flutter pub add flutter_toast`：

```yaml
dependencies:
	flutter_toast_pro: ^lasted
```

## 🚀 快速开始
1. 使用 `FlutterToastProWrapper` 包裹 `MaterialApp`（或任意根 Widget）。
2. 在任意地方调用 `FlutterToast` 静态方法。

```dart
class MyApp extends StatelessWidget {
	const MyApp({super.key});

	@override
	Widget build(BuildContext context) {
		return FlutterToastProWrapper(
			autoClose: true,
			closeDuration: const Duration(seconds: 3),
			child: MaterialApp(
				title: 'Flutter Toast Demo',
				home: const HomePage(),
			),
		);
	}
}

class HomePage extends StatelessWidget {
	const HomePage({super.key});

	@override
	Widget build(BuildContext context) {
		return Scaffold(
			body: Center(
				child: FilledButton(
					onPressed: () => FlutterToast.showSuccessMessage('保存成功'),
					child: const Text('显示 Toast'),
				),
			),
		);
	}
}
```

## 🔔 消息 API

| 方法                                                              | 默认类型               | 主要参数                                                     | 说明                     |
|-----------------------------------------------------------------|--------------------|----------------------------------------------------------|------------------------|
| `FlutterToast.showMessage`                                      | `MessageType.info` | `message`, `closeDuration`, `type`, `alignment`, `extra` | 最基础的文本吐司，可自定义语义类型与关闭时间 |
| `showSuccessMessage` / `showWaringMessage` / `showErrorMessage` | 对应语义               | 同上                                                       | 语法糖，内置成功/警告/错误色彩       |
| `hideMessage()`                                                 | –                  | –                                                        | 手动关闭当前消息（会同时取消定时器）     |

> `alignment` 决定消息锚点（默认 `Alignment.topCenter`），`extra` 可携带自定义数据供 `messageBuilder` 使用。

### 自动关闭
- `FlutterToastProWrapper.autoClose`：是否开启消息自动消失（默认开启，仅对 `ToastType.message` 生效）。
- `FlutterToastProWrapper.closeDuration`：默认倒计时时长，可在 `showMessage` 级别覆盖。

## ⏳ 加载与进度

| 方法                                                                                                                       | 用途                                   |
|--------------------------------------------------------------------------------------------------------------------------|--------------------------------------|
| `FlutterToast.showLoading({String? message, AlignmentGeometry alignment, Map<String, dynamic> extra})`                   | 展示 loading 遮罩，可附带文案                  |
| `FlutterToast.hideLoading()`                                                                                             | 隐藏 loading                           |
| `FlutterToast.showProgress(double progress, {String? message, AlignmentGeometry alignment, Map<String, dynamic> extra})` | 展示 determinate 进度，`progress` 0.0~1.0 |
| `FlutterToast.hideProgress()`                                                                                            | 隐藏进度弹层                               |

默认 UI 会在屏幕中心显示模态遮罩，你可以像消息一样完全替换为自定义组件。

## 🎨 自定义 UI

`FlutterToastProWrapper` 暴露了三个 builder：

```dart
FlutterToastProWrapper(
	messageBuilder: (
		BuildContext context,
		String message,
		MessageType type,
		AlignmentGeometry alignment,
		Map<String, dynamic> extra,
	) {
		return Align(
			alignment: alignment,
			child: DecoratedBox(
				decoration: BoxDecoration(
					color: Colors.black.withOpacity(0.7),
					borderRadius: BorderRadius.circular(12),
				),
				child: Padding(
					padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
					child: Text(message, style: const TextStyle(color: Colors.white)),
				),
			),
		);
	},
	loadingBuilder: (context, message, alignment, extra) => CustomLoading(message: message),
	progressBuilder: (context, progress, message, alignment, extra) => CustomProgress(value: progress),
	child: MaterialApp(...),
);
```

- `alignment`：Wrapper 会铺满整个屏幕，Builder 只需按照给定对齐返回需要展示的 Widget。
- `extra`：在业务侧传入自定义数据（如图标、回调 ID），在 Builder 中解析实现完全个性化的 UI。

## 📚 示例
完整示例位于 `example/lib/main.dart`，涵盖：
- info / success / warning / error 消息
- loading 的显示/隐藏
- 带进度的循环展示
- 自定义消息样式

直接运行：

```bash
cd example
flutter run
```

## 🧪 开发与测试

```bash
flutter pub get
flutter test
```

## 📄 License

本项目基于 `LICENSE` 文件所述条款发布。
