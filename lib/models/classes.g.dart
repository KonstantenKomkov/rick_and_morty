// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'classes.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Episode _$EpisodeFromJson(Map<String, dynamic> json) {
  return Episode(
    id: json['id'] as int,
    name: json['name'] as String,
    airDate: json['air_date'] as String,
    episode: json['episode'] as String,
    characters:
        (json['characters'] as List<dynamic>).map((e) => e as String).toList(),
    url: json['url'] as String,
    created: json['created'] as String,
  );
}

Map<String, dynamic> _$EpisodeToJson(Episode instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'air_date': instance.airDate,
      'episode': instance.episode,
      'characters': instance.characters,
      'url': instance.url,
      'created': instance.created,
    };

Location _$LocationFromJson(Map<String, dynamic> json) {
  return Location(
    id: json['id'] as int?,
    name: json['name'] as String,
    type: json['type'] as String?,
    dimension: json['dimension'] as String?,
    residents:
        (json['residents'] as List<dynamic>?)?.map((e) => e as String).toList(),
    url: json['url'] as String,
    created: json['created'] as String?,
  );
}

Map<String, dynamic> _$LocationToJson(Location instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'type': instance.type,
      'dimension': instance.dimension,
      'residents': instance.residents,
      'url': instance.url,
      'created': instance.created,
    };

Origin _$OriginFromJson(Map<String, dynamic> json) {
  return Origin(
    name: json['name'] as String,
    url: json['url'] as String,
  );
}

Map<String, dynamic> _$OriginToJson(Origin instance) => <String, dynamic>{
      'name': instance.name,
      'url': instance.url,
    };

Person _$PersonFromJson(Map<String, dynamic> json) {
  return Person(
    id: json['id'] as int,
    name: json['name'] as String,
    status: json['status'] as String,
    species: json['species'] as String,
    type: json['type'] as String,
    gender: json['gender'] as String,
    origin: Origin.fromJson(json['origin'] as Map<String, dynamic>),
    location: Location.fromJson(json['location'] as Map<String, dynamic>),
    avatar: json['image'] as String,
    episode:
        (json['episode'] as List<dynamic>).map((e) => e as String).toList(),
    url: json['url'] as String,
    created: json['created'] as String,
  );
}

Map<String, dynamic> _$PersonToJson(Person instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'status': instance.status,
      'species': instance.species,
      'type': instance.type,
      'gender': instance.gender,
      'origin': instance.origin,
      'location': instance.location,
      'image': instance.avatar,
      'episode': instance.episode,
      'url': instance.url,
      'created': instance.created,
    };

Info _$InfoFromJson(Map<String, dynamic> json) {
  return Info(
    count: json['count'] as int,
    pages: json['pages'] as int,
    next: json['next'] as String?,
    prev: json['prev'] as String?,
  );
}

Map<String, dynamic> _$InfoToJson(Info instance) => <String, dynamic>{
      'count': instance.count,
      'pages': instance.pages,
      'next': instance.next,
      'prev': instance.prev,
    };

ApiResponse<T> _$ApiResponseFromJson<T>(Map<String, dynamic> json) {
  return ApiResponse<T>(
    info: Info.fromJson(json['info'] as Map<String, dynamic>),
    results: (json['results'] as List<dynamic>?)
        ?.map(_Converter<T>().fromJson)
        .toList(),
  );
}

Map<String, dynamic> _$ApiResponseToJson<T>(ApiResponse<T> instance) =>
    <String, dynamic>{
      'info': instance.info,
      'results': instance.results?.map(_Converter<T>().toJson).toList(),
    };
