import 'package:json_annotation/json_annotation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:rick_and_morty/models/location.dart';
import 'package:rick_and_morty/models/origin.dart';

part 'person.freezed.dart';
part 'person.g.dart';

@freezed
class Person with _$Person {
  factory Person({
    required int id,
    required String name,
    required String status,
    required String species,
    required String type,
    required String gender,
    required Origin origin,
    required Location location,
    required String image,
    required List<String> episode,
    required String url,
    required String created,
  }) = _Person;
  factory Person.fromJson(Map<String, dynamic> json) => _$PersonFromJson(json);
  Map<String, dynamic> toJson() => _$PersonToJson(this);
}
