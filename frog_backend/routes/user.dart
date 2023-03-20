import 'dart:io';

import 'package:dart_frog/dart_frog.dart';

Response onRequest(RequestContext context) {
  
  return Response.json(
    body: {
      'name': 'alireza',
      'question for him': "Why didn't He create a Context to get "
          'info on incomming requests in hist dart blog project?',
    },
  );
}
