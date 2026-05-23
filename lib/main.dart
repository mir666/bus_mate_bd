import 'package:bus_mate_bd/app/app.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
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

  Hive.registerAdapter(
    BusRouteModelAdapter(),
  );

  Hive.registerAdapter(
    StopModelAdapter(),
  );

  await Hive.openBox<BusRouteModel>(
    'routes',
  );

  await Hive.openBox<StopModel>(
    'stops',
  );

  await RouteSeedService.seedRoutes();
  await FMTCObjectBoxBackend().initialise();


  runApp(const BusMateBD());
}