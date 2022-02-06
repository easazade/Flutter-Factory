import 'dart:convert';
import 'dart:io';

import 'package:mongo_dart/mongo_dart.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';
import 'package:spa_server/src/error.dart';
import 'package:spa_server/src/extensions.dart';
import 'package:spa_server/src/log.dart';
import 'package:spa_server/src/token_service.dart';
import 'package:spa_server/src/utils.dart';

class AuthApi {
  AuthApi({
    required this.userStore,
    required this.secret,
    required this.tokenService,
  });

  final DbCollection userStore;
  final String secret;
  final TokenService tokenService;

  Router get router {
    final router = Router();

    router.post('/register', (Request request) async {
      // read user inputs
      final payload = await request.readAsString();
      Logger.d('payload = $payload');
      final params = request.params;
      Logger.d('params = $params');
      final url = request.url;
      Logger.d('url = $url');
      final requestedUri = request.requestedUri;
      Logger.d('requestedUri = $requestedUri');
      final context = request.context;
      Logger.d('context = $context');
      final headers = request.headers;
      Logger.d('headers = $headers');
      final mimType = request.mimeType;
      Logger.d('mimType = $mimType');
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

    router.post('/login', (Request request) async {
      final payload = await request.readAsString();
      print(payload);
      final userInfo = jsonDecode(payload);
      final email = userInfo['email'].toString().trim();
      final password = userInfo['password'].toString().trim();

      /// check user inputs
      if (email.isNotSet) {
        return createErrorResponse(statusCode: HttpStatus.badRequest, message: 'user email cannot be empty');
      } else if (password.isNotSet) {
        return createErrorResponse(statusCode: HttpStatus.badRequest, message: 'user password cannot be empty');
      }

      final user = await userStore.findOne(where.eq('email', email));
      if (user == null) {
        return createErrorResponse(
          statusCode: HttpStatus.badRequest,
          message: 'there is not user registered with this email',
        );
      } else {
        final hasedPassword = hashPassword(password, user['salt']);
        if (hasedPassword != user['password']) {
          return createErrorResponse(statusCode: HttpStatus.forbidden, message: 'Incorrect email or password');
        } else {
          // if passwrod is correct we generate a JWT token
          final userId = (user['_id'] as ObjectId).toHexString();
          try {
            final tokenPair = await tokenService.createToken(userId);
            // final token = generateJWT(userId, 'http://localhost', secret);
            return createSuccessResponse(
              statusCode: HttpStatus.ok,
              message: 'you are logged in',
              data: {
                'token': tokenPair,
                'user': user
                  ..remove('password')
                  ..remove('salt'),
              },
            );
          } on Exception catch (e, stacktrace) {
            return createErrorResponse(
              statusCode: HttpStatus.internalServerError,
              message: 'Something went wrong, please try again',
            );
          }
        }
      }
    });

    router.post('/logout', (Request request) async {
      if (request.context['authDetails'] == null) {
        return createErrorResponse(
          statusCode: HttpStatus.forbidden,
          message: 'you are not authorized to access',
        );
      }
      //TODO: we should invalidate the token assigned to this user
      // otherwise logout does not work
      return createSuccessResponse(message: 'Logged out successfully');
    });

    return router;
  }
}
