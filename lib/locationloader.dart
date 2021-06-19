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
  location.id = item["id"];
  location.name = item["name"];
  location.type = item["type"];
  location.dimension = item["dimension"];
  location.url = item["url"];
  location.created = item["created"];
  for (String url in item["residents"]) {
    location.residents.add(url);
  }
  return location;
}
