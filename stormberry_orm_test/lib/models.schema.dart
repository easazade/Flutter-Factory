// ignore_for_file: annotate_overrides

part of 'models.dart';

extension ModelsRepositories on Database {
  PostRepository get posts => PostRepository._(this);
  UserRepository get users => UserRepository._(this);
  MeetingRepository get meetings => MeetingRepository._(this);
}

abstract class PostRepository
    implements
        ModelRepository,
        KeyedModelRepositoryInsert<PostInsertRequest>,
        ModelRepositoryUpdate<PostUpdateRequest>,
        ModelRepositoryDelete<int> {
  factory PostRepository._(Database db) = _PostRepository;

  Future<CompletePostPostView?> queryCompletePostView(int id);
  Future<List<CompletePostPostView>> queryCompletePostViews([QueryParams? params]);
  Future<ReducedPostPostView?> queryReducedPostView(int id);
  Future<List<ReducedPostPostView>> queryReducedPostViews([QueryParams? params]);
}

class _PostRepository extends BaseRepository
    with
        KeyedRepositoryInsertMixin<PostInsertRequest>,
        RepositoryUpdateMixin<PostUpdateRequest>,
        RepositoryDeleteMixin<int>
    implements PostRepository {
  _PostRepository(super.db) : super(tableName: 'posts', keyName: 'id');

  @override
  Future<CompletePostPostView?> queryCompletePostView(int id) {
    return queryOne(id, CompletePostPostViewQueryable());
  }

  @override
  Future<List<CompletePostPostView>> queryCompletePostViews([QueryParams? params]) {
    return queryMany(CompletePostPostViewQueryable(), params);
  }

  @override
  Future<ReducedPostPostView?> queryReducedPostView(int id) {
    return queryOne(id, ReducedPostPostViewQueryable());
  }

  @override
  Future<List<ReducedPostPostView>> queryReducedPostViews([QueryParams? params]) {
    return queryMany(ReducedPostPostViewQueryable(), params);
  }

  @override
  Future<List<int>> insert(List<PostInsertRequest> requests) async {
    if (requests.isEmpty) return [];
    var values = QueryValues();
    var rows = await db.query(
      'INSERT INTO "posts" ( "title", "content", "author_id", "editor_id" )\n'
      'VALUES ${requests.map((r) => '( ${values.add(r.title)}:text, ${values.add(r.content)}:text, ${values.add(r.authorId)}:int8, ${values.add(r.editorId)}:int8 )').join(', ')}\n'
      'RETURNING "id"',
      values.values,
    );
    var result = rows.map<int>((r) => TextEncoder.i.decode(r.toColumnMap()['id'])).toList();

    return result;
  }

  @override
  Future<void> update(List<PostUpdateRequest> requests) async {
    if (requests.isEmpty) return;
    var values = QueryValues();
    await db.query(
      'UPDATE "posts"\n'
      'SET "title" = COALESCE(UPDATED."title", "posts"."title"), "content" = COALESCE(UPDATED."content", "posts"."content"), "author_id" = COALESCE(UPDATED."author_id", "posts"."author_id"), "editor_id" = COALESCE(UPDATED."editor_id", "posts"."editor_id")\n'
      'FROM ( VALUES ${requests.map((r) => '( ${values.add(r.id)}:int8::int8, ${values.add(r.title)}:text::text, ${values.add(r.content)}:text::text, ${values.add(r.authorId)}:int8::int8, ${values.add(r.editorId)}:int8::int8 )').join(', ')} )\n'
      'AS UPDATED("id", "title", "content", "author_id", "editor_id")\n'
      'WHERE "posts"."id" = UPDATED."id"',
      values.values,
    );
  }
}

abstract class UserRepository
    implements
        ModelRepository,
        KeyedModelRepositoryInsert<UserInsertRequest>,
        ModelRepositoryUpdate<UserUpdateRequest>,
        ModelRepositoryDelete<int> {
  factory UserRepository._(Database db) = _UserRepository;

  Future<CompleteUserUserView?> queryCompleteUserView(int id);
  Future<List<CompleteUserUserView>> queryCompleteUserViews([QueryParams? params]);
  Future<ReducedUserUserView?> queryReducedUserView(int id);
  Future<List<ReducedUserUserView>> queryReducedUserViews([QueryParams? params]);
}

