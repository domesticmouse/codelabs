import 'package:component_editor/screens/component_detail_screen.dart';
import 'package:component_manager/component_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final component = Component(
    name: 'Test Component',
    description: 'Test Description',
    type: 'Test Type',
    pins: [
      Pin(
        name: 'Pin 1',
        number: 1,
        type: 'Test Pin Type',
        description: 'Pin 1 Desc',
      ),
      Pin(
        name: 'Pin 2',
        number: 2,
        type: 'Test Pin Type',
        description: 'Pin 2 Desc',
      ),
    ],
  );

  testWidgets('ComponentDetailScreen shows component details', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(home: ComponentDetailScreen(component: component)),
    );

    // Check for app bar title
    expect(find.text('Test Component'), findsOneWidget);

    // Check for pin list
    expect(find.byType(ListView), findsOneWidget);
    expect(find.text('Pin 1'), findsOneWidget);
    expect(find.text('Pin 2'), findsOneWidget);
    expect(find.text('1'), findsOneWidget);
    expect(find.text('2'), findsOneWidget);
  });

  testWidgets('ComponentDetailScreen navigates to edit screen', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(home: ComponentDetailScreen(component: component)),
    );

    // Tap the edit button
    await tester.tap(find.byIcon(Icons.edit));
    await tester.pumpAndSettle();

    // Check if we navigated to the edit screen
    expect(find.text('Edit Component'), findsOneWidget);
  });
}
