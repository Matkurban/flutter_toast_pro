import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_toast_pro/flutter_toast_pro.dart';
import 'package:flutter_toast_pro/src/ui/toast_loading_widget.dart';
import 'package:material_ui/material_ui.dart';

class _HidesOnDispose extends StatefulWidget {
  const _HidesOnDispose();

  @override
  State<_HidesOnDispose> createState() => _HidesOnDisposeState();
}

class _HidesOnDisposeState extends State<_HidesOnDispose> {
  @override
  void dispose() {
    FlutterToastPro.hideLoading();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => const Text('page');
}

void main() {
  testWidgets('在组件 dispose 中 hideLoading 不会在帧内 setState', (tester) async {
    final show = ValueNotifier<bool>(true);
    await tester.pumpWidget(
      MaterialApp(
        builder: (context, child) => ToastScope(child: child),
        home: Scaffold(
          body: ValueListenableBuilder<bool>(
            valueListenable: show,
            builder: (_, visible, _) => visible ? const _HidesOnDispose() : const SizedBox(),
          ),
        ),
      ),
    );
    FlutterToastPro.loading(message: 'loading');
    await tester.pump(const Duration(milliseconds: 500));
    expect(find.byType(DefaultLoadingWidget), findsOneWidget);

    show.value = false; // 触发 dispose -> hideLoading（发生在帧内）
    await tester.pump();
    expect(tester.takeException(), isNull);
    await tester.pumpAndSettle();
    expect(find.byType(DefaultLoadingWidget), findsNothing);
  });
}
