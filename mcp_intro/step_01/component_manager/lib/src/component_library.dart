import 'dart:io';

import 'package:checked_yaml/checked_yaml.dart';
import 'package:json_annotation/json_annotation.dart';

part 'component_library.g.dart';

@JsonSerializable(anyMap: true, checked: true, disallowUnrecognizedKeys: true)
class ComponentLibrary {
  @JsonKey(required: true)
  final List<Component> components;

  ComponentLibrary({required this.components});

  factory ComponentLibrary.fromFile(File file) {
    final yamlContent = file.readAsStringSync();
    return ComponentLibrary.fromYaml(yamlContent, sourceUrl: file.uri);
  }

  factory ComponentLibrary.fromYaml(String yaml, {Uri? sourceUrl}) {
    return checkedYamlDecode(
      yaml,
      (m) => ComponentLibrary.fromJson(m!),
      sourceUrl: sourceUrl,
    );
  }

  factory ComponentLibrary.fromJson(Map json) =>
      _$ComponentLibraryFromJson(json);

  Map<String, dynamic> toJson() => _$ComponentLibraryToJson(this);
}

@JsonSerializable(anyMap: true, checked: true, disallowUnrecognizedKeys: true)
class Component {
  @JsonKey(required: true)
  final String name;

  @JsonKey(required: true)
  final String type;

  @JsonKey(required: true)
  final String description;

  final List<Pin> pins;

  Component({
    required this.name,
    required this.type,
    required this.description,
    this.pins = const [],
  });

  factory Component.fromJson(Map json) => _$ComponentFromJson(json);

  Map<String, dynamic> toJson() => _$ComponentToJson(this);
}

@JsonSerializable(anyMap: true, checked: true, disallowUnrecognizedKeys: true)
class Pin {
  @JsonKey(required: true)
  final int pin;

  @JsonKey(required: true)
  final String name;

  @JsonKey(required: true)
  final String type;

  @JsonKey(required: true)
  final String description;

  Pin({
    required this.pin,
    required this.name,
    required this.type,
    required this.description,
  });

  factory Pin.fromJson(Map json) => _$PinFromJson(json);

  Map<String, dynamic> toJson() => _$PinToJson(this);
}
