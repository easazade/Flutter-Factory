import 'dart:convert';
import 'package:shelf/shelf.dart';

Response createSuccessResponse({
  required int statusCode,
  required String message,
  required Map<String, dynamic> data,
}) {
  return Response(
    statusCode,
    headers: {"Content-Type": "application/json"},
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
    headers: {"Content-Type": "application/json"},
    body: jsonEncode(
      {
        "statusCode": statusCode,
        "message": message,
      },
    ),
  );
}
