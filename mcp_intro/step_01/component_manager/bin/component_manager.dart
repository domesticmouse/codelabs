import 'package:component_manager/component_manager.dart';

void main(List<String> arguments) {
  final library = ComponentLibrary.fromFile('components.yaml');

  for (var component in library.components) {
    print(component.name);
  }
}
