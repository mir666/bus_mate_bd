import 'package:hive/hive.dart';

part 'festival_model.g.dart';

@HiveType(typeId: 0)
class Festival extends HiveObject {

  @HiveField(0)
  final String title;

  @HiveField(1)
  final DateTime date;

  Festival({
    required this.title,
    required this.date,
  });
}