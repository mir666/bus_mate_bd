import 'package:bus_mate_bd/data/models/bus_route_model.dart';
import 'package:hive/hive.dart';

class StopService {

  /// সব unique stop return করবে
  static List<String> getAllStops() {

    final box =
    Hive.box<BusRouteModel>('routes');

    final routes = box.values.toList();

    final Set<String> uniqueStops = {};

    for (final route in routes) {

      for (final stop in route.stops) {

        uniqueStops.add(
          _normalize(stop),
        );
      }
    }

    final stops = uniqueStops.toList();

    stops.sort();

    return stops;
  }

  /// Search suggestion এর জন্য
  static List<String> searchStops(
      String query,
      ) {

    if (query.trim().isEmpty) {
      return [];
    }

    final allStops = getAllStops();

    final normalizedQuery =
    _normalize(query);

    return allStops.where((stop) {

      return stop
          .toLowerCase()
          .contains(normalizedQuery);

    }).toList();
  }

  /// Stop exist করে কিনা check
  static bool stopExists(
      String stopName,
      ) {

    final allStops = getAllStops();

    return allStops.contains(
      _normalize(stopName),
    );
  }

  /// Normalize text
  static String _normalize(
      String text,
      ) {

    return text
        .trim()
        .toLowerCase()
        .replaceAll('-', ' ')
        .replaceAll(
      RegExp(r'\s+'),
      ' ',
    );
  }
}