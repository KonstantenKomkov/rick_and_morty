import 'package:json_annotation/json_annotation.dart';

part 'classes.g.dart';

@JsonSerializable()
class Episode {
  final int id;
  final String name;

  @JsonKey(name: 'air_date')
  final String airDate;

  final String episode;
  final List<String> characters;
  final String url;
  final String created;

  Episode({
    required this.id,
    required this.name,
    required this.airDate,
    required this.episode,
    required this.characters,
    required this.url,
    required this.created,
  });

  factory Episode.fromJson(Map<String, dynamic> json) =>
      _$EpisodeFromJson(json);
  Map<String, dynamic> toJson() => _$EpisodeToJson(this);
}

@JsonSerializable()
class Location {
  final int? id;
  final String name;
  final String? type;
  final String? dimension;
  final List<String>? residents;
  final String url;
  final String? created;

  Location({
    this.id,
    required this.name,
    this.type,
    this.dimension,
    this.residents,
    required this.url,
    this.created,
  });

  factory Location.fromJson(Map<String, dynamic> json) =>
      _$LocationFromJson(json);
  Map<String, dynamic> toJson() => _$LocationToJson(this);
}

@JsonSerializable()
class Origin {
  final String name;
  final String url;

  Origin({
    required this.name,
    required this.url,
  });

  factory Origin.fromJson(Map<String, dynamic> json) => _$OriginFromJson(json);
  Map<String, dynamic> toJson() => _$OriginToJson(this);
}

@JsonSerializable()
class Person {
  final int id;
  final String name;
  final String status;
  final String species;
  final String type;
  final String gender;
  final Origin origin;
  final Location location;

  @JsonKey(name: 'image')
  final String avatar;

  final List<String> episode;
  final String url;
  final String created;

  Person({
    required this.id,
    required this.name,
    required this.status,
    required this.species,
    required this.type,
    required this.gender,
    required this.origin,
    required this.location,
    required this.avatar,
    required this.episode,
    required this.url,
    required this.created,
  });

  factory Person.fromJson(Map<String, dynamic> json) => _$PersonFromJson(json);
  Map<String, dynamic> toJson() => _$PersonToJson(this);
}

@JsonSerializable()
class Info {
  final int count;
  final int pages;
  final String? next;
  final String? prev;

  Info({
    required this.count,
    required this.pages,
    this.next,
    this.prev,
  });

  factory Info.fromJson(Map<String, dynamic> json) => _$InfoFromJson(json);
  Map<String, dynamic> toJson() => _$InfoToJson(this);
}

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
