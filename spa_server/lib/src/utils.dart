import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:crypto/crypto.dart';
import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:shelf/shelf.dart';
import 'package:spa_server/src/log.dart';

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

String generateJWT(
  String subject,
  String issuer,
  String secret, {
  required String jwtId,
  Duration expiry = const Duration(seconds: 30),
}) {
  final jwt = JWT(
    {'iat': DateTime.now().millisecondsSinceEpoch},
    subject: subject,
    issuer: issuer,
    jwtId: jwtId,
  );
  return jwt.sign(SecretKey(secret), expiresIn: expiry);
}

JWT? verifyJWT(String token, String secret) {
  try {
    final jwt = JWT.verify(token, SecretKey(secret));
    return jwt;
  } on JWTExpiredError catch (e) {
    Logger.e(e);
    return null;
  } on JWTError catch (e) {
    Logger.e(e);
    return null;
  } on Exception catch (e) {
    Logger.e(e);
    return null;
  }
}

Handler fallback(String pagePath) => (Request request) async {
      final indexFile = File(pagePath).readAsStringSync();
      return Response.ok(
        indexFile,
        headers: {'content-type': 'text/html'},
      );
    };

class TokenPair {
  final String idToken;
  final String refreshToken;

  TokenPair({required this.idToken, required this.refreshToken});

  Map<String, dynamic> toJson() {
    return {
      'access_token': idToken,
      "refresh_token": refreshToken,
    };
  }
}
