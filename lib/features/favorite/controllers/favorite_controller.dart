import 'package:get/get.dart';

class FavoriteController extends GetxController {

  RxList favoriteBuses = [].obs;

  void toggleFavorite(bus) {

    if (favoriteBuses.contains(bus)) {

      favoriteBuses.remove(bus);

    } else {

      favoriteBuses.add(bus);

    }
  }
}