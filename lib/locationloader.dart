import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

class LocationDetails {
  int id = 0;
  String name = "";
  String type = "";
  String dimension = "";
  List<String> residents = [];
  String url = "";
  String created = "";
}

Future<LocationDetails> loadLocation(String url) async {
  var response = await http.get(Uri.parse(url));
  LocationDetails location;

  var item = convert.jsonDecode(response.body);
  location = LocationDetails();
  location.id = item["id"] as int;
  location.name = item["name"] as String;
  location.type = item["type"] as String;
  location.dimension = item["dimension"] as String;
  location.url = item["url"] as String;
  location.created = item["created"] as String;
  for (final String url in item["residents"]) {
    location.residents.add(url);
  }
  return location;
}
