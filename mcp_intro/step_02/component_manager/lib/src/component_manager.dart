import 'dart:io';

import 'package:component_manager/src/component_library.dart';

/// Manages parsing of components from a YAML string.
class ComponentManager {
  /// Parses a YAML string and returns a library of components.
  ComponentLibrary parseComponents(String yamlString) {
    return ComponentLibrary.fromYaml(yamlString);
  }

  /// Parses contents of a file and returns a library of components.
  ComponentLibrary parseFile(File file) {
    return ComponentLibrary.fromFile(file);
  }
}
