import 'package:pod_server/src/generated/protocol.dart';
import 'package:serverpod/serverpod.dart';

class UserEndpoint extends Endpoint {
  Future<String> user(Session session, String name) async {
    session.log('called UserEndpoint user method');
    session.log('User signedIng = ${await session.isUserSignedIn}');

    throw AppException(
      message: 'just throwing an exception to try serializable exceptions in serverpod',
      type: ErrorType.oops,
    );
  }
}
