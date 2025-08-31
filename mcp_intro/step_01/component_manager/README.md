# Component Manager

A Dart package to manage electronic components. This package includes a command-line application for listing components and a library for programmatic access.

## Command-line Usage

To run the application, execute the following command:

```bash
dart run bin/component_manager.dart
```

This will read the `components.yaml` file and print the names of all components.

## Using as a Library

You can also use this package as a library in your own Dart projects.

### 1. Add the dependency

Add this to your `pubspec.yaml` file:

```yaml
dependencies:
  component_manager: ^1.0.0
```

### 2. Import and use the library

```dart
import 'package:component_manager/component_manager.dart';
import 'dart:io';

void main() {
  // Load the component library from a file
  final library = ComponentLibrary.fromFile(File('components.yaml'));

  // Search for components
  final results = library.search('regulator');

  // Print the results
  for (var component in results) {
    print('${component.name}: ${component.description}');
  }
}
```

## Project Structure

- `bin/component_manager.dart`: The entry point of the command-line application.
- `lib/component_manager.dart`: The main library file that exports the public API.
- `lib/src/component_library.dart`: Contains the data models for the component library, components, and pins.
- `components.yaml`: The YAML file containing the list of components.
- `test/component_manager_test.dart`: Contains unit tests for the application.
- `pubspec.yaml`: Defines the project's dependencies and metadata.
