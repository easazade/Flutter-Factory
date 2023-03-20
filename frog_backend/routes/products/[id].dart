// ignore_for_file: avoid_print

import 'package:dart_frog/dart_frog.dart';
import 'package:frog_backend/dependencies.dart';
import 'package:frog_backend/extensions.dart';

Future<Response> onRequest(RequestContext context, String id) async {
  print('accessing product with id $id');

  final dependency = context.read<Dependency1>();
  final dependency2 = await context.read<Future<Dependency2>>();

  return Response.json(
    body: {
      'id': id,
      'product': 'Some product name',
      'dependencies': [dependency, dependency2],
    },
  );
}
