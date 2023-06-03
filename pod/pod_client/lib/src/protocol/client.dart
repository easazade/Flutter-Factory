/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: public_member_api_docs
// ignore_for_file: implementation_imports

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod_client/serverpod_client.dart' as _i1;
import 'dart:async' as _i2;
import 'package:shared/src/shared_models/car.dart' as _i3;
import 'package:pod_client/src/protocol/todo.dart' as _i4;
import 'package:pod_client/src/protocol/user.dart' as _i5;
import 'dart:io' as _i6;
import 'protocol.dart' as _i7;

class _EndpointCar extends _i1.EndpointRef {
  _EndpointCar(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'car';

  _i2.Future<_i3.Car> getCar() => caller.callServerEndpoint<_i3.Car>(
        'car',
        'getCar',
        {},
      );
}

class _EndpointExample extends _i1.EndpointRef {
  _EndpointExample(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'example';

  _i2.Future<String> hello(String name) => caller.callServerEndpoint<String>(
        'example',
        'hello',
        {'name': name},
      );
}

class _EndpointSecrets extends _i1.EndpointRef {
  _EndpointSecrets(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'secrets';

  _i2.Future<void> getSecret() => caller.callServerEndpoint<void>(
        'secrets',
        'getSecret',
        {},
      );
}

class _EndpointTodo extends _i1.EndpointRef {
  _EndpointTodo(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'todo';

  _i2.Future<_i4.Todo> createTodo(_i4.Todo todo) =>
      caller.callServerEndpoint<_i4.Todo>(
        'todo',
        'createTodo',
        {'todo': todo},
      );
}

class _EndpointUser extends _i1.EndpointRef {
  _EndpointUser(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'user';

  _i2.Future<String> user(String name) => caller.callServerEndpoint<String>(
        'user',
        'user',
        {'name': name},
      );

  _i2.Future<_i5.User> createUser(String username) =>
      caller.callServerEndpoint<_i5.User>(
        'user',
        'createUser',
        {'username': username},
      );
}

class Client extends _i1.ServerpodClient {
  Client(
    String host, {
    _i6.SecurityContext? context,
    _i1.AuthenticationKeyManager? authenticationKeyManager,
  }) : super(
          host,
          _i7.Protocol(),
          context: context,
          authenticationKeyManager: authenticationKeyManager,
        ) {
    car = _EndpointCar(this);
    example = _EndpointExample(this);
    secrets = _EndpointSecrets(this);
    todo = _EndpointTodo(this);
    user = _EndpointUser(this);
  }

  late final _EndpointCar car;

  late final _EndpointExample example;

  late final _EndpointSecrets secrets;

  late final _EndpointTodo todo;

  late final _EndpointUser user;

  @override
  Map<String, _i1.EndpointRef> get endpointRefLookup => {
        'car': car,
        'example': example,
        'secrets': secrets,
        'todo': todo,
        'user': user,
      };
  @override
  Map<String, _i1.ModuleEndpointCaller> get moduleLookup => {};
}
