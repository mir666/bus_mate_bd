import 'package:flutter/material.dart';

class BusHorizontalList extends StatelessWidget {
  BusHorizontalList({super.key});

  final List buses = [
    {"name": "Mirpur Link", "route": "Mirpur → Motijheel"},
    {"name": "BRTC", "route": "Uttara → Sayedabad"},
    {"name": "Achim Paribahan", "route": "Gabtoli → Gulistan"},
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: buses.length,
      itemBuilder: (context, index) {
        final bus = buses[index];

        return Container(
          width: 180,
          margin: const EdgeInsets.only(right: 10),
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.blue.shade50,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                bus['name'],
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                bus['route'],
                style: const TextStyle(fontSize: 12),
              ),
            ],
          ),
        );
      },
    );
  }
}