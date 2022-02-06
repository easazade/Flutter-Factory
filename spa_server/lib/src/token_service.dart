import 'package:redis/redis.dart';
import 'package:spa_server/src/utils.dart';
import 'package:uuid/uuid.dart';

class TokenService {
  TokenService({required this.db, required this.secret});

  final RedisConnection db;
  final String secret;

  static Command? _cache;
  final String _prefix = 'token';

  Future start(String host, int port) async {
    _cache = await db.connect(host, port);
  }

  Future<TokenPair> createToken(String userId) async {
    final tokenId = Uuid().v4();
    final token = generateJWT(
      userId,
      'http://localhost',
      secret,
      jwtId: tokenId,
      expiry: const Duration(seconds: 30),
    );

    final refreshTokenExpiry = const Duration(seconds: 60);
    final refreshToken = generateJWT(
      userId,
      'http://localhost',
      secret,
      jwtId: tokenId,
      expiry: refreshTokenExpiry,
    );

    await addRefereshTokenToRedis(tokenId, refreshToken, refreshTokenExpiry);

    return TokenPair(idToken: token, refreshToken: refreshToken);
  }

  Future addRefereshTokenToRedis(String id, String token, Duration expiry) async {
    await _cache?.send_object(["SET", "$_prefix:$id", token]);
    await _cache?.send_object(["EXPIRE", "$_prefix:$id", expiry.inSeconds]);
  }
}
