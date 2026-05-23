import 'package:bus_mate_bd/data/models/bus_route_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BusDetailsScreen extends StatefulWidget {

  const BusDetailsScreen({super.key});

  static const String name = '/bus-details';

  @override
  State<BusDetailsScreen> createState() => _BusDetailsScreenState();
}

class _BusDetailsScreenState extends State<BusDetailsScreen> {
  @override
  Widget build(BuildContext context) {

    final BusRouteModel bus =
        Get.arguments;

    return Scaffold(

      appBar: AppBar(
        title: Text(bus.busName),
      ),

      body: ListView.builder(

        itemCount: bus.stops.length,

        itemBuilder: (context, index) {

          final stop =
          bus.stops[index];

          return ListTile(

            leading: CircleAvatar(
              child: Text(
                '${index + 1}',
              ),
            ),

            title: Text(stop),
          );
        },
      ),
    );
  }
}