// ignore_for_file: public_member_api_docs, lines_longer_than_80_chars

import 'package:dart_frog/dart_frog.dart';
import 'package:json_annotation/json_annotation.dart';

part 'dependencies.g.dart';

@JsonSerializable()
class Dependency1 {
  Dependency1(this.name);
  factory Dependency1.fromJson(Map<String, dynamic> json) =>
      _$Dependency1FromJson(json);

  final String name;

  Map<String, dynamic> toJson() => _$Dependency1ToJson(this);
}

@JsonSerializable()
class Dependency2 {
  Dependency2(this.name);
  factory Dependency2.fromJson(Map<String, dynamic> json) =>
      _$Dependency2FromJson(json);

  final String name;

  Map<String, dynamic> toJson() => _$Dependency2ToJson(this);
}

Dependency1? _dependency1Cache;

Middleware dependenciesProvider() {
  return (handler) {
    return (context) {
      context = context
          .provide<Future<Dependency2>>(
              () => Future.value(Dependency2('dependency 2')))
          .provide<Dependency1>(
              () => _dependency1Cache ??= Dependency1('dependency 1'));

      return handler(context);
    };
  };
}
