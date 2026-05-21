import 'package:bus_mate_bd/data/models/bus_route_model.dart';
import 'package:hive/hive.dart';

class RouteSearchService {

  static List<BusRouteModel> findRoutes({
    required String from,
    required String to,
  }) {

    final box =
    Hive.box<BusRouteModel>('routes');

    final routes = box.values.toList();

    return routes.where((route) {

      final stops = route.stops
          .map((e) => e.toLowerCase())
          .toList();

      final fromIndex =
      stops.indexOf(from.toLowerCase());

      final toIndex =
      stops.indexOf(to.toLowerCase());

      return fromIndex != -1 &&
          toIndex != -1 &&
          fromIndex < toIndex;

    }).toList();
  }
}