class _UserRepository extends BaseRepository
    with
        KeyedRepositoryInsertMixin<UserInsertRequest>,
        RepositoryUpdateMixin<UserUpdateRequest>,
        RepositoryDeleteMixin<int>
    implements UserRepository {
  _UserRepository(super.db) : super(tableName: 'users', keyName: 'id');

  @override
  Future<CompleteUserUserView?> queryCompleteUserView(int id) {
    return queryOne(id, CompleteUserUserViewQueryable());
  }

  @override
  Future<List<CompleteUserUserView>> queryCompleteUserViews([QueryParams? params]) {
    return queryMany(CompleteUserUserViewQueryable(), params);
  }

  @override
  Future<ReducedUserUserView?> queryReducedUserView(int id) {
    return queryOne(id, ReducedUserUserViewQueryable());
  }

  @override
  Future<List<ReducedUserUserView>> queryReducedUserViews([QueryParams? params]) {
    return queryMany(ReducedUserUserViewQueryable(), params);
  }

  @override
  Future<List<int>> insert(List<UserInsertRequest> requests) async {
    if (requests.isEmpty) return [];
    var values = QueryValues();
    var rows = await db.query(
      'INSERT INTO "users" ( "name", "bio" )\n'
      'VALUES ${requests.map((r) => '( ${values.add(r.name)}:text, ${values.add(r.bio)}:text )').join(', ')}\n'
      'RETURNING "id"',
      values.values,
    );
    var result = rows.map<int>((r) => TextEncoder.i.decode(r.toColumnMap()['id'])).toList();

    return result;
  }

  @override
  Future<void> update(List<UserUpdateRequest> requests) async {
    if (requests.isEmpty) return;
    var values = QueryValues();
    await db.query(
      'UPDATE "users"\n'
      'SET "name" = COALESCE(UPDATED."name", "users"."name"), "bio" = COALESCE(UPDATED."bio", "users"."bio")\n'
      'FROM ( VALUES ${requests.map((r) => '( ${values.add(r.id)}:int8::int8, ${values.add(r.name)}:text::text, ${values.add(r.bio)}:text::text )').join(', ')} )\n'
      'AS UPDATED("id", "name", "bio")\n'
      'WHERE "users"."id" = UPDATED."id"',
      values.values,
    );
  }
}

abstract class MeetingRepository
    implements
        ModelRepository,
        KeyedModelRepositoryInsert<MeetingInsertRequest>,
        ModelRepositoryUpdate<MeetingUpdateRequest>,
        ModelRepositoryDelete<int> {
  factory MeetingRepository._(Database db) = _MeetingRepository;

  Future<MeetingView?> queryMeeting(int id);
  Future<List<MeetingView>> queryMeetings([QueryParams? params]);
}

class _MeetingRepository extends BaseRepository
    with
        KeyedRepositoryInsertMixin<MeetingInsertRequest>,
        RepositoryUpdateMixin<MeetingUpdateRequest>,
        RepositoryDeleteMixin<int>
    implements MeetingRepository {
  _MeetingRepository(super.db) : super(tableName: 'meetings_all', keyName: 'id');

  @override
  Future<MeetingView?> queryMeeting(int id) {
    return queryOne(id, MeetingViewQueryable());
  }

  @override
  Future<List<MeetingView>> queryMeetings([QueryParams? params]) {
    return queryMany(MeetingViewQueryable(), params);
  }

  @override
  Future<List<int>> insert(List<MeetingInsertRequest> requests) async {
    if (requests.isEmpty) return [];
    var values = QueryValues();
    var rows = await db.query(
      'INSERT INTO "meetings_all" ( "location" )\n'
      'VALUES ${requests.map((r) => '( ${values.add(LatLngConverter().tryEncode(r.location))}:point )').join(', ')}\n'
      'RETURNING "id"',
      values.values,
    );
    var result = rows.map<int>((r) => TextEncoder.i.decode(r.toColumnMap()['id'])).toList();

    return result;
  }

  @override
  Future<void> update(List<MeetingUpdateRequest> requests) async {
    if (requests.isEmpty) return;
    var values = QueryValues();
    await db.query(
      'UPDATE "meetings_all"\n'
      'SET "location" = COALESCE(UPDATED."location", "meetings_all"."location")\n'
      'FROM ( VALUES ${requests.map((r) => '( ${values.add(r.id)}:int8::int8, ${values.add(LatLngConverter().tryEncode(r.location))}:point::point )').join(', ')} )\n'
      'AS UPDATED("id", "location")\n'
      'WHERE "meetings_all"."id" = UPDATED."id"',
      values.values,
    );
  }
}

class PostInsertRequest {
  PostInsertRequest({
    required this.title,
    required this.content,
    required this.authorId,
    this.editorId,
  });

  final String title;
  final String content;
  final int authorId;
  final int? editorId;
}

class UserInsertRequest {
  UserInsertRequest({
    required this.name,
    required this.bio,
  });

  final String name;
  final String bio;
}

class MeetingInsertRequest {
  MeetingInsertRequest({
    required this.location,
  });

  final LatLng location;
}

class PostUpdateRequest {
  PostUpdateRequest({
    required this.id,
    this.title,
    this.content,
    this.authorId,
    this.editorId,
  });

  final int id;
  final String? title;
  final String? content;
  final int? authorId;
  final int? editorId;
}

class UserUpdateRequest {
  UserUpdateRequest({
    required this.id,
    this.name,
    this.bio,
  });

