import 'dart:io';

import 'package:spa_server/spa_server.dart';
import 'package:test/test.dart';
import 'package:http/http.dart' as http;

void main() {

  setUp(() async {
    await createHttpServer();
  });

  tearDown(() async {});

  test('index page should return a 200 response', () async {
    final response = await http.get(Uri.parse(baseUrl));

    expect(response.statusCode, HttpStatus.ok);
  });
}
