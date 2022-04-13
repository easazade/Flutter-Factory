import 'dart:io';

var counter = 0;

Future main(List<String> arguments) async {
  final server = await HttpServer.bind('localhost', 1234);
  await for (var request in server) {
    request.response.write('this is a response for request ${counter++}');

    await request.response.flush();
    await request.response.close();
  }
}
