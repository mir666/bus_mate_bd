import 'package:hive/hive.dart';

part 'bus_route_model.g.dart';

@HiveType(typeId: 0)
class BusRouteModel extends HiveObject {

  @HiveField(0)
  final String busName;

  @HiveField(1)
  final String startPoint;

  @HiveField(2)
  final String endPoint;

  @HiveField(3)
  final bool isAc;

  @HiveField(4)
  final bool isCircular;

  @HiveField(5)
  final List<String> stops;

  BusRouteModel({
    required this.busName,
    required this.startPoint,
    required this.endPoint,
    required this.isAc,
    required this.isCircular,
    required this.stops,
  });

  factory BusRouteModel.fromJson(Map<String, dynamic> json) {
    return BusRouteModel(
      busName: json['bus_name'] ?? '',
      startPoint: json['start_point'] ?? '',
      endPoint: json['end_point'] ?? '',
      isAc: json['is_ac'] ?? false,
      isCircular: json['is_circular'] ?? false,
      stops: List<String>.from(json['stops'] ?? []),
    );
  }
}