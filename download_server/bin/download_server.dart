import 'dart:io';

import 'package:mime/mime.dart';

// this is the link of the tutorial https://www.youtube.com/watch?v=2NUL4YG6Wnk

Future main(List<String> arguments) async {
  final uploadDir = Directory('upload');
  final images = <String>[];
  await for (var fileEntity in uploadDir.list()) {
    images.add(fileEntity.uri.path);
  }
  images.forEach(print);

  final server = await HttpServer.bind('localhost', 1234);

  await for (var request in server) {
    final queryParams = request.uri.queryParameters;

    final filePath = queryParams['file-to-download'];

    if (filePath is String) {
      print('trying to download $filePath');

      final file = File(filePath);
      if (await file.exists()) {
        request.response.headers
            .set('Content-Type', lookupMimeType(filePath) ?? 'image/*');
        // to make this link downloadable instead of being opened and show we need to specify content-disposition
        // as attachment instead of inline
        final downloadName = filePath.split('/').last;
        request.response.headers
            .set('Content-Disposition', 'attachment; filename="$downloadName"');

        final fileStream = file.openRead();
        await request.response.addStream(fileStream);
      } else {
        request.response.redirect(Uri(path: '/'));
      }

      await request.response.flush();
      await request.response.close();
    } else {
      request.response
        ..headers.set('Content-Type', 'text/html')
        ..write('''
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Image Download Server</title>
</head>
<body>
    <h2>Select image to download</h2>
    <form>
      <select name="file-to-download">
        <option selected>Choose Image</option>
        <option> ${images.join('</option><option>')}</option>
      </select>
      <button>Download</button>
    </form>
</body>
</html>

''');

      await request.response.close();
    }
  }
}

// Future main(List<String> arguments) async {
//   final server = await HttpServer.bind('localhost', 1234);

//   await for (var request in server) {
//     request.response.statusCode = 202;
//     request.response.write('object');
//     await request.response.flush();
//     await request.response.close();
//   }
// }
