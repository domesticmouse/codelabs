import 'dart:io';

import 'package:component_manager/component_manager.dart';
import 'package:test/test.dart';

void main() {
  group('ComponentLibrary', () {
    test('loads from file', () {
      final library = ComponentLibrary.fromFile(File('components.yaml'));
      expect(library.components, isNotEmpty);
    });

    test('loads from YAML string', () {
      final yaml = '''
components:
  - name: TEST-COMP
    type: Test
    description: A test component
''';
      final library = ComponentLibrary.fromYaml(yaml);
      expect(library.components, hasLength(1));
      expect(library.components.first.name, 'TEST-COMP');
    });
  });

  group('Component', () {
    test('parses component details correctly', () {
      final library = ComponentLibrary.fromFile(File('components.yaml'));
      final ne555 = library.components.firstWhere((c) => c.name == 'NE555');
      expect(ne555.type, 'Timer');
      expect(ne555.description, 'Precision Timer');
      expect(ne555.pins, hasLength(8));
    });
  });

  group('Pin', () {
    test('parses pin details correctly', () {
      final library = ComponentLibrary.fromFile(File('components.yaml'));
      final lm7805 = library.components.firstWhere((c) => c.name == 'LM7805');
      final outputPin = lm7805.pins.firstWhere((p) => p.name == 'OUTPUT');
      expect(outputPin.pin, 3);
      expect(outputPin.type, 'Output');
      expect(outputPin.description, 'Output voltage (5V)');
    });
  });
}
