/// location_model.dart

class LocationModel {

  final String name;

  final double lat;

  final double lon;

  LocationModel({

    required this.name,

    required this.lat,

    required this.lon,
  });

  factory LocationModel.fromJson(
      Map<String, dynamic> json,
      ) {

    return LocationModel(

      name: json['display_name'] ?? '',

      lat: double.tryParse(
        json['lat'].toString(),
      ) ??
          0.0,

      lon: double.tryParse(
        json['lon'].toString(),
      ) ??
          0.0,
    );
  }
}