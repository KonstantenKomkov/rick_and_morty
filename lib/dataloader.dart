import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

class Person {
  int id = 0;
  String name = "";
  String status = "";
  String avatar = "";
}

Future<List<Person>> loadPersons() async {
  final response =
      await http.get(Uri.parse("https://rickandmortyapi.com/api/character"));
  final json = convert.jsonDecode(response.body);
  final List<dynamic> jsonPersons = json["results"] as List<dynamic>;
  final List<Person> results = [];

  for (final jsonPerson in jsonPersons) {
    final Person person = Person();
    person.id = jsonPerson["id"] as int;
    person.name = jsonPerson["name"] as String;
    person.status = jsonPerson["status"] as String;
    person.avatar = jsonPerson["image"] as String;
    results.add(person);
  }

  return results;
}
