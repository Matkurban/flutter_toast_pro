import 'package:example/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_toast_pro/flutter_toast_pro.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ToastScope(
      theme: const ToastThemeData(
        position: ToastPosition.top,
        maxVisibleToasts: 5,
        enableGlassmorphism: true,
        enableSwipeToDismiss: true,
        messageTheme: MessageToastTheme(
          margin: EdgeInsets.symmetric(horizontal: 16),
        ),
        loadingTheme: LoadingToastTheme(overlayColor: Color(0x33000000)),
      ),
      child: MaterialApp(
        title: 'Flutter Toast Pro',
        theme: AppTheme.light,
        darkTheme: AppTheme.dark,
        themeMode: ThemeMode.light,
        home: const MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Toast Pro v3')),
      body: SizedBox(
        width: double.infinity,
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            spacing: 10,
            children: [
              const Text(
                'Message Toasts',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              FilledButton(
                onPressed: () => Toast.info('这是一条信息提示'),
                child: const Text('Info 消息'),
              ),
              FilledButton(
                onPressed: () => Toast.success('操作成功'),
                child: const Text('Success 消息'),
              ),
              FilledButton(
                onPressed: () => Toast.warning('请注意！'),
                child: const Text('Warning 消息'),
              ),
              FilledButton(
                onPressed: () => Toast.error('出错了！'),
                child: const Text('Error 消息'),
              ),
              FilledButton(
                onPressed: () {
                  Toast.show(
                    '支持操作按钮的提示',
                    type: MessageType.info,
                    duration: const Duration(seconds: 5),
                    action: ToastAction(
                      label: '撤销',
                      onPressed: () => Toast.success('已撤销'),
                    ),
                  );
                },
                child: const Text('带操作按钮'),
              ),
              FilledButton(
                onPressed: () {
                  // Rapid-fire: stacking demo.
                  Toast.info('消息 1');
                  Toast.success('消息 2');
                  Toast.warning('消息 3');
                  Toast.error('消息 4');
                },
                child: const Text('堆叠显示(快速4条)'),
              ),

              const Divider(),
              const Text(
                'Bottom Position',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              FilledButton(
                onPressed: () =>
                    Toast.show('底部消息', position: ToastPosition.bottom),
                child: const Text('底部消息'),
              ),

              const Divider(),
              const Text(
                'Loading',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              FilledButton(
                onPressed: () => Toast.loading(message: '加载中...'),
                child: const Text('显示加载'),
              ),
              FilledButton(
                onPressed: () => Toast.hideLoading(),
                child: const Text('隐藏加载'),
              ),

              const Divider(),
              const Text(
                'Progress',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              FilledButton(
                onPressed: () async {
                  for (int i = 0; i <= 100; i++) {
                    await Future.delayed(const Duration(milliseconds: 20));
                    Toast.progress(i / 100, message: '下载中 $i%');
                  }
                  Toast.hideProgress();
                  Toast.success('下载完成！');
                },
                child: const Text('模拟进度'),
              ),
              FilledButton(
                onPressed: () => Toast.hideProgress(),
                child: const Text('隐藏进度'),
              ),

              const Divider(),
              FilledButton(
                onPressed: () => Toast.dismissAll(),
                child: const Text('关闭全部'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
