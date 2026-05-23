import 'package:bus_mate_bd/data/models/bus_route_model.dart';
import 'package:bus_mate_bd/data/repository/route_repository.dart';
import 'package:get/get.dart';

class BusController extends GetxController {

  final RouteRepository repository =
  RouteRepository();

  RxList<BusRouteModel> busRoutes =
      <BusRouteModel>[].obs;

  RxBool isLoading = false.obs;

  @override
  void onInit() {
    loadRoutes();
    super.onInit();
  }

  void loadRoutes() {

    isLoading.value = true;

    busRoutes.value =
        repository.getAllRoutes();

    isLoading.value = false;
  }
}