import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:rick_and_morty/models/api_response.dart';
import 'package:rick_and_morty/models/person.dart';

Future<List<Person>?> getData(String path) async {
  try {
    final uri = Uri.http('rickandmortyapi.com', path);
    final http.Response response = await http.get(uri);
    final decodedData = jsonDecode(response.body);
    final ApiResponse<Person> api =
        ApiResponse.fromJson(decodedData as Map<String, dynamic>);
    if (api.results == null) {
      return [];
    } else {
      return api.results;
    }
  } catch (e) {
    throw Exception(e.toString());
  }
}
