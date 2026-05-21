import 'package:hive/hive.dart';

part 'stop_model.g.dart';

@HiveType(typeId: 1)
class StopModel {

  @HiveField(0)
  String name;

  @HiveField(1)
  double latitude;

  @HiveField(2)
  double longitude;

  @HiveField(3)
  String area;

  StopModel({
    required this.name,
    required this.latitude,
    required this.longitude,
    required this.area,
  });
}