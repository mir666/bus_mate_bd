import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:hive/hive.dart';

import '../../data/models/bus_route_model.dart';

class RouteSeedService {

  static Future<void> seedRoutes() async {

    final box =
    Hive.box<BusRouteModel>(
      'routes',
    );

    if (box.isNotEmpty) return;

    final jsonString =
    await rootBundle.loadString(
      'assets/data/routes.json',
    );

    final List data =
    jsonDecode(jsonString);

    final routes = data.map((e) {

      return BusRouteModel(

        busName: e['bus_name'],

        startPoint: e['start_point'],

        endPoint: e['end_point'],

        isAc: e['is_ac'],

        isCircular:
        e['is_circular'],

        stops:
        List<String>.from(
          e['stops'],
        ),
      );

    }).toList();

    await box.addAll(routes);
  }
}