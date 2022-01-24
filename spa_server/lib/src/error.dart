import 'dart:convert';
import 'package:shelf/shelf.dart';

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
