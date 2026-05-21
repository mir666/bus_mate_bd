import 'package:hive/hive.dart';

part 'bus_route_model.g.dart';

@HiveType(typeId: 0)
class BusRouteModel {

  @HiveField(0)
  String busName;

  @HiveField(1)
  String startPoint;

  @HiveField(2)
  String endPoint;

  @HiveField(3)
  bool isAc;

  @HiveField(4)
  bool isCircular;

  @HiveField(5)
  List<String> stops;

  BusRouteModel({
    required this.busName,
    required this.startPoint,
    required this.endPoint,
    required this.isAc,
    required this.isCircular,
    required this.stops,
  });
}