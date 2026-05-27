import 'dart:convert';

import 'package:bus_mate_bd/app/app.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter_map_tile_caching/flutter_map_tile_caching.dart';
import 'core/services/route_seed_service.dart';
import 'data/models/bus_route_model.dart';
import 'data/models/stop_model.dart';
import 'firebase_options.dart';

Future<void> main() async {

  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await GetStorage.init();

  await Hive.initFlutter();

  Hive.registerAdapter(BusRouteModelAdapter());

  Hive.registerAdapter(StopModelAdapter());

  await Hive.openBox<BusRouteModel>('busBox');

  await Hive.openBox<StopModel>('stops');

  await RouteSeedService.seedRoutes();
  await FMTCObjectBoxBackend().initialise();

  await loadBusData();


  runApp(const BusMateBD());
}

Future<void> loadBusData() async {

  final box = Hive.box<BusRouteModel>('busBox');

  if (box.isNotEmpty) {
    return;
  }

  final jsonString =
  await rootBundle.loadString('assets/data/bus_routes.json');

  final List data = jsonDecode(jsonString);

  final buses = data.map((e) => BusRouteModel.fromJson(e)).toList();

  await box.addAll(buses);
}