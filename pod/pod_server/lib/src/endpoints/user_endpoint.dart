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

  Future<User> createUser(Session session, String username) async {
    // ideally we want to do this in a transaction using session.db.transaction

    final user = User(
      username: username,
      password: 'not how we do this',
      preferences: ['cats', 'dogs', 'rainbows'],
    );

    await User.insert(session, user);

    final profileImages = ProfileImages(userId: user.id!);

    ProfileImages.insert(session, profileImages);

    return user..profileImages = profileImages;
  }
}
