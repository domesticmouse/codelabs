import 'package:component_manager/component_manager.dart';

class TestComponentLibrary extends ComponentLibrary {
  TestComponentLibrary(List<Component> components)
    : super(components: components);

  factory TestComponentLibrary.withSingleComponent() {
    return TestComponentLibrary([
      Component(
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
        ],
      ),
    ]);
  }
}
