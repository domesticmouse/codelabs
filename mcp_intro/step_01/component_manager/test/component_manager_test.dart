import 'package:component_manager/component_manager.dart';
import 'package:test/test.dart';

void main() {
  late ComponentLibrary library;

  setUp(() {
    library = ComponentLibrary.fromFile('components.yaml');
  });

  test('parses all components', () {
    expect(library.components, hasLength(17));
  });

  test('parses component details correctly', () {
    final ne555 = library.components.firstWhere((c) => c.name == 'NE555');
    expect(ne555.type, 'Timer');
    expect(ne555.description, 'Precision Timer');
    expect(ne555.pins, hasLength(8));
  });

  test('parses pin details correctly', () {
    final lm7805 = library.components.firstWhere((c) => c.name == 'LM7805');
    final outputPin = lm7805.pins.firstWhere((p) => p.name == 'OUTPUT');
    expect(outputPin.pin, 3);
    expect(outputPin.type, 'Output');
    expect(outputPin.description, 'Output voltage (5V)');
  });

  test('parses last component in the list', () {
    final tl431 = library.components.last;
    expect(tl431.name, 'TL431');
    expect(tl431.type, 'Voltage Reference');
  });
}
