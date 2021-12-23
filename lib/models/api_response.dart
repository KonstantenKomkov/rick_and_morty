import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
import 'package:rick_and_morty/models/info.dart';

part 'api_response.g.dart';

@JsonSerializable()
class ApiResponse<T> {
  final Info? info;
  @_Converter()
  T? results;
  @JsonKey(
    ignore: true,
  )
  String? error;
  bool get isError => _isError(error);

  bool _isError(String? error) {
    if (error == null) {
      return false;
    } else {
      return true;
    }
  }

  ApiResponse({
    this.info,
    this.results,
    this.error,
  });

  factory ApiResponse.fromJson(Map<String, dynamic> json) =>
      _$ApiResponseFromJson(json);
  Map<String, dynamic> toJson() => _$ApiResponseToJson(this);
}

class _Converter<T> implements JsonConverter<T, Object?> {
  const _Converter();

  @override
  T fromJson(Object? json) {
    if (json is List) {
      return List as T;
    }
    // if (json is Map<String, dynamic>) {
    //   return jsonDecode(json) as T;
    // }
    // if (json is List<Map<String, dynamic>>) {
    //   return json.map((element) => jsonDecode(element as String)).toList() as T;
    // }
    // if (json is Map<String, dynamic> && json.containsKey('episode')) {
    //   return Episode.fromJson(json) as T;
    // }
    // This will only work if `json` is a native JSON type:
    // num, String, bool, null, etc
    // *and* is assignable to `T`.
    return json as T;
  }

  @override
  // This will only work if `object` is a native JSON type:
  //   num, String, bool, null, etc
  // Or if it has a `toJson()` function`.
  Object? toJson(T object) => object;
}
