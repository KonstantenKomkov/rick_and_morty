import 'package:json_annotation/json_annotation.dart';
import 'package:rick_and_morty/models/episode.dart';
import 'package:rick_and_morty/models/info.dart';
import 'package:rick_and_morty/models/location.dart';
import 'package:rick_and_morty/models/person.dart';

part 'api_response.g.dart';

@JsonSerializable()
class ApiResponse<T> {
  final Info info;

  @_Converter()
  final List<T>? results;

  ApiResponse({
    required this.info,
    this.results,
  });

  factory ApiResponse.fromJson(Map<String, dynamic> json) =>
      _$ApiResponseFromJson(json);
  Map<String, dynamic> toJson() => _$ApiResponseToJson(this);
}

class _Converter<T> implements JsonConverter<T, Object?> {
  const _Converter();

  @override
  T fromJson(Object? json) {
    if (json is Map<String, dynamic> && json.containsKey('gender')) {
      return Person.fromJson(json) as T;
    }
    if (json is Map<String, dynamic> && json.containsKey('dimension')) {
      return Location.fromJson(json) as T;
    }
    if (json is Map<String, dynamic> && json.containsKey('episode')) {
      return Episode.fromJson(json) as T;
    }
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
