import 'package:bus_mate_bd/core/services/route_search_service.dart';
import 'package:bus_mate_bd/data/models/bus_route_model.dart';
import 'package:get/get.dart';


class SearchController extends GetxController {

  RxList<BusRouteModel> routes =
      <BusRouteModel>[].obs;

  Future<void> search(String from, String to) async {

    routes.value =
        RouteSearchService.findRoutes(
          from: from,
          to: to,
        );
  }
}