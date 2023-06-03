/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: public_member_api_docs
// ignore_for_file: implementation_imports

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod/serverpod.dart' as _i1;
import '../endpoints/car_endpoint.dart' as _i2;
import '../endpoints/example_endpoint.dart' as _i3;
import '../endpoints/secrets_endpoint.dart' as _i4;
import '../endpoints/todo_endpoint.dart' as _i5;
import '../endpoints/user_endpoint.dart' as _i6;
import 'package:pod_server/src/generated/todo.dart' as _i7;

class Endpoints extends _i1.EndpointDispatch {
  @override
  void initializeEndpoints(_i1.Server server) {
    var endpoints = <String, _i1.Endpoint>{
      'car': _i2.CarEndpoint()
        ..initialize(
          server,
          'car',
          null,
        ),
      'example': _i3.ExampleEndpoint()
        ..initialize(
          server,
          'example',
          null,
        ),
      'secrets': _i4.SecretsEndpoint()
        ..initialize(
          server,
          'secrets',
          null,
        ),
      'todo': _i5.TodoEndpoint()
        ..initialize(
          server,
          'todo',
          null,
        ),
      'user': _i6.UserEndpoint()
        ..initialize(
          server,
          'user',
          null,
        ),
    };
    connectors['car'] = _i1.EndpointConnector(
      name: 'car',
      endpoint: endpoints['car']!,
      methodConnectors: {
        'getCar': _i1.MethodConnector(
          name: 'getCar',
          params: {},
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['car'] as _i2.CarEndpoint).getCar(session),
        )
      },
    );
    connectors['example'] = _i1.EndpointConnector(
      name: 'example',
      endpoint: endpoints['example']!,
      methodConnectors: {
        'hello': _i1.MethodConnector(
          name: 'hello',
          params: {
            'name': _i1.ParameterDescription(
              name: 'name',
              type: _i1.getType<String>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['example'] as _i3.ExampleEndpoint).hello(
            session,
            params['name'],
          ),
        )
      },
    );
    connectors['secrets'] = _i1.EndpointConnector(
      name: 'secrets',
      endpoint: endpoints['secrets']!,
      methodConnectors: {
        'getSecret': _i1.MethodConnector(
          name: 'getSecret',
          params: {},
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['secrets'] as _i4.SecretsEndpoint).getSecret(session),
        )
      },
    );
    connectors['todo'] = _i1.EndpointConnector(
      name: 'todo',
      endpoint: endpoints['todo']!,
      methodConnectors: {
        'createTodo': _i1.MethodConnector(
          name: 'createTodo',
          params: {
            'todo': _i1.ParameterDescription(
              name: 'todo',
              type: _i1.getType<_i7.Todo>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['todo'] as _i5.TodoEndpoint).createTodo(
            session,
            params['todo'],
          ),
        )
      },
    );
    connectors['user'] = _i1.EndpointConnector(
      name: 'user',
      endpoint: endpoints['user']!,
      methodConnectors: {
        'user': _i1.MethodConnector(
          name: 'user',
          params: {
            'name': _i1.ParameterDescription(
              name: 'name',
              type: _i1.getType<String>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['user'] as _i6.UserEndpoint).user(
            session,
            params['name'],
          ),
        ),
        'createUser': _i1.MethodConnector(
          name: 'createUser',
          params: {
            'username': _i1.ParameterDescription(
              name: 'username',
              type: _i1.getType<String>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['user'] as _i6.UserEndpoint).createUser(
            session,
            params['username'],
          ),
        ),
      },
    );
  }
}
