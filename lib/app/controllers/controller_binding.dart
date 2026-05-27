import 'package:bus_mate_bd/core/controllers/route_search_controller.dart';
import 'package:bus_mate_bd/features/favorite/controllers/favorite_controller.dart';
import 'package:bus_mate_bd/features/map/controllers/map_controller.dart';
import 'package:get/get.dart';

class ControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(RouteSearchController());
    Get.put(BusMapController());
    Get.put(FavoriteController());
  }

}