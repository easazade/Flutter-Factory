import 'dart:io';

import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart' as io;
import 'package:shelf_router/shelf_router.dart';
import 'package:shelf_static/shelf_static.dart';
import 'package:spa_server/src/auth_api.dart';
import 'package:spa_server/src/config.dart';
import 'package:spa_server/src/middlewares.dart';
import 'package:spa_server/src/user_api.dart';
import 'package:spa_server/src/utils.dart';
import 'package:mongo_dart/mongo_dart.dart';

const port = 8080;

const domain = 'localhost';

final String baseUrl = 'http://$domain:$port';

Future<HttpServer> createHttpServer() async {
  // creating db
  final db = Db('mongodb://127.0.0.1:27017/spa_server');
  await db.open();
  print('connected to our database');
  final userStore = db.collection('users');

  // creating app which is basically the main router
  final app = Router();

  app.mount('/auth', AuthApi(userStore: userStore, secret: Env.secretKey).router);

  app.mount('/users', UsersApi(userStore: userStore).router);

  app.get('/assets/<file|.*>', createStaticHandler('public'));

  // index page
  app.get('/', (Request request) async {
    final indexFile = File('public/index.html').readAsStringSync();
    return Response.ok(
      indexFile,
      headers: {'content-type': 'text/html'},
    );
  });

  // simple route
  app.get('/simple/<name|.*>', (Request request, String name) {
    return Response.ok('name is $name');
  });

  final middlewareWrapper = Pipeline()
      .addMiddleware(logRequests())
      .addMiddleware(handleCors())
      .addMiddleware(handleAuth(Env.secretKey))
      .addHandler(app);

  return io.serve(middlewareWrapper, domain, port);
}
