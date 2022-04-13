import 'dart:io';

import 'package:mustache_template/mustache_template.dart';

var counter = 0;

Future main(List<String> arguments) async {
  final server = await HttpServer.bind('localhost', 1234);
  await for (var request in server) {
    request.response.headers.set('Content-Type', 'text/html');

    final content = await render('bin/templates/page.mustache', templateName: 'page', values: {
      'header': 'Mustache Dart',
      'optional': true,
    });

    print('content $content');
    request.response.write(content);

    await request.response.flush();
    await request.response.close();
  }
}

/// reads and renders mustache template from the given [filePath] with provided [values]
///
/// if [templateName] is provided it will be used in error messages
Future<String> render(final String filePath, {String? templateName, dynamic values}) async {
  final sampleFileContent = await File(filePath).readAsString();
  final template = Template(sampleFileContent, name: templateName ?? filePath, lenient: true);
  final output = template.renderString(values);
  return output;
}
