import 'package:bus_mate_bd/data/models/festival_model.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class NotificationProvider extends ChangeNotifier {

  final Box<Festival> _box =
  Hive.box<Festival>('festivalBox');

  List<Festival> get festivals =>
      _box.values.toList();

  int get count => _box.length;

  Future<void> addFestival({
    required String title,
    required DateTime date,
  }) async {
    await _box.add(
      Festival(
        title: title,
        date: date,
      ),
    );

    notifyListeners();
  }

  Future<void> deleteFestival(int index) async {
    await _box.deleteAt(index);

    notifyListeners();
  }
}