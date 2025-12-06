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
    return FlutterToastProWrapper(
      effectType: EffectType.primaryLight,
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: AppTheme.light,
        darkTheme: AppTheme.dark,
        themeMode: ThemeMode.light,
        home: const MyHomePage(),
        /* builder: (context, child) {
          return FlutterToastProWrapper(child: child ?? SizedBox.shrink());
        },*/
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
    var size = MediaQuery.sizeOf(context);
    debugPrint("Home Build");
    return Scaffold(
      appBar: AppBar(title: Text("Toast")),
      body: SizedBox(
        width: size.width,
        child: Column(
          crossAxisAlignment: .center,
          spacing: 10,
          children: [
            FilledButton(
              onPressed: () {
                FlutterToastPro.showMessage("显示info消息");
              },
              child: Text("显示info消息"),
            ),

            FilledButton(
              onPressed: () {
                FlutterToastPro.showWaringMessage("显示Warning消息");
              },
              child: Text("显示Warning消息"),
            ),

            FilledButton(
              onPressed: () {
                FlutterToastPro.showSuccessMessage("显示Success消息");
              },
              child: Text("显示Success消息"),
            ),
            FilledButton(
              onPressed: () {
                FlutterToastPro.showErrorMessage("显示Error消息");
              },
              child: Text("显示Error消息"),
            ),

            FilledButton(
              onPressed: () {
                FlutterToastPro.showLoading(message: "加载中...");
              },
              child: Text("显示加载中"),
            ),
            FilledButton(
              onPressed: () {
                FlutterToastPro.hideLoading();
              },
              child: Text("隐藏加载中"),
            ),
            FilledButton(
              onPressed: () async {
                for (int i = 0; i <= 100; i++) {
                  await Future.delayed(Duration(milliseconds: 10));
                  FlutterToastPro.showProgress(i / 100, message: "$i%");
                }
                FlutterToastPro.hideProgress();
              },
              child: Text("显示进度"),
            ),
            FilledButton(
              onPressed: () {
                FlutterToastPro.hideProgress();
              },
              child: Text("隐藏进度"),
            ),
          ],
        ),
      ),
    );
  }
}
