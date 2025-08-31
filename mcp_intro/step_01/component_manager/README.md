# Component Manager

A Dart command-line application to manage electronic components.

This application reads a list of electronic components from a YAML file (`components.yaml`), parses it, and prints the name of each component.

## Usage

To run the application, execute the following command:

```bash
dart run bin/component_manager.dart
```

## Project Structure

- `bin/component_manager.dart`: The entry point of the application.
- `lib/src/component_library.dart`: Contains the data models for the component library, components, and pins.
- `components.yaml`: The YAML file containing the list of components.
- `test/component_manager_test.dart`: Contains unit tests for the application.
- `pubspec.yaml`: Defines the project's dependencies and metadata.