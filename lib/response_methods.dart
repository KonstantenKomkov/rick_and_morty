import 'dart:convert';

import 'package:http/http.dart';
import 'package:rick_and_morty/config.dart';
import 'package:rick_and_morty/models/api_response.dart';
import 'package:rick_and_morty/models/info.dart';

Future<ApiResponse> getListData({
  required String undecodedPath,
  Map<String, dynamic>? queryParameters,
  bool? loadNextPage,
  Info? info,
}) async {
  late final Uri uri;

  if ((loadNextPage ?? false) && (info?.next != null)) {
    try {
      uri = Uri.parse(info!.next!);
    } catch (e) {
      return ApiResponse(
        error: e.toString(),
      );
    }
  } else {
    uri = Uri.http(
      url,
      undecodedPath,
    );
  }

  final Response jsonResponse = await get(uri);
  if (jsonResponse.statusCode == 200) {
    try {
      final Map<String, dynamic> decodedData =
          jsonDecode(jsonResponse.body) as Map<String, dynamic>;

      final ApiResponse<List<dynamic>> apiResponse = ApiResponse.fromJson(
        decodedData,
      ) as ApiResponse<List<dynamic>>;

      if (apiResponse.results is Type) {
        print("It's List");
      }

      print("ApiResponse.results type is - ${apiResponse.results.runtimeType}");
      if (apiResponse.results == null) {
        return ApiResponse(
          info: apiResponse.info,
          results: [],
        );
      } else {
        print(
            "ApiResponse.results type is - ${apiResponse.results.runtimeType}");
        return ApiResponse(
          info: apiResponse.info,
          results: apiResponse.results,
        );
      }
    } catch (e) {
      print(e);
      return ApiResponse(
        error: e.toString(),
      );
    }
  } else {
    return ApiResponse(
      error: "Unexpected error occured!",
    );
  }
}

Future<ApiResponse> getObjectData({
  required String undecodedPath,
  Map<String, dynamic>? queryParameters,
}) async {
  final Uri uri = Uri.http(
    url,
    undecodedPath,
  );

  final Response jsonResponse = await get(uri);
  if (jsonResponse.statusCode == 200) {
    try {
      final Map<String, dynamic> decodedData =
          jsonDecode(jsonResponse.body) as Map<String, dynamic>;
      return ApiResponse(
        results: decodedData,
      );
    } catch (e) {
      return ApiResponse(
        error: "Error: $e",
      );
    }
  } else {
    return ApiResponse(
      error: "Unexpected error occured!",
    );
  }
}
