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
      autoClose: true,
      loadingIgnoring: false,
      messageIgnoring: true,
      progressIgnoring: false,
      loadingOverlayColor: Colors.red.withValues(alpha: 0.1),
      progressOverlayColor: Colors.amber.withValues(alpha: 0.1),
      messageOverlayColor: Colors.blueAccent.withValues(alpha: 0.1),
      messageBuilder: (context, message, type, alignment, extra) {
        return Container(
          alignment: alignment,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            decoration: BoxDecoration(color: Colors.blue),
            child: Text(message),
          ),
        );
      },
      closeDuration: Duration(seconds: 5),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(colorScheme: .fromSeed(seedColor: Colors.deepPurple)),
        home: const MyHomePage(title: 'Flutter Demo Home Page'),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.sizeOf(context);
    debugPrint("Home Build");
    return Scaffold(
      appBar: AppBar(title: Text("Flutter Toast Demo")),
      body: SizedBox(
        width: size.width,
        child: Column(
          crossAxisAlignment: .center,
          spacing: 10,
          children: [
            FilledButton(
              onPressed: () {
                FlutterToastPro.showMessage("Info");
              },
              child: Text("显示info消息"),
            ),
            FilledButton(
              onPressed: () {
                FlutterToastPro.showWaringMessage("Warning");
              },
              child: Text("显示Warning消息"),
            ),

            FilledButton(
              onPressed: () {
                FlutterToastPro.showSuccessMessage("Success");
              },
              child: Text("显示Success消息"),
            ),
            FilledButton(
              onPressed: () {
                FlutterToastPro.showErrorMessage("Error");
              },
              child: Text("显示Error消息"),
            ),

            FilledButton(
              onPressed: () {
                FlutterToastPro.showLoading();
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
                  FlutterToastPro.showProgress(i / 100);
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
