import 'package:dart_mongo/dart_mongo.dart' as dart_mongo;
import 'package:mongo_dart/mongo_dart.dart';
import 'dart:io';
import 'dart:convert';

main(List<String> arguments) async {
  /********************* DATABASE SETUP *************************/
  int port = 8085;
  var server = await HttpServer.bind('localhost', port);
  var db = Db('mongodb://localhost/test');
  await db.open();

  print('Connected to Database');

  var coll = db.collection('people');

  server.listen((HttpRequest request) async {
    switch (request.uri.path) {
      case '/':
        request.response.write('Hello World!');
        break;
      case '/people':
        if (request.method == 'GET') {
          request.response.write(await coll.find().toList());
        } else if (request.method == 'POST') {
          var content = await utf8.decoder.bind(request).join();
          var document = json.decode(content);
          await coll.save(document);
        } else if (request.method == 'PUT') {
          var id = int.parse(request.uri.queryParameters['id']);
          var content = await utf8.decoder.bind(request).join();
          var document = json.decode(content);
          var itemToReplace = await coll.findOne(where.eq('id', id));
        } else if (request.method == 'DELETE') {
          var id = int.parse(request.uri.queryParameters['id']);
          var itemToDelete = await coll.findOne(where.eq('id', id));
          await coll.remove(itemToDelete);
        } else if (request.method == 'PATCH') {
          var id = int.parse(request.uri.queryParameters['id']);
          var content = await utf8.decoder.bind(request).join();
          var document = json.decode(content);
          var itemToPatch = await coll.findOne(where.eq('id', id));
          await coll.update(itemToPatch, {
            r'$set': document,
          });
        }
        break;
      default:
        request.response
          ..statusCode = HttpStatus.notFound
          ..write('Not Found');
    }
    await request.response.close();
  });

  print('Server listening at http://localhost:$port');

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

  // await coll.insertAll([
  //   {
  //     'id': 101,
  //     'first_name': 'Brave',
  //     'last_name': 'Leuterio',
  //     'email': 'bleuterio@ft.com',
  //     'gender': 'Male',
  //     'ip_address': '63.90.69.20'
  //   },
  //   {
  //     'id': 102,
  //     'first_name': 'rom',
  //     'last_name': 'Leuterio',
  //     'email': 'romleuterio@ft.com',
  //     'gender': 'Male',
  //     'ip_address': '63.90.69.20'
  //   }
  // ]);

  /********************* UPDATE IN COLLECTION *************************/

  // await coll.update(await coll.findOne(where.eq('id', 101)), {
  //   r'$set' : {
  //     'first_name' : 'Braveheart'
  //   }
  // });

  // coll.update(where.eq('name', 'Daniel Robinson'), modify.set('age', 31));

  // print('Updated person');
  // print(await coll.findOne(where.eq('id', 101)));

  /********************* UPDATE IN COLLECTION *************************/

  // await coll.remove(await coll.findOne(where.eq('id', 101)));
  // print('Removed Person');

  // Remove all
  // await coll.remove();

  // print(await coll.findOne(where.eq('id', 101)));

  /********************* DATABASE CLOSEDOWN *************************/

  // await db.close();
}
