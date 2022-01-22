import 'package:shelf/shelf.dart';

const corsHeaders = {
  'Access-Control-Allow-Origin': '*',
  'Access-Control-Allow-Methods': 'GET, POST, PUT, DELETE',
  'Access-Control-Allow-Headers': 'Origin, Content-Type',
};

Middleware handleCors() {
  return createMiddleware(
    requestHandler: (request) {
      if (request.method == 'OPTIONS') {
        // browser will send  a preflight request to get these headers
        // and it will use it to determine whether to continue with the full details or not
        return Response.ok('', headers: corsHeaders);
      }
    },
    responseHandler: (response) {
      // intercepts all HttpResponses before going to user's client
      return response.change(headers: corsHeaders);
    },
  );
}
