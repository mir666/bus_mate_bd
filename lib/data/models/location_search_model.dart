class LocationSearchModel {

  final String name;
  final double lat;
  final double lon;

  LocationSearchModel({
    required this.name,
    required this.lat,
    required this.lon,
  });

  factory LocationSearchModel.fromJson(
      Map<String, dynamic> json,
      ) {

    return LocationSearchModel(
      name: json['display_name'],
      lat: double.parse(json['lat']),
      lon: double.parse(json['lon']),
    );
  }
}