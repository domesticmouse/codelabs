import 'dart:io';

import 'package:checked_yaml/checked_yaml.dart';
import 'package:component_manager/component_manager.dart';

void main(List<String> arguments) {
  final file = File('components.yaml');
  final yamlContent = file.readAsStringSync();
  final library = checkedYamlDecode(
    yamlContent,
    (m) => ComponentLibrary.fromJson(m!),
    sourceUrl: file.uri,
  );

  for (var component in library.components) {
    print(component.name);
  }
}
