import 'package:redis/redis.dart';
import 'package:spa_server/src/log.dart';
import 'package:spa_server/src/utils.dart';
import 'package:uuid/uuid.dart';

const refreshTokenExpiryDuration = Duration(days: 30);
const accessTokenExpiryDuration = Duration(days: 10); // should be like 15 minutes. but for the sake of testing

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
      expiry: accessTokenExpiryDuration,
    );

    final refreshToken = generateJWT(
      userId,
      'http://localhost',
      secret,
      jwtId: tokenId,
      expiry: refreshTokenExpiryDuration,
    );

    await addRefereshTokenToRedis(tokenId, refreshToken, refreshTokenExpiryDuration);

    return TokenPair(idToken: token, refreshToken: refreshToken);
  }

  Future addRefereshTokenToRedis(String id, String token, Duration expiry) async {
    await _cache?.send_object(["SET", "$_prefix:$id", token]);
    await _cache?.send_object(["EXPIRE", "$_prefix:$id", expiry.inSeconds]);
  }

  Future<dynamic> getRefreshToken(String id) {
    return _cache!.get('$_prefix:$id');
  }

  Future<void> removeRefreshToken(String id) {
    Logger.d('jwt id = $id');
    return _cache!.send_object(['EXPIRE', '$_prefix:$id', '-1']);
  }
}
