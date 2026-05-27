import 'package:bus_mate_bd/data/models/bus_route_model.dart';
import 'package:flutter/material.dart';

class BusDetailsScreen extends StatelessWidget {

  final BusRouteModel bus;

  static const String name = '/bus-details';

  const BusDetailsScreen({
    super.key,
    required this.bus,
  });

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: Text(bus.busName),
      ),

      body: SingleChildScrollView(

        padding: const EdgeInsets.all(16),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [

            Container(
              padding: const EdgeInsets.all(16),

              decoration: BoxDecoration(
                color: Colors.blue.shade50,
                borderRadius: BorderRadius.circular(16),
              ),

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  Text(
                    bus.busName,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 12),

                  Text(
                    'From: ${bus.startPoint}',
                    style: const TextStyle(fontSize: 16),
                  ),

                  Text(
                    'To: ${bus.endPoint}',
                    style: const TextStyle(fontSize: 16),
                  ),

                  const SizedBox(height: 10),

                  Row(
                    children: [

                      Chip(
                        label: Text(
                          bus.isAc ? 'AC' : 'Non AC',
                        ),
                      ),

                      const SizedBox(width: 10),

                      Chip(
                        label: Text(
                          bus.isCircular
                              ? 'Circular'
                              : 'Non Circular',
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            const Text(
              'Bus Stops',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 16),

            ListView.builder(

              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),

              itemCount: bus.stops.length,

              itemBuilder: (context, index) {

                return Row(

                  crossAxisAlignment: CrossAxisAlignment.start,

                  children: [

                    Column(
                      children: [

                        const Icon(
                          Icons.location_on,
                          color: Colors.red,
                        ),

                        if (index != bus.stops.length - 1)
                          Container(
                            width: 2,
                            height: 40,
                            color: Colors.grey.shade400,
                          ),
                      ],
                    ),

                    const SizedBox(width: 12),

                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 4),
                        child: Text(
                          bus.stops[index],
                          style: const TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}