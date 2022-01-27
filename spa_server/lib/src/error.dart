import 'dart:convert';
import 'dart:io';
import 'package:shelf/shelf.dart';

Response createSuccessResponse({
  int statusCode = 200,
  String message = 'success',
  required dynamic data,
}) {
  if (data is! List && data is! Map) {
    print('some');
    throw Exception('the data argument can only be a Map or List that can be serialized to json');
  }
  return Response(
    statusCode,
    headers: {HttpHeaders.contentTypeHeader: ContentType.json.mimeType},
    body: jsonEncode(
      {
        "statusCode": statusCode,
        "message": message,
        "data": data,
      },
    ),
  );
}

Response createErrorResponse({
  required int statusCode,
  required String message,
}) {
  return Response(
    statusCode,
    headers: {HttpHeaders.contentTypeHeader: ContentType.json.mimeType},
    body: jsonEncode(
      {
        "statusCode": statusCode,
        "message": message,
      },
    ),
  );
}
