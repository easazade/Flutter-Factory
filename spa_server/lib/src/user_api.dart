import 'dart:convert';

import 'package:shelf_router/shelf_router.dart';
import 'package:shelf/shelf.dart';

class UserApi {
  Router get router {
    final router = Router();

    router.get('/', (Request request) {
      return Response.ok(
        jsonEncode({
          "users": ['alireza', 'ahmadreza', 'payam', 'sobhan', 'haman', 'sajad', 'mehdi jirofti'],
        }),
        headers: {'content-type': 'application/json'},
      );
    });

    return router;
  }
}
