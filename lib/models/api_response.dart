import 'package:json_annotation/json_annotation.dart';
import 'package:rick_and_morty/models/info.dart';

part 'api_response.g.dart';

@JsonSerializable()
class ApiResponse<T> {
  final Info? info;
  final dynamic results;
  @JsonKey(
    defaultValue: false,
  )
  bool isError;
  @JsonKey(
    ignore: true,
  )
  String? error;

  ApiResponse({
    this.info,
    this.results,
    required this.isError,
    this.error,
  });

  factory ApiResponse.fromJson(Map<String, dynamic> json) =>
      _$ApiResponseFromJson(json);
  Map<String, dynamic> toJson() => _$ApiResponseToJson(this);
}
