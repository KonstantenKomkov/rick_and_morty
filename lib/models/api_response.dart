import 'package:json_annotation/json_annotation.dart';
import 'package:rick_and_morty/models/info.dart';

part 'api_response.g.dart';

@JsonSerializable()
class ApiResponse {
  final Info info;
  final List? results;

  ApiResponse({
    required this.info,
    this.results,
  });

  factory ApiResponse.fromJson(Map<String, dynamic> json) =>
      _$ApiResponseFromJson(json);
  Map<String, dynamic> toJson() => _$ApiResponseToJson(this);
}
