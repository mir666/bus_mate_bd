
import 'dart:convert';

import 'package:bus_mate_bd/data/models/location_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class MapProvider extends ChangeNotifier {

  /// SEARCH SUGGESTIONS
  List<LocationModel> _suggestions = [];

  List<LocationModel> get suggestions =>
      _suggestions;

  /// LOADING
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  /// SEARCH LOCATION
  Future<void> searchLocation(
      String query,
      ) async {

    if (query.trim().isEmpty) {

      _suggestions = [];

      notifyListeners();

      return;
    }

    try {

      _isLoading = true;

      notifyListeners();

      final url = Uri.parse(

        'https://nominatim.openstreetmap.org/search?format=json&q=$query&limit=8',
      );

      final response =
      await http.get(

        url,

        headers: {
          'User-Agent': 'bus_mate_bd'
        },
      );

      if (response.statusCode == 200) {

        final List data =
        jsonDecode(response.body);

        _suggestions = data.map((e) {

          return LocationModel.fromJson(e);

        }).toList();
      }

    } catch (e) {

      debugPrint(
        'Location Search Error: $e',
      );

    } finally {

      _isLoading = false;

      notifyListeners();
    }
  }

  /// CLEAR
  void clearSuggestions() {

    _suggestions = [];

    notifyListeners();
  }
}