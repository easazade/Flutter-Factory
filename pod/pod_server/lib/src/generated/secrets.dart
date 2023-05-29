/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: public_member_api_docs
// ignore_for_file: implementation_imports

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod/serverpod.dart' as _i1;

class Secret extends _i1.TableRow {
  Secret({
    int? id,
    required this.phrase,
    required this.publicKey,
    this.privateKey,
  }) : super(id);

  factory Secret.fromJson(
    Map<String, dynamic> jsonSerialization,
    _i1.SerializationManager serializationManager,
  ) {
    return Secret(
      id: serializationManager.deserialize<int?>(jsonSerialization['id']),
      phrase:
          serializationManager.deserialize<String>(jsonSerialization['phrase']),
      publicKey: serializationManager
          .deserialize<String>(jsonSerialization['publicKey']),
      privateKey: serializationManager
          .deserialize<String?>(jsonSerialization['privateKey']),
    );
  }

  static final t = SecretTable();

  String phrase;

  String publicKey;

  String? privateKey;

  @override
  String get tableName => 'secrets';
  @override
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'phrase': phrase,
      'publicKey': publicKey,
      'privateKey': privateKey,
    };
  }

  @override
  Map<String, dynamic> toJsonForDatabase() {
    return {
      'id': id,
      'phrase': phrase,
      'publicKey': publicKey,
      'privateKey': privateKey,
    };
  }

  @override
  Map<String, dynamic> allToJson() {
    return {
      'id': id,
      'phrase': phrase,
      'publicKey': publicKey,
      'privateKey': privateKey,
    };
  }

  @override
  void setColumn(
    String columnName,
    value,
  ) {
    switch (columnName) {
      case 'id':
        id = value;
        return;
      case 'phrase':
        phrase = value;
        return;
      case 'publicKey':
        publicKey = value;
        return;
      case 'privateKey':
        privateKey = value;
        return;
      default:
        throw UnimplementedError();
    }
  }

  static Future<List<Secret>> find(
    _i1.Session session, {
    SecretExpressionBuilder? where,
    int? limit,
    int? offset,
    _i1.Column? orderBy,
    List<_i1.Order>? orderByList,
    bool orderDescending = false,
    bool useCache = true,
    _i1.Transaction? transaction,
  }) async {
    return session.db.find<Secret>(
      where: where != null ? where(Secret.t) : null,
      limit: limit,
      offset: offset,
      orderBy: orderBy,
      orderByList: orderByList,
      orderDescending: orderDescending,
      useCache: useCache,
      transaction: transaction,
    );
  }

  static Future<Secret?> findSingleRow(
    _i1.Session session, {
    SecretExpressionBuilder? where,
    int? offset,
    _i1.Column? orderBy,
    bool orderDescending = false,
    bool useCache = true,
    _i1.Transaction? transaction,
  }) async {
    return session.db.findSingleRow<Secret>(
      where: where != null ? where(Secret.t) : null,
      offset: offset,
      orderBy: orderBy,
      orderDescending: orderDescending,
      useCache: useCache,
      transaction: transaction,
    );
  }

  static Future<Secret?> findById(
    _i1.Session session,
    int id,
  ) async {
    return session.db.findById<Secret>(id);
  }

  static Future<int> delete(
    _i1.Session session, {
    required SecretExpressionBuilder where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<Secret>(
      where: where(Secret.t),
      transaction: transaction,
    );
  }

  static Future<bool> deleteRow(
    _i1.Session session,
    Secret row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow(
      row,
      transaction: transaction,
    );
  }

  static Future<bool> update(
    _i1.Session session,
    Secret row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.update(
      row,
      transaction: transaction,
    );
  }

  static Future<void> insert(
    _i1.Session session,
    Secret row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert(
      row,
      transaction: transaction,
    );
  }

  static Future<int> count(
    _i1.Session session, {
    SecretExpressionBuilder? where,
    int? limit,
    bool useCache = true,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<Secret>(
      where: where != null ? where(Secret.t) : null,
      limit: limit,
      useCache: useCache,
      transaction: transaction,
    );
  }
}

typedef SecretExpressionBuilder = _i1.Expression Function(SecretTable);

class SecretTable extends _i1.Table {
  SecretTable() : super(tableName: 'secrets');

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  final id = _i1.ColumnInt('id');

  final phrase = _i1.ColumnString('phrase');

  final publicKey = _i1.ColumnString('publicKey');

  final privateKey = _i1.ColumnString('privateKey');

  @override
  List<_i1.Column> get columns => [
        id,
        phrase,
        publicKey,
        privateKey,
      ];
}

@Deprecated('Use SecretTable.t instead.')
SecretTable tSecret = SecretTable();
