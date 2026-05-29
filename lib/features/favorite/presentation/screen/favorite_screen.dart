import 'package:bus_mate_bd/data/models/bus_route_model.dart';
import 'package:bus_mate_bd/features/bus/presentation/screens/bus_details_screen.dart';
import 'package:bus_mate_bd/features/favorite/providers/favorite_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FavoriteScreen extends StatelessWidget {
  static const String name = '/favorite';

  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark
          ? const Color(0xFF0F172A)
          : const Color(0xFFF6F7FB),

      appBar: AppBar(
        title: const Text('Favorite Buses'),

        centerTitle: true,

        backgroundColor: Colors.transparent,

        elevation: 0,

        foregroundColor: isDark ? Colors.white : Colors.black,
      ),

      body: Consumer<FavoriteProvider>(
        builder: (context, favoriteProvider, child) {
          final List<BusRouteModel> favoriteBuses =
              favoriteProvider.favoriteBuses;

          /// EMPTY STATE
          if (favoriteBuses.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,

                children: [
                  Icon(
                    Icons.favorite_border,
                    size: 80,
                    color: Colors.grey.shade400,
                  ),

                  const SizedBox(height: 16),

                  Text(
                    'No Favorite Buses',

                    style: TextStyle(
                      fontSize: 18,

                      fontWeight: FontWeight.w600,

                      color: isDark ? Colors.white70 : Colors.black54,
                    ),
                  ),
                ],
              ),
            );
          }

          /// FAVORITE LIST
          return ListView.builder(
            padding: const EdgeInsets.all(12),

            itemCount: favoriteBuses.length,

            itemBuilder: (context, index) {
              final bus = favoriteBuses[index];

              return Padding(
                padding: const EdgeInsets.only(bottom: 12),

                child: InkWell(
                  borderRadius: BorderRadius.circular(18),

                  onTap: () {
                    Navigator.push(
                      context,

                      MaterialPageRoute(
                        builder: (_) => BusDetailsScreen(bus: bus),
                      ),
                    );
                  },

                  child: Container(
                    decoration: BoxDecoration(
                      color: isDark ? const Color(0xFF1E293B) : Colors.white,

                      borderRadius: BorderRadius.circular(18),

                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),

                          blurRadius: 10,

                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),

                    child: ListTile(
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 10,
                      ),

                      leading: Container(
                        padding: const EdgeInsets.all(12),

                        decoration: BoxDecoration(
                          color: Colors.redAccent.withOpacity(0.12),

                          borderRadius: BorderRadius.circular(14),
                        ),

                        child: const Icon(
                          Icons.directions_bus_rounded,
                          color: Colors.redAccent,
                        ),
                      ),

                      title: Text(
                        bus.busName,

                        style: TextStyle(
                          fontWeight: FontWeight.w700,

                          color: isDark ? Colors.white : Colors.black,
                        ),
                      ),

                      subtitle: Padding(
                        padding: const EdgeInsets.only(top: 5),

                        child: Text(
                          "${bus.startPoint} → ${bus.endPoint}",

                          style: TextStyle(
                            color: isDark
                                ? Colors.grey.shade400
                                : Colors.grey.shade700,
                          ),
                        ),
                      ),

                      trailing: IconButton(
                        onPressed: () {
                          favoriteProvider.toggleFavorite(bus);
                        },

                        icon: const Icon(Icons.favorite, color: Colors.red),
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
