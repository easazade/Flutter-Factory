import 'dart:convert';
import 'dart:io';
import 'package:shelf/shelf.dart';

Response createSuccessResponse({
  int statusCode = 200,
  String message = 'success',
  dynamic data,
}) {
  if (data != null) {
    if (data is! List && data is! Map) {
      throw Exception(
          'the data argument can only be a Map or List that can be serialized to json');
    }
  }
  return Response(
    statusCode,
    headers: {HttpHeaders.contentTypeHeader: ContentType.json.mimeType},
    body: jsonEncode(
      {
        "statusCode": statusCode,
        "message": message,
        if (data != null) "data": data,
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
