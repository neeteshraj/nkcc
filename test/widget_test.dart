import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:support/main.dart';

class TestRouteManager {
  static Future<String> getInitialRoute() async {
    return '/';
  }
}

void main() {
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    final initialRoute = await TestRouteManager.getInitialRoute();

    await tester.pumpWidget(MyApp(initialRoute: initialRoute));

    expect(find.text('Home Screen'), findsOneWidget);

    expect(find.text('0'), findsOneWidget);
    expect(find.text('1'), findsNothing);

    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();

    expect(find.text('0'), findsNothing);
    expect(find.text('1'), findsOneWidget);
  });
}
