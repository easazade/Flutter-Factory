import 'package:serverpod/serverpod.dart';

class UserEndpoint extends Endpoint {
  Future<String> user(Session session, String name) async {
    session.log('called UserEndpoint user method');
    session.log('User signedIng = ${await session.isUserSignedIn}');
    return 'User is great $name';
  }
}
