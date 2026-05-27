import 'package:bus_mate_bd/data/models/location_search_model.dart';
import 'package:dio/dio.dart';


class MapSearchService {

  static final Dio _dio = Dio();

  static Future<List<LocationSearchModel>>
  searchLocation(String query) async {

    if (query.trim().isEmpty) {
      return [];
    }

    final response = await _dio.get(
      'https://nominatim.openstreetmap.org/search',
      queryParameters: {
        'q': '$query, Dhaka',
        'format': 'json',
        'limit': 10,
      },
      options: Options(
        headers: {
          'User-Agent': 'bus_mate_bd',
        },
      ),
    );

    final data = response.data as List;

    return data
        .map(
          (e) =>
          LocationSearchModel.fromJson(e),
    ).toList();
  }
}