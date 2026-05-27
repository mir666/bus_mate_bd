import 'package:bus_mate_bd/app/extensions/language_extension.dart';
import 'package:bus_mate_bd/features/bus/presentation/screens/bus_details_screen.dart';
import 'package:bus_mate_bd/features/favorite/controllers/favorite_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FavoriteScreen extends StatelessWidget {

  static const name = "/favorite";

  FavoriteScreen({super.key});

  final favoriteController = Get.find<FavoriteController>();

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;


    return Scaffold(
      backgroundColor: isDark ? Color(0xFF0F172A) : Color(0xFFF6F7FB),
      appBar: AppBar(
        title: Text(context.localization.favoriteRoutes),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: isDark ? Colors.white : Colors.black,
      ),

      body: Obx(() {

        if (favoriteController
            .favoriteBuses
            .isEmpty) {

          return const Center(
            child: Text(
              "No favorite buses yet",
            ),
          );
        }

        return ListView.builder(

          itemCount: favoriteController
              .favoriteBuses
              .length,

          itemBuilder: (context, index) {

            final bus = favoriteController
                .favoriteBuses[index];

            return ListTile(

              leading: CircleAvatar(
                backgroundColor:
                const Color(0xFF304791),
                child: const Icon(
                  Icons.directions_bus,
                  color: Colors.white,
                ),
              ),

              title: Text(bus.busName),

              subtitle: Text(
                "${bus.startPoint} → ${bus.endPoint}",
              ),

              trailing: IconButton(

                onPressed: () {

                  favoriteController
                      .toggleFavorite(bus);

                },

                icon: const Icon(
                  Icons.favorite,
                  color: Colors.red,
                ),
              ),

              onTap: () {

                Get.toNamed(
                  BusDetailsScreen.name,
                  arguments: bus,
                );

              },
            );
          },
        );
      }),
    );
  }
}