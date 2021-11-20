import 'dart:convert';

import 'package:http/http.dart';
import 'package:rick_and_morty/models/api_response.dart';
import 'package:rick_and_morty/models/person.dart';

Future<ApiResponse> loadData() async {
  final Uri uri = Uri.http(
    'rickandmortyapi.com',
    'api/character',
  );
  late Map<String, dynamic> decodedData;
  final Response jsonResponse = await get(uri);
  if (jsonResponse.statusCode == 200) {
    final Map<String, dynamic> decodedData;
    try {
      decodedData = jsonDecode(jsonResponse.body) as Map<String, dynamic>;
    } catch (e) {
      return ApiResponse(
        isError: true,
        error: "Error: $e",
      );
    }
    try {
      return ApiResponse.fromJson(decodedData);
    } catch (e) {
      return ApiResponse(
        isError: true,
        error: "Error: $e",
      );
    }
  } else {
    return ApiResponse(
      isError: true,
      error: "Unexpected error occured!",
    );
  }
}
