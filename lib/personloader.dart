import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

class PersonDetails {
  String name = "";
  int id = 0;
  String avatar = "";
  String locationName = "";
  String locationUrl = "";
  String status = "";
  String species = "";
  String created = "";
  String type = "";
  String gender = "";
  String originName = "";
  String originUrl = "";
  List<String> episodes = [];
}

Future<PersonDetails> loadPerson(int id) async {
  final response = await http
      .get(Uri.parse("https://rickandmortyapi.com/api/character/$id"));
  PersonDetails person;

  final item = convert.jsonDecode(response.body);
  person = PersonDetails();
  person.id = item["id"] as int;
  person.name = item["name"] as String;
  person.avatar = item["image"] as String;
  person.locationName = item["location"]["name"] as String;
  person.locationUrl = item["location"]["url"] as String;
  person.status = item["status"] as String;
  person.species = item["species"] as String;
  person.created = item["created"] as String;
  person.gender = item["gender"] as String;
  person.type = item["type"] as String;
  person.originName = item["origin"]["name"] as String;
  person.originUrl = item["origin"]["url"] as String;
  //person.episodes = item["episode"].toList();

  // for (String episode in item["episode"]) {
  //   person.episodes.add(episode);
  // }
  return person;
}
