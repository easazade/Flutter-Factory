import 'package:mongo_dart/mongo_dart.dart';
import 'package:mongo_db_tut/mongo_db_tut.dart' as mongo_db_tut;

void main(List<String> arguments) async {
  Db db = Db('mongodb://localhost:27017/test');
  await db.open();

  print('connected to database successfully ;)');

  DbCollection peopleCollection = db.collection('people');

  // read people
  final people = await peopleCollection.find().toList();
  if (people.isNotEmpty) {
    print(people.first);
  } else {
    print('there is not people in collection in database');
  }

  // we need to close db otherwise dart process won't exit
  await db.close();
}
