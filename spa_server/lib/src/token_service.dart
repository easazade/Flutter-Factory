import 'package:redis/redis.dart';

class TokenService {

  TokenService({required this.db, required this.secret});

  final RedisConnection db;
  final String secret;

  static Command? _cache;
  final String _prefix = 'token';

  Future start(String host, int port) async {
    _cache = await db.connect(host, port);
  }
}