  final int id;
  final String? name;
  final String? bio;
}

class MeetingUpdateRequest {
  MeetingUpdateRequest({
    required this.id,
    this.location,
  });

  final int id;
  final LatLng? location;
}

class CompletePostPostViewQueryable extends KeyedViewQueryable<CompletePostPostView, int> {
  @override
  String get keyName => 'id';

  @override
  String encodeKey(int key) => TextEncoder.i.encode(key);

  @override
  String get query =>
      'SELECT "posts".*, row_to_json("author".*) as "author", row_to_json("editor".*) as "editor"'
      'FROM "posts"'
      'LEFT JOIN (${ReducedUserUserViewQueryable().query}) "author"'
      'ON "posts"."author_id" = "author"."id"'
      'LEFT JOIN (${ReducedUserUserViewQueryable().query}) "editor"'
      'ON "posts"."editor_id" = "editor"."id"';

  @override
  String get tableAlias => 'posts';

  @override
  CompletePostPostView decode(TypedMap map) => CompletePostPostView(
      id: map.get('id'),
      title: map.get('title'),
      content: map.get('content'),
      author: map.get('author', ReducedUserUserViewQueryable().decoder),
      editor: map.getOpt('editor', ReducedUserUserViewQueryable().decoder));
}

class CompletePostPostView {
  CompletePostPostView({
    required this.id,
    required this.title,
    required this.content,
    required this.author,
    this.editor,
  });

  final int id;
  final String title;
  final String content;
  final ReducedUserUserView author;
  final ReducedUserUserView? editor;
}

class ReducedPostPostViewQueryable extends KeyedViewQueryable<ReducedPostPostView, int> {
  @override
  String get keyName => 'id';

  @override
  String encodeKey(int key) => TextEncoder.i.encode(key);

  @override
  String get query => 'SELECT "posts".*'
      'FROM "posts"';

  @override
  String get tableAlias => 'posts';

  @override
  ReducedPostPostView decode(TypedMap map) =>
      ReducedPostPostView(id: map.get('id'), title: map.get('title'), content: map.get('content'));
}

class ReducedPostPostView {
  ReducedPostPostView({
    required this.id,
    required this.title,
    required this.content,
  });

  final int id;
  final String title;
  final String content;
}

class CompleteUserUserViewQueryable extends KeyedViewQueryable<CompleteUserUserView, int> {
  @override
  String get keyName => 'id';

  @override
  String encodeKey(int key) => TextEncoder.i.encode(key);

  @override
  String get query => 'SELECT "users".*, "posts"."data" as "posts"'
      'FROM "users"'
      'LEFT JOIN ('
      '  SELECT "posts"."author_id",'
      '    to_jsonb(array_agg("posts".*)) as data'
      '  FROM (${ReducedPostPostViewQueryable().query}) "posts"'
      '  GROUP BY "posts"."author_id"'
      ') "posts"'
      'ON "users"."id" = "posts"."author_id"';

  @override
  String get tableAlias => 'users';

  @override
  CompleteUserUserView decode(TypedMap map) => CompleteUserUserView(
      id: map.get('id'),
      name: map.get('name'),
      bio: map.get('bio'),
      posts: map.getListOpt('posts', ReducedPostPostViewQueryable().decoder) ?? const []);
}

class CompleteUserUserView {
  CompleteUserUserView({
    required this.id,
    required this.name,
    required this.bio,
    required this.posts,
  });

  final int id;
  final String name;
  final String bio;
  final List<ReducedPostPostView> posts;
}

class ReducedUserUserViewQueryable extends KeyedViewQueryable<ReducedUserUserView, int> {
  @override
  String get keyName => 'id';

  @override
  String encodeKey(int key) => TextEncoder.i.encode(key);

  @override
  String get query => 'SELECT "users".*'
      'FROM "users"';

  @override
  String get tableAlias => 'users';

  @override
  ReducedUserUserView decode(TypedMap map) =>
      ReducedUserUserView(id: map.get('id'), name: map.get('name'), bio: map.get('bio'));
}

class ReducedUserUserView {
  ReducedUserUserView({
    required this.id,
    required this.name,
    required this.bio,
  });

  final int id;
  final String name;
  final String bio;
}

class MeetingViewQueryable extends KeyedViewQueryable<MeetingView, int> {
  @override
  String get keyName => 'id';

  @override
  String encodeKey(int key) => TextEncoder.i.encode(key);

  @override
  String get query => 'SELECT "meetings_all".*'
      'FROM "meetings_all"';

  @override
  String get tableAlias => 'meetings_all';

  @override
  MeetingView decode(TypedMap map) =>
      MeetingView(id: map.get('id'), location: map.get('location', LatLngConverter().decode));
}

class MeetingView {
  MeetingView({
    required this.id,
    required this.location,
  });

  final int id;
  final LatLng location;
}
