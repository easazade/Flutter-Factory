/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: public_member_api_docs
// ignore_for_file: implementation_imports

library protocol; // ignore_for_file: no_leading_underscores_for_library_prefixes

import 'package:serverpod_client/serverpod_client.dart' as _i1;
import 'app_exception.dart' as _i2;
import 'error_type.dart' as _i3;
import 'example.dart' as _i4;
import 'profile_images.dart' as _i5;
import 'todo.dart' as _i6;
import 'user.dart' as _i7;
import 'package:shared/shared.dart' as _i8;
export 'app_exception.dart';
export 'error_type.dart';
export 'example.dart';
export 'profile_images.dart';
export 'todo.dart';
export 'user.dart';
export 'client.dart';

class Protocol extends _i1.SerializationManager {
  Protocol._();

  factory Protocol() => _instance;

  static final Map<Type, _i1.constructor> customConstructors = {};

  static final Protocol _instance = Protocol._();

  @override
  T deserialize<T>(
    dynamic data, [
    Type? t,
  ]) {
    t ??= T;
    if (customConstructors.containsKey(t)) {
      return customConstructors[t]!(data, this) as T;
    }
    if (t == _i2.AppException) {
      return _i2.AppException.fromJson(data, this) as T;
    }
    if (t == _i3.ErrorType) {
      return _i3.ErrorType.fromJson(data) as T;
    }
    if (t == _i4.Example) {
      return _i4.Example.fromJson(data, this) as T;
    }
    if (t == _i5.ProfileImages) {
      return _i5.ProfileImages.fromJson(data, this) as T;
    }
    if (t == _i6.Todo) {
      return _i6.Todo.fromJson(data, this) as T;
    }
    if (t == _i7.User) {
      return _i7.User.fromJson(data, this) as T;
    }
    if (t == _i1.getType<_i2.AppException?>()) {
      return (data != null ? _i2.AppException.fromJson(data, this) : null) as T;
    }
    if (t == _i1.getType<_i3.ErrorType?>()) {
      return (data != null ? _i3.ErrorType.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i4.Example?>()) {
      return (data != null ? _i4.Example.fromJson(data, this) : null) as T;
    }
    if (t == _i1.getType<_i5.ProfileImages?>()) {
      return (data != null ? _i5.ProfileImages.fromJson(data, this) : null)
          as T;
    }
    if (t == _i1.getType<_i6.Todo?>()) {
      return (data != null ? _i6.Todo.fromJson(data, this) : null) as T;
    }
    if (t == _i1.getType<_i7.User?>()) {
      return (data != null ? _i7.User.fromJson(data, this) : null) as T;
    }
    if (t == _i1.getType<List<String>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<String>(e)).toList()
          : null) as dynamic;
    }
    if (t == _i8.Car) {
      return _i8.Car.fromJson(data, this) as T;
    }
    if (t == _i1.getType<_i8.Car?>()) {
      return (data != null ? _i8.Car.fromJson(data, this) : null) as T;
    }
    return super.deserialize<T>(data, t);
  }

  @override
  String? getClassNameForObject(Object data) {
    if (data is _i8.Car) {
      return 'Car';
    }
    if (data is _i2.AppException) {
      return 'AppException';
    }
    if (data is _i3.ErrorType) {
      return 'ErrorType';
    }
    if (data is _i4.Example) {
      return 'Example';
    }
    if (data is _i5.ProfileImages) {
      return 'ProfileImages';
    }
    if (data is _i6.Todo) {
      return 'Todo';
    }
    if (data is _i7.User) {
      return 'User';
    }
    return super.getClassNameForObject(data);
  }

  @override
  dynamic deserializeByClassName(Map<String, dynamic> data) {
    if (data['className'] == 'Car') {
      return deserialize<_i8.Car>(data['data']);
    }
    if (data['className'] == 'AppException') {
      return deserialize<_i2.AppException>(data['data']);
    }
    if (data['className'] == 'ErrorType') {
      return deserialize<_i3.ErrorType>(data['data']);
    }
    if (data['className'] == 'Example') {
      return deserialize<_i4.Example>(data['data']);
    }
    if (data['className'] == 'ProfileImages') {
      return deserialize<_i5.ProfileImages>(data['data']);
    }
    if (data['className'] == 'Todo') {
      return deserialize<_i6.Todo>(data['data']);
    }
    if (data['className'] == 'User') {
      return deserialize<_i7.User>(data['data']);
    }
    return super.deserializeByClassName(data);
  }
}
