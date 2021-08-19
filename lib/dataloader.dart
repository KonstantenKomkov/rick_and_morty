import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:rick_and_morty/models/classes.dart';

Future<List<Person>?> getData(String path) async {
  try {
    final uri = Uri.http('rickandmortyapi.com', path);
    final http.Response response = await http.get(uri);
    final decodedData = jsonDecode(response.body);
    final ApiResponse api =
        ApiResponse.fromJson(decodedData as Map<String, dynamic>);
    print(api.results);
    return api.results!.cast<Person>();
  } catch (e) {
    throw Exception(e.toString());
  }
}

// Future<List<Person>?> getPersons(String path) async {
//   final ApiResponse api = await loadData(path);

//   if (api.results == null) {
//     return [];
//   } else {
//     print(api.results);
//     // final List<Person> persons = api.results!
//     //     .map((e) => Person.fromJson(e as Map<String, dynamic>))
//     //     .toList();
//     return [];
//   }
// }
