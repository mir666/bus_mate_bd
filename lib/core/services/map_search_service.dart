import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:latlong2/latlong.dart';

class SearchService {
  static Future<List<Map<String, dynamic>>> searchPlace(String query) async {
    final url = Uri.parse(
      "https://nominatim.openstreetmap.org/search?q=$query&format=json&limit=5",
    );

    final res = await http.get(url, headers: {
      "User-Agent": "bus_mate_bd_app"
    });

    final data = jsonDecode(res.body);

    return List<Map<String, dynamic>>.from(data);
  }

  static LatLng toLatLng(Map item) {
    return LatLng(
      double.parse(item['lat']),
      double.parse(item['lon']),
    );
  }
}