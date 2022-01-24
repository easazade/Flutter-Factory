import 'dart:convert';

import 'package:mongo_dart/mongo_dart.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';
import 'package:spa_server/src/error.dart';
import 'package:spa_server/src/extensions.dart';

class AuthApi {
  DbCollection store;
  String secret;

  AuthApi({required this.store, required this.secret});

  Router get router {
    final router = Router();

    router.post('/register', (Request request) async {
      final payload = await request.readAsString();
      if (payload.isEmpty) {
        return createErrorResponse(statusCode: 400, message: 'email and password is required');
      }
      final userInfo = jsonDecode(payload);
      final email = userInfo['email'].toString().trim();
      final password = userInfo['password'].toString().trim();

      if (email.isNotSet) {
        return createErrorResponse(statusCode: 400, message: 'user email cannot be empty');
      } else if (password.isNotSet) {
        return createErrorResponse(statusCode: 400, message: 'user password cannot be empty');
      }

      return Response.ok('THIS IS REGISTER ENDPOINT');
    });

    return router;
  }
}
