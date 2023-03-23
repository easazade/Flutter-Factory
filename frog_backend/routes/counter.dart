import 'package:dart_frog/dart_frog.dart';

int _count = 1;

Response onRequest(RequestContext context) {
  return Response(
    body: 'You have send a request to this route ${_count++} times',
  );
}
