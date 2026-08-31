import 'package:assignment/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('shows the dashboard on launch', (tester) async {
    await tester.pumpWidget(const MyApp());
    expect(find.text('Good Morning'), findsOneWidget);
    expect(find.text('Prabhat'), findsOneWidget);
    expect(find.text('Search Location'), findsOneWidget);
  });

  testWidgets('filters dashboard hotels by location search', (tester) async {
    await tester.pumpWidget(const MyApp());

    await tester.enterText(find.byType(TextField), 'Vancouver');
    await tester.pump();

    expect(find.text('Vancouver, Canada'), findsOneWidget);
    expect(find.text('Toronto, Canada'), findsNothing);
  });
}
