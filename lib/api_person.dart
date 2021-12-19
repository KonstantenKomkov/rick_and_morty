import 'dart:convert';

import 'package:http/http.dart';
import 'package:rick_and_morty/models/api_response.dart';
import 'package:rick_and_morty/models/info.dart';

Future<ApiResponse> loadListData({
  bool? loadNextPage,
  Info? info,
}) async {
  late final Uri uri;

  if ((loadNextPage ?? false) && (info?.next != null)) {
    try {
      uri = Uri.parse(info!.next!);
    } catch (e) {
      return ApiResponse(
        isError: true,
        error: e.toString(),
      );
    }
  } else {
    uri = Uri.http(
      'rickandmortyapi.com',
      'api/character',
    );
  }

  final Response jsonResponse = await get(uri);
  if (jsonResponse.statusCode == 200) {
    try {
      final Map<String, dynamic> decodedData =
          jsonDecode(jsonResponse.body) as Map<String, dynamic>;

      final apiResponse = ApiResponse.fromJson(
        decodedData,
      );

      if (apiResponse.results == null) {
        return ApiResponse(
          info: apiResponse.info,
          results: [] as List,
          isError: false,
        );
      } else {
        return ApiResponse(
          info: apiResponse.info,
          results: apiResponse.results! as List<Map<String, dynamic>>,
          isError: false,
        );
      }
    } catch (e) {
      return ApiResponse(
        isError: true,
        error: e.toString(),
      );
    }
  } else {
    return ApiResponse(
      isError: true,
      error: "Unexpected error occured!",
    );
  }
}

Future<ApiResponse> loadObjectData({
  required int id,
}) async {
  final Uri uri = Uri.http(
    'rickandmortyapi.com',
    'api/character/$id',
  );

  final Response jsonResponse = await get(uri);
  if (jsonResponse.statusCode == 200) {
    try {
      final Map<String, dynamic> decodedData =
          jsonDecode(jsonResponse.body) as Map<String, dynamic>;
      return ApiResponse(
        results: decodedData,
        isError: false,
      );
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
