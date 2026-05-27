import 'package:bus_mate_bd/core/services/map_search_service.dart';
import 'package:get/get.dart';

import '../../../data/models/location_search_model.dart';

class BusMapController extends GetxController {

  RxList<LocationSearchModel> suggestions =
      <LocationSearchModel>[].obs;

  RxBool isLoading = false.obs;

  Future<void> searchLocation(
      String query,
      ) async {

    if (query.trim().isEmpty) {

      suggestions.clear();

      return;
    }

    isLoading.value = true;

    suggestions.value =
    await MapSearchService
        .searchLocation(query);

    isLoading.value = false;
  }

  void clearSuggestions() {

    suggestions.clear();
  }
}