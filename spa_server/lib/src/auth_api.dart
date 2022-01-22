import 'package:mongo_dart/mongo_dart.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

class AuthApi {
  DbCollection store;
  String secret;

  AuthApi({required this.store, required this.secret});

  Router get router {
    final router = Router();

    return router;
  }
}
