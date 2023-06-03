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
import 'profile_images.dart' as _i6;
import 'secrets.dart' as _i7;
import 'todo.dart' as _i8;
import 'user.dart' as _i9;
import 'package:shared/shared.dart' as _i10;
export 'app_exception.dart';
export 'error_type.dart';
export 'example.dart';
export 'profile_images.dart';
export 'secrets.dart';
export 'todo.dart';
export 'user.dart';

class Protocol extends _i1.SerializationManagerServer {
  Protocol._();

  factory Protocol() => _instance;

  static final Map<Type, _i1.constructor> customConstructors = {};

  static final Protocol _instance = Protocol._();

  static final targetDatabaseDefinition = _i2.DatabaseDefinition(tables: [
    _i2.TableDefinition(
      name: 'profile_images',
      schema: 'public',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.integer,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'profile_images_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'userId',
          columnType: _i2.ColumnType.integer,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'avatar',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'avatarThumbnail',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'cover',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
      ],
      foreignKeys: [
        _i2.ForeignKeyDefinition(
          constraintName: 'profile_images_fk_0',
          columns: ['userId'],
          referenceTable: 'users',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: null,
          onDelete: _i2.ForeignKeyAction.cascade,
          matchType: null,
        )
      ],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'profile_images_pkey',
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
    _i2.TableDefinition(
      name: 'users',
      schema: 'public',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.integer,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'users_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'username',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'password',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'users_pkey',
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
        ),
        _i2.IndexDefinition(
          indexName: 'username_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'username',
            )
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
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
    if (t == _i6.ProfileImages) {
      return _i6.ProfileImages.fromJson(data, this) as T;
    }
    if (t == _i7.Secret) {
      return _i7.Secret.fromJson(data, this) as T;
    }
    if (t == _i8.Todo) {
      return _i8.Todo.fromJson(data, this) as T;
    }
    if (t == _i9.User) {
      return _i9.User.fromJson(data, this) as T;
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
    if (t == _i1.getType<_i6.ProfileImages?>()) {
      return (data != null ? _i6.ProfileImages.fromJson(data, this) : null)
          as T;
    }
    if (t == _i1.getType<_i7.Secret?>()) {
      return (data != null ? _i7.Secret.fromJson(data, this) : null) as T;
    }
    if (t == _i1.getType<_i8.Todo?>()) {
      return (data != null ? _i8.Todo.fromJson(data, this) : null) as T;
    }
    if (t == _i1.getType<_i9.User?>()) {
      return (data != null ? _i9.User.fromJson(data, this) : null) as T;
    }
    if (t == _i1.getType<List<String>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<String>(e)).toList()
          : null) as dynamic;
    }
    if (t == _i10.Car) {
      return _i10.Car.fromJson(data, this) as T;
    }
    if (t == _i1.getType<_i10.Car?>()) {
      return (data != null ? _i10.Car.fromJson(data, this) : null) as T;
    }
    try {
      return _i2.Protocol().deserialize<T>(data, t);
    } catch (_) {}
    return super.deserialize<T>(data, t);
  }

  @override
  String? getClassNameForObject(Object data) {
    if (data is _i10.Car) {
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
    if (data is _i6.ProfileImages) {
      return 'ProfileImages';
    }
    if (data is _i7.Secret) {
      return 'Secret';
    }
    if (data is _i8.Todo) {
      return 'Todo';
    }
    if (data is _i9.User) {
      return 'User';
    }
    return super.getClassNameForObject(data);
  }

  @override
  dynamic deserializeByClassName(Map<String, dynamic> data) {
    if (data['className'] == 'Car') {
      return deserialize<_i10.Car>(data['data']);
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
    if (data['className'] == 'ProfileImages') {
      return deserialize<_i6.ProfileImages>(data['data']);
    }
    if (data['className'] == 'Secret') {
      return deserialize<_i7.Secret>(data['data']);
    }
    if (data['className'] == 'Todo') {
      return deserialize<_i8.Todo>(data['data']);
    }
    if (data['className'] == 'User') {
      return deserialize<_i9.User>(data['data']);
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
      case _i6.ProfileImages:
        return _i6.ProfileImages.t;
      case _i7.Secret:
        return _i7.Secret.t;
      case _i8.Todo:
        return _i8.Todo.t;
      case _i9.User:
        return _i9.User.t;
    }
    return null;
  }

  @override
  _i2.DatabaseDefinition getTargetDatabaseDefinition() =>
      targetDatabaseDefinition;
}
