import 'package:postgresql_db/postgresql_db.dart' as postgresql_db;
import 'package:postgres/postgres.dart';

void main(List<String> arguments) async {
  final connection = PostgreSQLConnection('localhost', 5432, 'postgres_dart', username: 'postgres', password: '1321');
  await connection.open();
  print('connected to postgres database');
}
