import 'package:mongo_dart/mongo_dart.dart';
import 'package:mongo_db_tut/mongo_db_tut.dart' as mongo_db_tut;

void main(List<String> arguments) async {
  Db db = Db('mongodb://localhost:27017/test');
  await db.open();

  print('connected to database successfully ;)');

  DbCollection peopleCollection = db.collection('people');

  // read people
  var people = await peopleCollection.find(where.eq('first_name', 'Calypso')).toList();
  people = await peopleCollection.find(where.match('first_name', 'B')).toList();
  people = await peopleCollection.find(where.match('first_name', 'a').limit(3)).toList();
  if (people.isNotEmpty) {
    print('found ${people.length} entries');
    print(people);
  } else {
    print('result was empty');
  }

  // find a single item in collection
  var person = await peopleCollection.findOne(
    where
        .match('first_name', 'i')
        .and(
          where.match('last_name', 'e'),
        )
        .and(
          where.gt('id', 26),
        ),
  );
  print('found person is $person');

  // query collection using javascript code
  person = await peopleCollection.findOne(where.jsQuery('''
  return this.first_name.startsWith('B')  && this.id > 40;
  '''));
  print('entry queries with js code $person');

  // add a new person to collection
  var result = await peopleCollection.insertOne({
    "id": 101,
    "first_name": "Shapoor",
    "last_name": "Shpoornejahd",
    "email": "shapoor@yandex.ru",
    "gender": "Unknown",
    "ip_address": "90.180.61.45",
  });

  print(
    'saved a new person with id ${result.id} and document is\n'
    '${result.document}\n'
    'modified = ${result.nModified}\n'
    'removed = ${result.nRemoved}\n'
    'inserted = ${result.nInserted}\n'
    'upserted = ${result.nUpserted}\n'
    'matched = ${result.nMatched}\n',
  );

  // to update we must first have the object then partially update the fields we need to update
  final updatePerson = await peopleCollection.update(
    await peopleCollection.findOne(where.eq('id', 101)),
    {
      r'$set': {
        'email': 'email@gmail.com',
        'gender': 'Female',
      },
    },
  );

  print('updated person result ${await peopleCollection.findOne(where.eq('id', 101))}');

  // remove item from collection
  await peopleCollection.remove(await peopleCollection.findOne(where.eq('id', 101)));

  print('is person deleted ??? OOOO, is this null??? ${await peopleCollection.findOne(where.eq('id', 101))}');
  // we need to close db otherwise dart process won't exit
  await db.close();
}
