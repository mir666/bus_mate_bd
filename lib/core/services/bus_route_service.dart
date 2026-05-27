import 'dart:convert';
import 'package:bus_mate_bd/data/models/bus_route_model.dart';
import 'package:flutter/services.dart';

class BusRouteService {

  Future<List<BusRouteModel>> loadRoutes() async {

    final jsonString =
    await rootBundle.loadString('assets/data/routes.json');

    final data = jsonDecode(jsonString) as List;

    return data
        .map((e) => BusRouteModel.fromJson(e))
        .toList();
  }
}