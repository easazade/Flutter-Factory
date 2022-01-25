import 'dart:convert';
import 'dart:io';

import 'package:mongo_dart/mongo_dart.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';
import 'package:spa_server/src/error.dart';
import 'package:spa_server/src/extensions.dart';
import 'package:spa_server/src/log.dart';
import 'package:spa_server/src/utils.dart';

class AuthApi {
  DbCollection userStore;
  String secret;

  AuthApi({required this.userStore, required this.secret});

  Router get router {
    final router = Router();

    router.post('/register', (Request request) async {
      // read user inputs
      final payload = await request.readAsString();
      if (payload.isEmpty) {
        return createErrorResponse(statusCode: HttpStatus.badRequest, message: 'email and password is required');
      }
      final userInfo = jsonDecode(payload);
      final email = userInfo['email'].toString().trim();
      final password = userInfo['password'].toString().trim();

      /// check user inputs
      if (email.isNotSet) {
        return createErrorResponse(statusCode: HttpStatus.badRequest, message: 'user email cannot be empty');
      } else if (password.isNotSet) {
        return createErrorResponse(statusCode: HttpStatus.badRequest, message: 'user password cannot be empty');
      }

      // check if user already registered
      final user = await userStore.findOne(where.eq('email', email));
      if (user == null) {
        Logger.i('there is no registered user for this email => $email');
        Logger.i('registering new user');
        // process text password
        final salt = generateSalt();
        final hashedPassword = hashPassword(password, salt);
        Map<String, dynamic> newUser = {
          'email': email,
          'password': hashedPassword,
          "salt": salt,
        };
        await userStore.insert(newUser);
        return createSuccessResponse(
          statusCode: HttpStatus.created,
          message: 'new user registered',
          data: newUser
            ..remove('salt')
            ..remove('password'),
        );
      } else {
        final msg = 'there is already a user registered for this email $email';
        Logger.i(msg);
        return createErrorResponse(statusCode: HttpStatus.badRequest, message: msg);
      }
    });

    return router;
  }
}
