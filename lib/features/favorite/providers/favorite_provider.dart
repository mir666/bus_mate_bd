
import 'package:bus_mate_bd/data/models/bus_route_model.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class FavoriteProvider extends ChangeNotifier {

  static const String favoriteBoxName = 'favoriteBox';

  late Box<BusRouteModel> _favoriteBox;

  List<BusRouteModel> _favoriteBuses = [];

  List<BusRouteModel> get favoriteBuses =>
      _favoriteBuses;

  /// INIT
  Future<void> initFavoriteBox() async {

    _favoriteBox =
    await Hive.openBox<BusRouteModel>(
      favoriteBoxName,
    );

    _favoriteBuses = _favoriteBox.values.toList();

    notifyListeners();
  }

  /// TOGGLE FAVORITE
  Future<void> toggleFavorite(
      BusRouteModel bus) async {

    final exists = _favoriteBuses.any(
          (item) => item.busName == bus.busName,
    );

    if (exists) {

      final key = _favoriteBox.keys.firstWhere(
            (key) =>
        _favoriteBox.get(key)?.busName ==
            bus.busName,
      );

      await _favoriteBox.delete(key);

      _favoriteBuses.removeWhere(
            (item) =>
        item.busName == bus.busName,
      );

    } else {

      await _favoriteBox.add(bus);

      _favoriteBuses.add(bus);
    }

    notifyListeners();
  }

  /// CHECK FAVORITE
  bool isFavorite(BusRouteModel bus) {

    return _favoriteBuses.any(
          (item) => item.busName == bus.busName,
    );
  }
}