import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_toast_pro/flutter_toast_pro.dart';
import 'package:flutter_toast_pro/src/ui/toast_overlay.dart';

void main() {
  testWidgets('ToastScope does not render Overlay when idle (clean widget tree)', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        builder: (context, child) {
          return ToastScope(
            child: child,
          );
        },
        home: const Scaffold(
          body: Center(
            child: Text('App Content'),
          ),
        ),
      ),
    );

    // Verify app content is rendered
    expect(find.text('App Content'), findsOneWidget);

    // When idle (no toasts active), ToastScope should NOT render a custom Overlay or extra Stack overlay layer
    // MaterialApp creates its own inner Overlay inside Navigator, but ToastScope should not create an extra Overlay.
    final overlayFinder = find.byType(ToastOverlay);
    expect(overlayFinder, findsNothing);

    // Diagnostics tree can be safely inspected without extra overlay node blocking
    final rootElement = tester.binding.rootElement;
    expect(rootElement, isNotNull);
    final diagnostics = rootElement!.toDiagnosticsNode();
    expect(diagnostics, isNotNull);
  });

  testWidgets('ToastScope mounts Overlay when toast is shown and unmounts on dismissal', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        builder: (context, child) {
          return ToastScope(
            child: child,
          );
        },
        home: Scaffold(
          body: Center(
            child: ElevatedButton(
              onPressed: () {
                FlutterToastPro.info('Test Toast');
              },
              child: const Text('Show Toast'),
            ),
          ),
        ),
      ),
    );

    // Initially no ToastOverlay
    expect(find.byType(ToastOverlay), findsNothing);
    expect(find.text('Test Toast'), findsNothing);

    // Tap button to show toast
    await tester.tap(find.text('Show Toast'));
    await tester.pump(); // Trigger ToastScope setState

    // Now ToastOverlay should be mounted and showing the toast
    expect(find.byType(ToastOverlay), findsOneWidget);
    expect(find.text('Test Toast'), findsOneWidget);

    // Dismiss all toasts
    FlutterToastPro.dismissAll();
    await tester.pump(); // Trigger manager update & dismiss
    await tester.pump(); // Rebuild ToastScope after onIdle sets _hasActiveToasts = false

    // Overlay should be unmounted cleanly
    expect(find.byType(ToastOverlay), findsNothing);
    expect(find.text('Test Toast'), findsNothing);
  });

  testWidgets('Loading and progress toasts mount/unmount overlay correctly', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        builder: (context, child) {
          return ToastScope(
            child: child,
          );
        },
        home: const Scaffold(
          body: Text('Home'),
        ),
      ),
    );

    expect(find.byType(ToastOverlay), findsNothing);

    // Show loading
    FlutterToastPro.loading(message: 'Loading data...');
    await tester.pump();

    expect(find.byType(ToastOverlay), findsOneWidget);
    expect(find.text('Loading data...'), findsOneWidget);

    // Hide loading
    FlutterToastPro.hideLoading();
    await tester.pump();
    await tester.pump(); // Rebuild ToastScope after onIdle

    expect(find.byType(ToastOverlay), findsNothing);
  });

  testWidgets('Progress toast updates and unmounts correctly', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        builder: (context, child) => ToastScope(child: child),
        home: const Scaffold(body: Text('Progress Test')),
      ),
    );

    expect(find.byType(ToastOverlay), findsNothing);

    FlutterToastPro.progress(0.25, message: 'Downloading 25%');
    await tester.pump();
    expect(find.byType(ToastOverlay), findsOneWidget);
    expect(find.text('Downloading 25%'), findsOneWidget);

    FlutterToastPro.progress(0.75, message: 'Downloading 75%');
    await tester.pump();
    expect(find.text('Downloading 75%'), findsOneWidget);

    FlutterToastPro.hideProgress();
    await tester.pump();
    await tester.pump();
    expect(find.byType(ToastOverlay), findsNothing);
  });

  testWidgets('Custom message builder works correctly', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        builder: (context, child) {
          return ToastScope(
            messageBuilder: (context, item) => Container(
              key: const Key('custom_toast_container'),
              child: Text('Custom: ${item.message}'),
            ),
            child: child,
          );
        },
        home: const Scaffold(body: Text('Custom Builder Test')),
      ),
    );

    expect(find.byKey(const Key('custom_toast_container')), findsNothing);

    FlutterToastPro.info('Hello Custom');
    await tester.pump();

    expect(find.byKey(const Key('custom_toast_container')), findsOneWidget);
    expect(find.text('Custom: Hello Custom'), findsOneWidget);

    FlutterToastPro.dismissAll();
    await tester.pump();
    await tester.pump();

    expect(find.byKey(const Key('custom_toast_container')), findsNothing);
  });
}



