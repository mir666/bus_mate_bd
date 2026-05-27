import 'package:bus_mate_bd/data/models/bus_route_model.dart';
import 'package:bus_mate_bd/features/bus/presentation/screens/bus_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';

class BusListScreen extends StatelessWidget {
  const BusListScreen({super.key});

  static const String name = '/bus-list';

  @override
  Widget build(BuildContext context) {

    final box = Hive.box<BusRouteModel>('busBox');

    return Scaffold(

      appBar: AppBar(
        title: const Text('Bus List'),
      ),

      body: ValueListenableBuilder(

        valueListenable: box.listenable(),

        builder: (context, Box<BusRouteModel> box, _) {

          if (box.isEmpty) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          final buses = box.values.toList();

          return ListView.builder(

            itemCount: buses.length,

            itemBuilder: (context, index) {

              final bus = buses[index];

              return Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),

                child: Card(

                  elevation: 2,

                  child: ListTile(

                    leading: CircleAvatar(
                      child: Icon(Icons.directions_bus),
                    ),

                    title: Text(
                      bus.busName,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    subtitle: Text(
                      '${bus.startPoint} → ${bus.endPoint}',
                    ),

                    trailing: const Icon(Icons.arrow_forward_ios),

                    onTap: () {

                      Get.to(
                            () => BusDetailsScreen(bus: bus),
                      );

                    },
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