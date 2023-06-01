/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: public_member_api_docs
// ignore_for_file: implementation_imports

library protocol; // ignore_for_file: no_leading_underscores_for_library_prefixes

import 'package:serverpod/serverpod.dart' as _i1;
import 'package:serverpod/protocol.dart' as _i2;
import 'app_exception.dart' as _i3;
import 'error_type.dart' as _i4;
import 'example.dart' as _i5;
import 'secrets.dart' as _i6;
import 'todo.dart' as _i7;
import 'package:shared/shared.dart' as _i8;
export 'app_exception.dart';
export 'error_type.dart';
export 'example.dart';
export 'secrets.dart';
export 'todo.dart';

class Protocol extends _i1.SerializationManagerServer {
  Protocol._();

  factory Protocol() => _instance;

  static final Map<Type, _i1.constructor> customConstructors = {};

  static final Protocol _instance = Protocol._();

  static final targetDatabaseDefinition = _i2.DatabaseDefinition(tables: [
    _i2.TableDefinition(
      name: 'secrets',
      schema: 'public',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.integer,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'secrets_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'phrase',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'publicKey',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'privateKey',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'secrets_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            )
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        )
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'todos',
      schema: 'public',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.integer,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'todos_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'name',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'isDone',
          columnType: _i2.ColumnType.boolean,
          isNullable: false,
          dartType: 'bool',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'todos_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            )
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        )
      ],
      managed: true,
    ),
    ..._i2.Protocol.targetDatabaseDefinition.tables,
  ]);

  @override
  T deserialize<T>(
    dynamic data, [
    Type? t,
  ]) {
    t ??= T;
    if (customConstructors.containsKey(t)) {
      return customConstructors[t]!(data, this) as T;
    }
    if (t == _i3.AppException) {
      return _i3.AppException.fromJson(data, this) as T;
    }
    if (t == _i4.ErrorType) {
      return _i4.ErrorType.fromJson(data) as T;
    }
    if (t == _i5.Example) {
      return _i5.Example.fromJson(data, this) as T;
    }
    if (t == _i6.Secret) {
      return _i6.Secret.fromJson(data, this) as T;
    }
    if (t == _i7.Todo) {
      return _i7.Todo.fromJson(data, this) as T;
    }
    if (t == _i1.getType<_i3.AppException?>()) {
      return (data != null ? _i3.AppException.fromJson(data, this) : null) as T;
    }
    if (t == _i1.getType<_i4.ErrorType?>()) {
      return (data != null ? _i4.ErrorType.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i5.Example?>()) {
      return (data != null ? _i5.Example.fromJson(data, this) : null) as T;
    }
    if (t == _i1.getType<_i6.Secret?>()) {
      return (data != null ? _i6.Secret.fromJson(data, this) : null) as T;
    }
    if (t == _i1.getType<_i7.Todo?>()) {
      return (data != null ? _i7.Todo.fromJson(data, this) : null) as T;
    }
    if (t == _i8.Car) {
      return _i8.Car.fromJson(data, this) as T;
    }
    if (t == _i1.getType<_i8.Car?>()) {
      return (data != null ? _i8.Car.fromJson(data, this) : null) as T;
    }
    try {
      return _i2.Protocol().deserialize<T>(data, t);
    } catch (_) {}
    return super.deserialize<T>(data, t);
  }

  @override
  String? getClassNameForObject(Object data) {
    if (data is _i8.Car) {
      return 'Car';
    }
    if (data is _i3.AppException) {
      return 'AppException';
    }
    if (data is _i4.ErrorType) {
      return 'ErrorType';
    }
    if (data is _i5.Example) {
      return 'Example';
    }
    if (data is _i6.Secret) {
      return 'Secret';
    }
    if (data is _i7.Todo) {
      return 'Todo';
    }
    return super.getClassNameForObject(data);
  }

  @override
  dynamic deserializeByClassName(Map<String, dynamic> data) {
    if (data['className'] == 'Car') {
      return deserialize<_i8.Car>(data['data']);
    }
    if (data['className'] == 'AppException') {
      return deserialize<_i3.AppException>(data['data']);
    }
    if (data['className'] == 'ErrorType') {
      return deserialize<_i4.ErrorType>(data['data']);
    }
    if (data['className'] == 'Example') {
      return deserialize<_i5.Example>(data['data']);
    }
    if (data['className'] == 'Secret') {
      return deserialize<_i6.Secret>(data['data']);
    }
    if (data['className'] == 'Todo') {
      return deserialize<_i7.Todo>(data['data']);
    }
    return super.deserializeByClassName(data);
  }

  @override
  _i1.Table? getTableForType(Type t) {
    {
      var table = _i2.Protocol().getTableForType(t);
      if (table != null) {
        return table;
      }
    }
    switch (t) {
      case _i6.Secret:
        return _i6.Secret.t;
      case _i7.Todo:
        return _i7.Todo.t;
    }
    return null;
  }

  @override
  _i2.DatabaseDefinition getTargetDatabaseDefinition() =>
      targetDatabaseDefinition;
}
