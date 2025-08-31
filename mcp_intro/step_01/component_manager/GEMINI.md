# Idiomatic Dart Libraries

This document outlines best practices for creating idiomatic Dart libraries, covering project structure, naming conventions, API design, versioning, and documentation.

## Project Structure

A well-organized package structure is crucial for clarity and maintainability.

- **`lib` directory:** Contains all the public code of your library.
- **`lib/src` directory:** Contains internal implementation details that should not be directly imported by consumers.
- **Main library file:** A file directly under `lib` with the same name as your package (e.g., `lib/my_package.dart`). This file should export all the public APIs of your library.
- **`test` directory:** Contains all your library's tests. Test files should end with `_test.dart`.
- **`example` directory:** Contains example usage of your library.
- **`bin` directory:** Contains any command-line tools included in your package.
- **`pubspec.yaml`:** Defines the package's name, version, dependencies, and other metadata.

## Naming Conventions

Consistent naming makes your code more readable and easier to understand.

- **Packages, directories, and source files:** Use `lowercase_with_underscores` (e.g., `my_package`, `utils`, `http_client.dart`).
- **Classes, enums, typedefs, and extensions:** Use `UpperCamelCase` (e.g., `MyClass`, `Status`, `JsonTransformer`).
- **Methods, functions, variables, and parameters:** Use `lowerCamelCase` (e.g., `myMethod`, `userName`, `itemCount`).
- **Constants:** Prefer `lowerCamelCase` for constant names.
- **Private members:** Prefix the name of a class, function, or variable with an underscore (`_`) to make it private to its library.

## API Design

A well-designed API is intuitive and easy to use.

- **Create small, focused libraries:** Break down your code into smaller, individual libraries (often one class per file).
- **Export public APIs:** Use the `export` directive in your main library file to expose the public parts of your library.
- **Hide implementation details:** Keep your internal logic in the `lib/src` directory and don't export those files from your main library file.
- **Avoid the `part` directive:** The modern convention is to create smaller, individual libraries instead of using the `part` directive.

## Versioning

Proper versioning is essential for managing changes and ensuring that your library can be used reliably.

- **Semantic Versioning:** Dart packages use semantic versioning (`major.minor.patch`).
  - **MAJOR** version for incompatible API changes.
  - **MINOR** version for adding functionality in a backward-compatible manner.
  - **PATCH** version for backward-compatible bug fixes.
- **Caret Syntax:** When specifying dependencies in `pubspec.yaml`, use the caret (`^`) syntax (e.g., `http: ^1.1.0`) to allow compatible newer versions.

## Documentation

Good documentation is as important as good code.

- **Use `///` for doc comments:** Write documentation comments for all your public APIs.
- **Write a library-level doc comment:** Add a doc comment at the top of your main library file to provide an overview of the library.
- **Provide a `README.md` file:** Give a high-level overview of your package, how to install it, and a simple usage example.
- **Maintain a `CHANGELOG.md` file:** Keep a log of changes for each new version of your package.
