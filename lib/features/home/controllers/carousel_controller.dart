import 'package:bus_mate_bd/core/services/bus_route_service.dart';
import 'package:bus_mate_bd/data/models/bus_route_model.dart';
import 'package:get/get.dart';

class BusCarouselController extends GetxController {

  final service = BusRouteService();

  var routes = <BusRouteModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadRoutes();
  }

  Future<void> loadRoutes() async {
    final data = await service.loadRoutes();
    routes.assignAll(data);
  }
}