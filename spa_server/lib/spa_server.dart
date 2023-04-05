import 'dart:io';

import 'package:redis/redis.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart' as io;
import 'package:shelf_router/shelf_router.dart';
import 'package:shelf_static/shelf_static.dart';
import 'package:spa_server/src/api/auth_api.dart';
import 'package:spa_server/src/api/statics_files_api.dart';
import 'package:spa_server/src/config.dart';
import 'package:spa_server/src/log.dart';
import 'package:spa_server/src/middlewares.dart';
import 'package:spa_server/src/api/user_api.dart';
import 'package:spa_server/src/token_service.dart';
import 'package:spa_server/src/utils.dart';
import 'package:mongo_dart/mongo_dart.dart';

const port = 8080;

const domain = 'localhost';

final String baseUrl = 'http://$domain:$port';

Future<HttpServer> createHttpServer() async {
  // creating db
  final db = Db('mongodb://127.0.0.1:27017/spa_server');
  await db.open();
  Logger.i('connected to our database');
  final userStore = db.collection('users');
  // token service
  final tokenService =
      TokenService(db: RedisConnection(), secret: Env.secretKey);
  await tokenService.start('localhost', 6379); // 6379 is default redis port
  Logger.i('Token Service Running ...');

  // creating app which is basically the main router
  final app = Router();

  app.mount(
      '/auth',
      AuthApi(
              userStore: userStore,
              secret: Env.secretKey,
              tokenService: tokenService)
          .router);

  app.mount('/users', UsersApi(userStore: userStore).router);

  app.mount('/assets', StaticAssetsApi(assetsPath: 'public').router);

  // index page
  // setting a fallback route. any unknown route that is called in any http request type will be handled here
  app.all('/<name|.*>', fallback('public/index.html'));

  // // simple route
  // app.get('/simple/<name|.*>', (Request request, String name) {
  //   return Response.ok('name is $name');
  // });

  final middlewareWrapper = Pipeline()
      .addMiddleware(logRequests())
      .addMiddleware(handleCors())
      .addMiddleware(handleAuth(Env.secretKey))
      .addHandler(app);

  return io.serve(middlewareWrapper, domain, port);
}
