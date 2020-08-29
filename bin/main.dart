import 'package:dart_mongo/dart_mongo.dart' as dart_mongo;
import 'package:mongo_dart/mongo_dart.dart';

main(List<String> arguments) async {
  /********************* DATABASE SETUP *************************/
  var db = Db('mongodb://localhost/test');
  await db.open();

  print('Connected to Database');

  var coll = db.collection('people');

  /********************* QUERY IN COLLECTION *************************/

  // var people = await coll.find().toList();
  // print(people);

  // var specificPerson =
  //     await coll.find(where.eq('first_name', 'Calypso')).toList();
  // print(specificPerson);

  // var specificPersonWithB =
  //     await coll.find(where.match('first_name', 'B')).toList();
  // print(specificPersonWithB);

  // var limitFivePeople = await coll.find(where.limit(5)).toList();
  // print(limitFivePeople);

  // var personWithB = await coll.findOne(where.match('first_name', 'B'));
  // print(personWithB);

  // var personWithBAndIdGreaterThanForty = await coll
  //     // .findOne(where.match('first_name', 'B').and(where.gt('id', 40)));
  //     .findOne(where.match('first_name', 'B').gt('id', 40));
  // print(personWithBAndIdGreaterThanForty);

  // var person = await coll.findOne(where.jsQuery('''
  //     return this.first_name.startsWith('B');
  //     '''));
  // print(person);

  // var femalePerson = await coll.findOne(where.jsQuery('''
  //     return this.first_name.startsWith('B') && this.gender == 'Female';
  //     '''));
  // print(femalePerson);

  /********************* ADD IN COLLECTION *************************/

  // await coll.save({
  //   'id': 101,
  //   'first_name': 'Brave',
  //   'last_name': 'Leuterio',
  //   'email': 'bleuterio@ft.com',
  //   'gender': 'Male',
  //   'ip_address': '63.90.69.20'
  // });

  // print('Saved new person');

  /********************* UPDATE IN COLLECTION *************************/

  // await coll.update(await coll.findOne(where.eq('id', 101)), {
  //   r'$set' : {
  //     'first_name' : 'Braveheart'
  //   }
  // });

  // print('Updated person');
  // print(await coll.findOne(where.eq('id', 101)));

  /********************* UPDATE IN COLLECTION *************************/

  // await coll.remove(await coll.findOne(where.eq('id', 101)));
  // print('Removed Person');
  
  // print(await coll.findOne(where.eq('id', 101)));

  /********************* DATABASE CLOSEDOWN *************************/

  await db.close();
}
