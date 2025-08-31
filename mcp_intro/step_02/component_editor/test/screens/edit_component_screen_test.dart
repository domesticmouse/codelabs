import 'package:component_editor/screens/edit_component_screen.dart';
import 'package:component_manager/component_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final component = Component(
    name: 'Test Component',
    description: 'Test Description',
    type: 'Test Type',
    pins: [],
  );

  testWidgets('EditComponentScreen shows initial values', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(home: EditComponentScreen(component: component)),
    );

    expect(
      find.widgetWithText(TextFormField, 'Test Component'),
      findsOneWidget,
    );
    expect(
      find.widgetWithText(TextFormField, 'Test Description'),
      findsOneWidget,
    );
  });

  testWidgets('EditComponentScreen validation fails for empty fields', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(home: EditComponentScreen(component: component)),
    );

    // Clear the text fields
    await tester.enterText(
      find.widgetWithText(TextFormField, 'Test Component'),
      '',
    );
    await tester.enterText(
      find.widgetWithText(TextFormField, 'Test Description'),
      '',
    );

    // Tap the save button
    await tester.tap(find.text('Save'));
    await tester.pump();

    // Check for validation messages
    expect(find.text('Please enter a name'), findsOneWidget);
    expect(find.text('Please enter a description'), findsOneWidget);
  });

  testWidgets('EditComponentScreen saves and pops with new component', (
    WidgetTester tester,
  ) async {
    Component? result;
    await tester.pumpWidget(
      MaterialApp(
        home: Builder(
          builder: (context) => Scaffold(
            body: Center(
              child: ElevatedButton(
                onPressed: () async {
                  result = await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          EditComponentScreen(component: component),
                    ),
                  );
                },
                child: const Text('Go'),
              ),
            ),
          ),
        ),
      ),
    );

    // Navigate to the edit screen
    await tester.tap(find.text('Go'));
    await tester.pumpAndSettle();

    // Enter new values
    await tester.enterText(
      find.widgetWithText(TextFormField, 'Test Component'),
      'New Name',
    );
    await tester.enterText(
      find.widgetWithText(TextFormField, 'Test Description'),
      'New Description',
    );

    // Tap the save button
    await tester.tap(find.text('Save'));
    await tester.pumpAndSettle();

    // Check that we are back and the result is correct
    expect(find.text('Go'), findsOneWidget); // We are back
    expect(result, isA<Component>());
    expect(result?.name, 'New Name');
    expect(result?.description, 'New Description');
  });
}
