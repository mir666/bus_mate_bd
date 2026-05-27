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

    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(

      backgroundColor:
      isDark ? const Color(0xFF0F172A) : const Color(0xFFF6F7FB),

      appBar: AppBar(
        title: Text(bus.busName),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: isDark ? Colors.white : Colors.black,
      ),

      body: SingleChildScrollView(

        padding: const EdgeInsets.all(16),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [

            // 🔥 HERO CARD
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),

              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                gradient: LinearGradient(
                  colors: isDark
                      ? [
                    const Color(0xFF1E293B),
                    const Color(0xFF0F172A),
                  ]
                      : [
                    const Color(0xFF4F46E5),
                    const Color(0xFF3B82F6),
                  ],
                ),
              ),

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  Text(
                    bus.busName,
                    style: const TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),

                  const SizedBox(height: 10),

                  Text(
                    "${bus.startPoint} → ${bus.endPoint}",
                    style: const TextStyle(
                      color: Colors.white70,
                      fontSize: 16,
                    ),
                  ),

                  const SizedBox(height: 16),

                  Row(
                    children: [

                      _chip(
                        bus.isAc ? "AC" : "Non AC",
                      ),

                      const SizedBox(width: 10),

                      _chip(
                        bus.isCircular ? "Circular" : "One Way",
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // TITLE
            Text(
              "Bus Stops",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: isDark ? Colors.white : Colors.black,
              ),
            ),

            const SizedBox(height: 16),

            // 🚏 TIMELINE LIST
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: isDark ? const Color(0xFF1E293B) : Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),

              child: ListView.builder(

                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),

                itemCount: bus.stops.length,

                itemBuilder: (context, index) {

                  final isLast = index == bus.stops.length - 1;

                  return Row(

                    crossAxisAlignment: CrossAxisAlignment.start,

                    children: [

                      Column(
                        children: [

                          Container(
                            width: 14,
                            height: 14,
                            decoration: const BoxDecoration(
                              color: Colors.blueAccent,
                              shape: BoxShape.circle,
                            ),
                          ),

                          if (!isLast)
                            Container(
                              width: 2,
                              height: 40,
                              color: Colors.blueAccent.withOpacity(0.3),
                            ),
                        ],
                      ),

                      const SizedBox(width: 12),

                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 16),
                          child: Text(
                            bus.stops[index],
                            style: TextStyle(
                              fontSize: 15,
                              color: isDark
                                  ? Colors.grey.shade300
                                  : Colors.grey.shade800,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  // 🔥 CHIP WIDGET
  Widget _chip(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 6,
      ),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.2),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}