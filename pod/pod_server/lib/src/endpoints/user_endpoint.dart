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

  Future<User?> getUserById(Session session, int id) async {
    final cacheKey = 'User-$id';

    var user = await session.caches.local.get<User>(cacheKey);

    if (user == null) {
      user = await session.db.findById<User>(id);
      if (user != null) {
        final profileImages = await ProfileImages.findSingleRow(session, where: (t) => t.userId.equals(id));
        user.profileImages = profileImages;
        await session.caches.local.put(cacheKey, user);
      } else {
        throw AppException(message: 'Could not find user with $id', type: ErrorType.wtf);
      }
    }

    return user;
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
