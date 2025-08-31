// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'component_library.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ComponentLibrary _$ComponentLibraryFromJson(Map json) =>
    $checkedCreate('ComponentLibrary', json, ($checkedConvert) {
      $checkKeys(
        json,
        allowedKeys: const ['components'],
        requiredKeys: const ['components'],
      );
      final val = ComponentLibrary(
        components: $checkedConvert(
          'components',
          (v) => (v as List<dynamic>)
              .map((e) => Component.fromJson(e as Map))
              .toList(),
        ),
      );
      return val;
    });

Map<String, dynamic> _$ComponentLibraryToJson(ComponentLibrary instance) =>
    <String, dynamic>{'components': instance.components};

Component _$ComponentFromJson(Map json) => $checkedCreate('Component', json, (
  $checkedConvert,
) {
  $checkKeys(
    json,
    allowedKeys: const ['name', 'type', 'description', 'pins'],
    requiredKeys: const ['name', 'type', 'description'],
  );
  final val = Component(
    name: $checkedConvert('name', (v) => v as String),
    type: $checkedConvert('type', (v) => v as String),
    description: $checkedConvert('description', (v) => v as String),
    pins: $checkedConvert(
      'pins',
      (v) =>
          (v as List<dynamic>?)?.map((e) => Pin.fromJson(e as Map)).toList() ??
          const [],
    ),
  );
  return val;
});

Map<String, dynamic> _$ComponentToJson(Component instance) => <String, dynamic>{
  'name': instance.name,
  'type': instance.type,
  'description': instance.description,
  'pins': instance.pins,
};

Pin _$PinFromJson(Map json) => $checkedCreate('Pin', json, ($checkedConvert) {
  $checkKeys(
    json,
    allowedKeys: const ['pin', 'name', 'type', 'description'],
    requiredKeys: const ['pin', 'name', 'type', 'description'],
  );
  final val = Pin(
    pin: $checkedConvert('pin', (v) => (v as num).toInt()),
    name: $checkedConvert('name', (v) => v as String),
    type: $checkedConvert('type', (v) => v as String),
    description: $checkedConvert('description', (v) => v as String),
  );
  return val;
});

Map<String, dynamic> _$PinToJson(Pin instance) => <String, dynamic>{
  'pin': instance.pin,
  'name': instance.name,
  'type': instance.type,
  'description': instance.description,
};
