import 'package:bus_mate_bd/data/models/bus_route_model.dart';
import 'package:bus_mate_bd/features/bus/presentation/screens/bus_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';

class BusListScreen extends StatefulWidget {
  const BusListScreen({super.key});

  static const String name = '/bus-list';

  @override
  State<BusListScreen> createState() => _BusListScreenState();
}

class _BusListScreenState extends State<BusListScreen> {

  final TextEditingController searchController = TextEditingController();
  String query = "";

  @override
  Widget build(BuildContext context) {

    final isDark = Theme.of(context).brightness == Brightness.dark;

    final box = Hive.box<BusRouteModel>('busBox');

    return Scaffold(

      backgroundColor: isDark ? const Color(0xFF0F172A) : const Color(0xFFF6F7FB),

      appBar: AppBar(
        title: const Text("Bus Routes"),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: isDark ? Colors.white : Colors.black,
      ),

      body: Column(

        children: [

          // 🔍 PREMIUM SEARCH BAR
          Padding(
            padding: const EdgeInsets.all(12),
            child: Container(
              decoration: BoxDecoration(
                color: isDark ? const Color(0xFF1E293B) : Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),

              child: TextField(
                controller: searchController,
                onChanged: (value) {
                  setState(() {
                    query = value.toLowerCase();
                  });
                },

                style: TextStyle(
                  color: isDark ? Colors.white : Colors.black,
                ),

                decoration: InputDecoration(
                  hintText: "Search bus, route, destination...",
                  hintStyle: TextStyle(
                    color: isDark ? Colors.grey : Colors.grey.shade500,
                  ),

                  prefixIcon: Icon(
                    Icons.search,
                    color: Colors.blueAccent,
                  ),

                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 14,
                  ),
                ),
              ),
            ),
          ),

          // LIST
          Expanded(
            child: ValueListenableBuilder(

              valueListenable: box.listenable(),

              builder: (context, Box<BusRouteModel> box, _) {

                if (box.isEmpty) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                final buses = box.values.where((bus) {

                  final name = bus.busName.toLowerCase();
                  final start = bus.startPoint.toLowerCase();
                  final end = bus.endPoint.toLowerCase();

                  return name.contains(query) ||
                      start.contains(query) ||
                      end.contains(query);

                }).toList();

                if (buses.isEmpty) {
                  return const Center(
                    child: Text("No bus found"),
                  );
                }

                return ListView.builder(

                  padding: const EdgeInsets.only(bottom: 12),

                  itemCount: buses.length,

                  itemBuilder: (context, index) {

                    final bus = buses[index];

                    return Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),

                      child: InkWell(

                        borderRadius: BorderRadius.circular(16),

                        onTap: () {
                          Get.to(() => BusDetailsScreen(bus: bus));
                        },

                        child: Container(

                          decoration: BoxDecoration(
                            color: isDark ? const Color(0xFF1E293B) : Colors.white,
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.06),
                                blurRadius: 12,
                                offset: const Offset(0, 6),
                              ),
                            ],
                          ),

                          child: ListTile(

                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 10,
                            ),

                            leading: Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: Colors.blueAccent.withOpacity(0.15),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: const Icon(
                                Icons.directions_bus,
                                color: Colors.blueAccent,
                              ),
                            ),

                            title: Text(
                              bus.busName,
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: isDark ? Colors.white : Colors.black,
                              ),
                            ),

                            subtitle: Padding(
                              padding: const EdgeInsets.only(top: 4),
                              child: Text(
                                "${bus.startPoint} → ${bus.endPoint}",
                                style: TextStyle(
                                  color: isDark
                                      ? Colors.grey.shade400
                                      : Colors.grey.shade600,
                                ),
                              ),
                            ),

                            trailing: Icon(
                              Icons.arrow_forward_ios,
                              size: 16,
                              color: isDark ? Colors.grey : Colors.grey.shade600,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}