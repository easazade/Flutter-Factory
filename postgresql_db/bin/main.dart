import 'dart:convert';
import 'dart:io';

import 'package:postgresql_db/postgresql_db.dart' as postgresql_db;
import 'package:postgres/postgres.dart';

void main(List<String> arguments) async {
  final connection = PostgreSQLConnection('localhost', 5432, 'postgres_dart', username: 'postgres', password: '1321');
  await connection.open();
  print('connected to postgres database');

  // create a table orders
  // await connection.query('''
  // CREATE TABLE orders(
  //   id serial primary key not null,
  //   order_id int not null,
  //   customer_id int not null,
  //   order_date date
  // )
  // ''');

  // create a table customers
  // await connection.query('''
  // CREATE TABLE customers(
  //   id serial primary key not null,
  //   name text,
  //   email text,
  //   address text,
  //   country text
  // )
  // ''');

  // insert new rows to database

  await connection.query('''
  INSERT INTO customers (name, email, address, country)
  VALUES ('Alireza Easazade', 'easazade@gmail.com', 'Rasht City', 'Iran')
  ''');

  await connection.query('''
  INSERT INTO customers (name, email, address, country)
  VALUES ('Ahmad Azizi', 'ahmad@gmail.com', 'Rasht City', 'Iran')
  ''');

  // read data
  final readResults = await connection.mappedResultsQuery('SELECT * FROM customers');
  print(readResults);

  // update data
  //NOTE: use double quotation mark to wrap the query and use single quotation mark inside it
  await connection.query("UPDATE customers SET country='Japan' WHERE id=1");
  // delete data
  await connection.query('DELETE FROM customers WHERE id > 8');

  // insert our fake data into database
  await _insertFakeCustomersInDatabase(connection, doAllInsertionsInOneTransaction: true);
  await _insertFakeOrdersInDatabase(connection, doAllInsertionsInOneTransaction: true);

  // do a join query
  var joinResult = await connection.mappedResultsQuery('''
  SELECT customers.name, orders.order_id
  from customers
  LEFT JOIN orders on customers.id = orders.customer_id
  ORDER BY customers.name
  ''');
  print('############ join result ##############');
  print(joinResult);

  // if we don't close connection process won't stop
  await connection.close();
}

/// ################################# functions ######################################
/// ################################# functions ######################################
/// ################################# functions ######################################
/// ################################# functions ######################################
/// ################################# functions ######################################
/// ################################# functions ######################################
/// ################################# functions ######################################
/// ################################# functions ######################################
/// ################################# functions ######################################

Future _insertFakeCustomersInDatabase(
  PostgreSQLConnection connection, {
  bool doAllInsertionsInOneTransaction = true,
}) async {
  final jsonStr = await File('mock_customers.json').readAsString();
  final jsonArray = jsonDecode(jsonStr);

  final mockDataStream = Stream.fromIterable(jsonArray);

  Future doInsertions(PostgreSQLExecutionContext connectionContext) async {
    await for (var json in mockDataStream) {
      // we can use string substitution instead string interpolation
      await connectionContext.query('''
    INSERT INTO customers (name, email, address, country)
    VALUES (@name, @email, @address, @country)
    ''', substitutionValues: {
        'name': json['name'],
        'email': json['email'],
        'address': json['address'],
        'country': json['country'],
      });
    }
  }

  if (doAllInsertionsInOneTransaction) {
    await connection.transaction((ctx) async {
      await doInsertions(ctx);
    });
  } else {
    await doInsertions(connection);
  }
}

Future _insertFakeOrdersInDatabase(
  PostgreSQLConnection connection, {
  bool doAllInsertionsInOneTransaction = true,
}) async {
  final jsonStr = await File('mock_orders.json').readAsString();
  final jsonArray = jsonDecode(jsonStr);

  final mockDataStream = Stream.fromIterable(jsonArray);

  Future doInsertions(PostgreSQLExecutionContext connectionContext) async {
    await for (var json in mockDataStream) {
      // we can use string substitution instead string interpolation
      await connectionContext.query('''
    INSERT INTO orders (order_id, customer_id, order_date)
    VALUES (@order_id, @customer_id, @order_date)
    ''', substitutionValues: {
        'order_id': json['order_id'],
        'customer_id': json['customer_id'],
        'order_date': json['order_date'],
      });
    }
  }

  if (doAllInsertionsInOneTransaction) {
    await connection.transaction((ctx) async {
      await doInsertions(ctx);
    });
  } else {
    await doInsertions(connection);
  }
}
