// ignore_for_file: avoid_print

import 'package:dart_frog/dart_frog.dart';
import 'package:frog_backend/dependencies.dart';

Response onRequest(RequestContext context, String id) {
  print('accessing product with id $id');

  final dependency = context.read<SomeDependency>();
  return Response.json(
    body: {
      'id': id,
      'product': 'some product name',
      'dependency': dependency.name,
    },
  );
}
