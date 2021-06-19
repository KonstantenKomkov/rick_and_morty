import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class Person {
  int id = 0;
  String name = "";
  String status = "";
  String avatar = "";
}

Future<List<Person>> loadPersons() async {
  var response =
      await http.get(Uri.parse("https://rickandmortyapi.com/api/character"));
  var json = convert.jsonDecode(response.body);
  List<dynamic> jsonPersons = json["results"];
  List<Person> results = [];

  for (var jsonPerson in jsonPersons) {
    Person person = Person();
    person.id = jsonPerson["id"];
    person.name = jsonPerson["name"];
    person.status = jsonPerson["status"];
    person.avatar = jsonPerson["image"];
    results.add(person);
  }

  return results;
}
