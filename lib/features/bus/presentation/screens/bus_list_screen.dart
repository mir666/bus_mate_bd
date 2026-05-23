import 'package:bus_mate_bd/data/models/bus_route_model.dart';
import 'package:bus_mate_bd/features/bus/controllers/bus_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BusListScreen extends StatefulWidget {

  const BusListScreen({super.key});

  static const String name = '/bus-list';

  @override
  State<BusListScreen> createState() => _BusListScreenState();
}

class _BusListScreenState extends State<BusListScreen> {
  final BusController controller =
  Get.put(BusController());

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: const Text('All Bus Routes'),
      ),

      body: Obx(() {

        if (controller.isLoading.value) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (controller.busRoutes.isEmpty) {
          return const Center(
            child: Text('No Routes Found'),
          );
        }

        return ListView.builder(

          itemCount:
          controller.busRoutes.length,

          itemBuilder: (context, index) {

            final BusRouteModel bus =
            controller.busRoutes[index];

            return Card(

              margin: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 6,
              ),

              child: ListTile(

                leading: CircleAvatar(
                  child: Text(
                    bus.busName[0],
                  ),
                ),

                title: Text(
                  bus.busName,
                ),

                subtitle: Text(
                  '${bus.startPoint} → ${bus.endPoint}',
                ),

                trailing: bus.isAc
                    ? const Icon(
                  Icons.ac_unit,
                )
                    : null,

                onTap: () {

                  Get.toNamed(
                    '/bus-details',
                    arguments: bus,
                  );
                },
              ),
            );
          },
        );
      }),
    );
  }
}