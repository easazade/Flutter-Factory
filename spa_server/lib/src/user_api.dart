import 'dart:convert';

import 'package:mongo_dart/mongo_dart.dart';
import 'package:shelf_router/shelf_router.dart';
import 'package:shelf/shelf.dart';
import 'package:spa_server/src/error.dart';
import 'package:spa_server/src/middlewares.dart';

class UsersApi {
  final DbCollection userStore;

  UsersApi({required this.userStore});

  Handler get router {
    final router = Router();

    router.get('/', (Request request) async {
      var users = await userStore.find().toList();
      users = users
          .map((user) => user
            ..remove('password')
            ..remove('salt'))
          .toList();
      return createSuccessResponse(data: users);
    });

    final handler = Pipeline().addMiddleware(checkAuthorization()).addHandler(router);

    return handler;
  }
}
