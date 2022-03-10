import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:crypto/crypto.dart';
import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:shelf/shelf.dart';
import 'package:spa_server/src/error.dart';
import 'package:spa_server/src/log.dart';
import 'package:spa_server/src/utils.dart';

const corsHeaders = {
  'Access-Control-Allow-Origin': '*',
  'Access-Control-Allow-Methods': 'GET, POST, PUT, DELETE',
  'Access-Control-Allow-Headers': 'Origin, Content-Type',
};

Middleware handleCors() {
  return createMiddleware(
    requestHandler: (request) {
      if (request.method == 'OPTIONS') {
        // browser will send  a preflight request to get these headers
        // and it will use it to determine whether to continue with the full details or not
        return Response.ok('', headers: corsHeaders);
      }
    },
    responseHandler: (response) {
      // intercepts all HttpResponses before going to user's client
      return response.change(headers: corsHeaders);
    },
  );
}

Middleware handleAuth(String secret) {
  return (Handler innerHandler) {
    return (Request request) {
      final authHeader = request.headers['authorization'];
      JWT? jwt;
      String? token;

      if (authHeader != null && authHeader.startsWith('Bearer ')) {
        token = authHeader.substring(7);
        jwt = verifyJWT(token, secret);
      }

      final updatedRequest = request.change(context: {
        'authDetails': jwt,
      });
      return innerHandler(updatedRequest);
    };
  };
}

Middleware checkAuthorization() {
  return createMiddleware(
    requestHandler: (request) {
      if (request.context['authDetails'] == null) {
        return createErrorResponse(
          statusCode: HttpStatus.unauthorized,
          message: 'Not Authorized to access this content',
        );
      }
      return null;
    },
  );
}
