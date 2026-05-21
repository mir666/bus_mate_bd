import 'package:bus_mate_bd/data/models/bus_route_model.dart';
import 'package:hive/hive.dart';

class RouteSeedService {

  static Future<void> seedRoutes() async {

    final box =
    Hive.box<BusRouteModel>('routes');

    if (box.isNotEmpty) return;

    await box.add(
      BusRouteModel(
        busName: 'Bihongo',
        startPoint: 'Mirpur',
        endPoint: 'Motijheel',
        isAc: false,
        isCircular: false,
        stops: [
          'Mirpur',
          'Farmgate',
          'Shahbag',
          'Motijheel',
        ],
      ),
    );
  }
}