// ignore_for_file: avoid_print

import 'package:dart_frog/dart_frog.dart';
import 'package:frog_backend/dependencies.dart';

// Handler middleware(Handler handler) {
//   return (context) async {
//     final response = await handler(context);
//     print('from our middleware');
//     return response;
//   };
// }

// Handler middleware(Handler handler) {
//   return handler.use(requestLogger());
// }

Handler middleware(Handler handler) {
  return (context) async {
    print('before processing the request - our dear middleware');
    context = context.provide(() => SomeDependency('important dependency'));
    

    final response = await handler(context);
    print('after processing the request - our dear middleware');

    return response;
  };
}
