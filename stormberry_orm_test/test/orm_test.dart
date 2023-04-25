import 'package:stormberry/stormberry.dart';
import 'package:stormberry_orm_test/models.dart';
import 'package:stormberry_orm_test/utils.dart';
import 'package:test/test.dart';

void main() {
  late Database db;

  setUp(() {
    db = Database(
      host: envVar('DB_HOST_ADDRESS'),
      port: envIntVar('DB_PORT'),
      password: envVar('DB_PASSWORD'),
      user: envVar('DB_USERNAME'),
      database: envVar('DB_NAME'),
      useSSL: envBoolVar('DB_SSL'),
      isUnixSocket: envBoolVar('DB_SOCKET'),
    );
  });

  tearDown(() {});

  test('save and retrieve', () async {
    final userId = await db.users.insertOne(UserInsertRequest(name: 'alireza', bio: "I'm an awesome mobile developer"));

    final postId = await db.posts.insertOne(
      PostInsertRequest(
        title: 'title',
        content: 'content',
        authorId: userId,
      ),
    );
  });
}
