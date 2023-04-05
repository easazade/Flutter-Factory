import 'dart:convert';
import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:mongo_dart/mongo_dart.dart';
import 'package:shelf_router/shelf_router.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf_static/shelf_static.dart';
import 'package:spa_server/src/error.dart';
import 'package:spa_server/src/middlewares.dart';
import 'package:path/path.dart' as path;

class StaticAssetsApi {
  final String assetsPath;

  StaticAssetsApi({required this.assetsPath});

  Router get router {
    final router = Router();
    router.get('/<file|.*>', (Request request) async {
      final assetPath =
          path.join(assetsPath, request.requestedUri.path.substring(1));
      return await createFileHandler(assetPath)(request);
    });
    return router;
  }
}
