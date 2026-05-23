import 'package:bus_mate_bd/data/models/bus_route_model.dart';
import 'package:hive/hive.dart';

class RouteRepository {

  final Box<BusRouteModel> box =
  Hive.box<BusRouteModel>('routes');

  List<BusRouteModel> getAllRoutes() {

    return box.values.toList();
  }

  List<BusRouteModel> searchRoutes({
    required String from,
    required String to,
  }) {

    return box.values.where((route) {

      final fromIndex =
      route.stops.indexWhere(
            (e) =>
        e.toLowerCase() ==
            from.toLowerCase(),
      );

      final toIndex =
      route.stops.indexWhere(
            (e) =>
        e.toLowerCase() ==
            to.toLowerCase(),
      );

      return fromIndex != -1 &&
          toIndex != -1 &&
          fromIndex < toIndex;

    }).toList();
  }
}