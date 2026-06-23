import 'dart:convert';

import 'package:bus_mate_bd/data/models/bus_route_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HomeProvider extends ChangeNotifier {
  /// ALL BUS ROUTES
  List<BusRouteModel> _routes = [];

  List<BusRouteModel> get routes => _routes;

  /// SEARCH RESULT
  List<BusRouteModel> _searchResults = [];

  List<BusRouteModel> get searchResults => _searchResults;

  /// SEARCH STATE

  bool _isSearching = false;

  bool get isSearching => _isSearching;

  /// LOADING

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  /// LOAD BUS ROUTES

  Future<void> loadRoutes() async {
    try {
      _isLoading = true;

      notifyListeners();

      final box = Hive.box<BusRouteModel>('busBox');

      if (box.isEmpty) {
        final jsonString = await rootBundle.loadString(
          'assets/data/routes.json',
        );

        final List<dynamic> jsonData = jsonDecode(jsonString);

        final buses = jsonData.map((json) {
          return BusRouteModel.fromJson(json);
        }).toList();

        await box.addAll(buses);
      }

      _routes = box.values.toList();

      _searchResults = List.from(_routes);

      _isSearching = false;
    } catch (e) {
      debugPrint("Load Error : $e");
    } finally {
      _isLoading = false;

      notifyListeners();
    }
  }

  /// TEXT NORMALIZE

  String normalize(String text) {
    return text.toLowerCase().trim().replaceAll(' ', '');
  }

  /// SMART SEARCH

  void searchRoute(String from, String to) {
    final fromQuery = normalize(from);

    final toQuery = normalize(to);

    /// EMPTY SEARCH

    if (fromQuery.isEmpty && toQuery.isEmpty) {
      _isSearching = false;

      _searchResults = List.from(_routes);

      notifyListeners();

      return;
    }

    _isSearching = true;

    _searchResults = _routes.where((bus) {
      final stops = bus.stops.map(normalize).toList();

      final fromIndex = stops.indexWhere((stop) => stop.contains(fromQuery));

      final toIndex = stops.indexWhere((stop) => stop.contains(toQuery));

      /// ONLY FROM SEARCH

      if (fromQuery.isNotEmpty && toQuery.isEmpty) {
        return fromIndex != -1;
      }

      /// FROM + TO SEARCH

      if (fromIndex == -1 || toIndex == -1) {
        return false;
      }

      return fromIndex < toIndex;
    }).toList();

    notifyListeners();
  }

  /// CLEAR SEARCH

  void clearSearch() {
    _isSearching = false;

    _searchResults = List.from(_routes);

    notifyListeners();
  }

  /// FILTER BY AREA

  List<BusRouteModel> getRoutesByArea(String area) {
    return _routes.where((bus) {
      return bus.stops.any(
        (stop) => stop.toLowerCase().contains(area.toLowerCase()),
      );
    }).toList();
  }

  /// REFRESH

  Future<void> refreshRoutes() async {
    await loadRoutes();
  }
}
