import 'package:bus_mate_bd/core/controllers/route_search_controller.dart';
import 'package:get/get.dart';

class ControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(RouteSearchController());
  }

}