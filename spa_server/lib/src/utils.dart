import 'dart:convert';
import 'dart:math';

import 'package:crypto/crypto.dart';
import 'package:shelf/shelf.dart';

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

String generateSalt([int length = 32]) {
  final random = Random();
  final saltBytes = List<int>.generate(length, (index) => random.nextInt(256));
  return base64Encode(saltBytes);
}

String hashPassword(String password, String salt) {
  final codec = Utf8Codec();
  final key = codec.encode(password);
  final saltBytes = codec.encode(salt);
  final hmac = Hmac(sha256, key);
  final digest = hmac.convert(saltBytes);
  return digest.toString();
}
