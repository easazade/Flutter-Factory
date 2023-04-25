import 'package:stormberry/stormberry.dart';
import 'package:stormberry_orm_test/actions.dart';
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

  test('get post by custom query', () async {
    final postWithId = await db.posts.query(
      FindPostQuery(postId: 1),
      QueryParams(),
    );
    print(postWithId?.id);
    print(postWithId?.title);
    print(postWithId?.content);
  });

  test('update post by custom action ', () async {
    final postId = 1;
    var postWithId = await db.posts.query(
      FindPostQuery(postId: postId),
      QueryParams(),
    );

    print('title was = ${postWithId?.title}');

    final newTitle = postWithId?.title == '!!! TITLE - UPDATED' ? 'some other title - updated' : '!!! TITLE - UPDATED';

    await db.posts.run(UpdateTitleAction(title: newTitle), postWithId);

    postWithId = await db.posts.query(FindPostQuery(postId: postId), QueryParams());

    print('title changed to = ${postWithId?.title}');
  });
}
