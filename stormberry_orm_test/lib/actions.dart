import 'package:stormberry/stormberry.dart';
import 'package:stormberry_orm_test/models.dart';

class UpdateTitleAction extends Action<ReducedPostPostView> {
  final String title;

  UpdateTitleAction({required this.title});

  @override
  Future<void> apply(Database db, ReducedPostPostView request) async {
    await db.query("""
      UPDATE posts
      SET title = '$title'
      WHERE id = ${request.id}
""");
  }
}

class FindPostQuery extends Query<ReducedPostPostView?, QueryParams> {
  final int postId;

  FindPostQuery({required this.postId});

  @override
  Future<ReducedPostPostView?> apply(Database db, QueryParams params) async {
    final queryable = ReducedPostPostViewQueryable();

    var postgreSQLResult = await db.query("""
      SELECT * FROM (${queryable.query}) "${queryable.tableAlias}"
      WHERE id=$postId 
      ${params.orderBy != null ? "ORDER BY ${params.orderBy}" : ""}
      ${params.limit != null ? "LIMIT ${params.limit}" : ""}
      ${params.offset != null ? "OFFSET ${params.offset}" : ""}
    """, params.values);

    var objects = postgreSQLResult.map((row) => queryable.decode(TypedMap(row.toColumnMap()))).toList();
    return objects.isNotEmpty ? objects.first : null;
  }
}
