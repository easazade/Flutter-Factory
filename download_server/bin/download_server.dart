import 'dart:io';

Future main(List<String> arguments) async {
  final server = await HttpServer.bind('localhost', 1234);

  await for (var request in server) {
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
      </select>
      <button>Download</button>
    </form>
</body>
</html>

''');

    await request.response.close();
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
