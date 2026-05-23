import 'dart:convert';

import 'package:bus_mate_bd/data/models/bus_route_model.dart';
import 'package:flutter/services.dart';


class BusRouteService {

  static Future<List<BusRouteModel>> loadRoutes() async {

    final jsonString =
    await rootBundle.loadString(
      'assets/data/bus_routes.json',
    );

    final data = jsonDecode(jsonString);

    return List<BusRouteModel>.from(
      data.map(
            (e) => BusRouteModel.fromJson(e),
      ),
    );
  }
}