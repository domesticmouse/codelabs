import 'package:component_editor/screens/component_list_screen.dart';
import 'package:component_manager/component_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'test_component_library.dart';

void main() {
  testWidgets('ComponentListScreen shows loading indicator and then list', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        home: ComponentListScreen(
          componentLibrary: TestComponentLibrary.withSingleComponent(),
        ),
      ),
    );

    // Wait for the component library to load
    await tester.pumpAndSettle();

    // After loading, the list should be displayed
    expect(find.byType(ListView), findsOneWidget);
    expect(find.text('Test Component'), findsOneWidget);
  });

  testWidgets('ComponentListScreen filters components based on search query', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        home: ComponentListScreen(
          componentLibrary: TestComponentLibrary([
            Component(
              name: 'Component 1',
              description: 'Description 1',
              type: 'Type 1',
            ),
            Component(
              name: 'Component 2',
              description: 'Description 2',
              type: 'Type 2',
            ),
          ]),
        ),
      ),
    );
    await tester.pumpAndSettle();

    // Enter a search query
    await tester.enterText(find.byType(TextField), 'Component 1');
    await tester.pump();

    // The list should be filtered
    final listFinder = find.byKey(const Key('component_list'));
    expect(
      find.descendant(of: listFinder, matching: find.text('Component 1')),
      findsOneWidget,
    );
    expect(
      find.descendant(of: listFinder, matching: find.text('Component 2')),
      findsNothing,
    );
  });
}
