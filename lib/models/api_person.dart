import 'package:rick_and_morty/models/api_response.dart';
import 'package:rick_and_morty/models/info.dart';
import 'package:rick_and_morty/models/person.dart';
import 'package:rick_and_morty/response_methods.dart';

Future<ApiResponse> loadPersonsList({
  bool loadNextPage = false,
  Info? info,
}) async {
  final ApiResponse response = await getListData(
    undecodedPath: 'api/character',
    loadNextPage: loadNextPage,
    info: info,
  );

  if (response.isError) {
    return response;
  } else {
    if (response.results != null) {
      try {
        final List<dynamic> decodedData = response.results! as List<dynamic>;
        final List<Person> persons = decodedData
            .map(
              (person) => Person.fromJson(person as Map<String, dynamic>),
            )
            .toList();
        return ApiResponse(
          info: response.info,
          results: persons,
        );
      } catch (e) {
        return ApiResponse(
          info: response.info,
          results: response.results,
          error: e.toString(),
        );
      }
    } else {
      return ApiResponse(
        info: response.info,
        results: [],
      );
    }
  }
}
