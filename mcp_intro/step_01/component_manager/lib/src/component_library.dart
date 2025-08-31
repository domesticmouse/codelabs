import 'dart:io';

import 'package:checked_yaml/checked_yaml.dart';
import 'package:json_annotation/json_annotation.dart';

part 'component_library.g.dart';

/// A library of electronic components.
@JsonSerializable(anyMap: true, checked: true, disallowUnrecognizedKeys: true)
class ComponentLibrary {
  /// The list of components in the library.
  @JsonKey(required: true)
  final List<Component> components;

  /// Creates a new component library.
  ComponentLibrary({required this.components});

  /// Creates a new component library from a YAML file.
  factory ComponentLibrary.fromFile(File file) {
    final yamlContent = file.readAsStringSync();
    return ComponentLibrary.fromYaml(yamlContent, sourceUrl: file.uri);
  }

  /// Creates a new component library from a YAML string.
  factory ComponentLibrary.fromYaml(String yaml, {Uri? sourceUrl}) {
    return checkedYamlDecode(
      yaml,
      (m) => ComponentLibrary.fromJson(m!),
      sourceUrl: sourceUrl,
    );
  }

  /// Creates a new component library from a JSON map.
  factory ComponentLibrary.fromJson(Map json) =>
      _$ComponentLibraryFromJson(json);

  /// Converts the component library to a JSON map.
  Map<String, dynamic> toJson() => _$ComponentLibraryToJson(this);

  /// Searches the component library for components matching the given query.
  ///
  /// The search is case-insensitive and matches against the component's name,
  /// type, and description.
  List<Component> search(String query) {
    final lowerCaseQuery = query.toLowerCase();
    return components.where((component) {
      return component.name.toLowerCase().contains(lowerCaseQuery) ||
          component.type.toLowerCase().contains(lowerCaseQuery) ||
          component.description.toLowerCase().contains(lowerCaseQuery);
    }).toList();
  }
}

/// An electronic component.
@JsonSerializable(anyMap: true, checked: true, disallowUnrecognizedKeys: true)
class Component {
  /// The name of the component.
  @JsonKey(required: true)
  final String name;

  /// The type of the component.
  @JsonKey(required: true)
  final String type;

  /// A description of the component.
  @JsonKey(required: true)
  final String description;

  /// The pins of the component.
  final List<Pin> pins;

  /// Creates a new component.
  Component({
    required this.name,
    required this.type,
    required this.description,
    this.pins = const [],
  });

  /// Creates a new component from a JSON map.
  factory Component.fromJson(Map json) => _$ComponentFromJson(json);

  /// Converts the component to a JSON map.
  Map<String, dynamic> toJson() => _$ComponentToJson(this);
}

/// A pin on an electronic component.
@JsonSerializable(anyMap: true, checked: true, disallowUnrecognizedKeys: true)
class Pin {
  /// The pin number.
  @JsonKey(required: true)
  final int pin;

  /// The name of the pin.
  @JsonKey(required: true)
  final String name;

  /// The type of the pin.
  @JsonKey(required: true)
  final String type;

  /// A description of the pin.
  @JsonKey(required: true)
  final String description;

  /// Creates a new pin.
  Pin({
    required this.pin,
    required this.name,
    required this.type,
    required this.description,
  });

  /// Creates a new pin from a JSON map.
  factory Pin.fromJson(Map json) => _$PinFromJson(json);

  /// Converts the pin to a JSON map.
  Map<String, dynamic> toJson() => _$PinToJson(this);
}
