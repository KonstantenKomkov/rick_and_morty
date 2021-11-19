import 'dart:convert';

import 'package:http/http.dart';
import 'package:rick_and_morty/models/api_response.dart';
import 'package:rick_and_morty/models/person.dart';

Future<List<Person>> loadPersons() async {
  final Uri uri = Uri.http(
    'rickandmortyapi.com',
    'api/character',
  );
  final Response jsonResponse = await get(uri);
  if (jsonResponse.statusCode == 200) {
    final Map<String, dynamic> decodedData =
        jsonDecode(jsonResponse.body) as Map<String, dynamic>;
    final ApiResponse apiResponse = ApiResponse.fromJson(decodedData);
    if (apiResponse.results == null) {
      return [];
    }
    return apiResponse.results!
        .map((person) => Person.fromJson(person as Map<String, dynamic>))
        .toList();
  } else {
    throw Exception('Unexpected error occured!');
  }
}
