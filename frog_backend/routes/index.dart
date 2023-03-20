import 'package:dart_frog/dart_frog.dart';

Response onRequest(RequestContext context) {
  final request = context.request.copyWith();
  final method = request.method;
  return Response(body: "Trying Dart Frog. It's cool :)");
}
