import 'package:json_annotation/json_annotation.dart';
import 'package:rick_and_morty/models/info.dart';

part 'api_response.g.dart';

@JsonSerializable()
class ApiResponse {
  final Info? info;
  dynamic results;
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
