import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:serverpod_serialization/serverpod_serialization.dart';

part 'car.freezed.dart';
part 'car.g.dart';

@freezed
class Car with _$Car {
  const factory Car({
    required String name,
    required String brand,
  }) = _Car;

  factory Car.fromJson(
    Map<String, Object?> json,
    SerializationManager serializationManager,
  ) =>
      _$CarFromJson(json);
}
