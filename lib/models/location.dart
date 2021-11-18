import 'package:json_annotation/json_annotation.dart';

part 'location.g.dart';

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