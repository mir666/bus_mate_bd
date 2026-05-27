import 'package:bus_mate_bd/app/extensions/language_extension.dart';
import 'package:bus_mate_bd/core/controllers/route_search_controller.dart';
import 'package:bus_mate_bd/features/bus/presentation/screens/bus_details_screen.dart';
import 'package:bus_mate_bd/features/common/presentation/widgets/language_selector.dart';
import 'package:bus_mate_bd/features/home/controllers/carousel_controller.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  static const String name = '/home';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  final fromController = TextEditingController();

  final toController = TextEditingController();

  final searchController = Get.find<RouteSearchController>();

  final carouselController = Get.put(BusCarouselController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(),
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF304791), Color(0xFF516ECD)],
            ),
          ),
        ),
        elevation: 0,
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.notifications_active)),
          const Padding(
            padding: EdgeInsets.only(
              right: 12,
            ),
            child: LanguageSelector(),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.maxFinite,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFF304791), Color(0xFF516ECD)],
                ),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
              ),
              child: Column(
                children: [

                  Text(
                    context.localization.goToYourDestination,
                    style: const TextStyle(
                      fontSize: 24,
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      children: [

                        Row(
                          children: [

                            Expanded(
                              child: Column(
                                crossAxisAlignment:
                                CrossAxisAlignment.start,
                                children: [

                                  Text(
                                    context.localization.from,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight:
                                      FontWeight.w600,
                                    ),
                                  ),

                                  const SizedBox(height: 10),

                                  Container(
                                    height: 50,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius:
                                      BorderRadius.circular(10),
                                    ),
                                    child: TextField(
                                      controller: fromController,
                                      decoration: InputDecoration(
                                        hintText:
                                        context.localization
                                            .currentLocation,
                                        hintStyle: const TextStyle(
                                          color: Colors.grey,
                                        ),
                                        border: InputBorder.none,
                                        contentPadding:
                                        const EdgeInsets.symmetric(
                                          horizontal: 12,
                                          vertical: 14,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            const SizedBox(width: 16),

                            Expanded(
                              child: Column(
                                crossAxisAlignment:
                                CrossAxisAlignment.start,
                                children: [

                                  Text(
                                    context.localization
                                        .toDestination,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight:
                                      FontWeight.w600,
                                    ),
                                  ),

                                  const SizedBox(height: 10),

                                  Container(
                                    height: 50,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius:
                                      BorderRadius.circular(10),
                                    ),
                                    child: TextField(
                                      controller: toController,
                                      decoration: InputDecoration(
                                        hintText:
                                        context.localization
                                            .destination,
                                        hintStyle: const TextStyle(
                                          color: Colors.grey,
                                        ),
                                        border: InputBorder.none,
                                        contentPadding:
                                        const EdgeInsets.symmetric(
                                          horizontal: 12,
                                          vertical: 14,
                                        ),
                                        suffixIcon: Icon(
                                          Icons.location_on_outlined,
                                          color:
                                          Colors.grey.shade600,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 24),

                        SizedBox(
                          width: double.infinity,
                          height: 52,
                          child: ElevatedButton.icon(

                            onPressed: () {

                              searchController.search(
                                fromController.text,
                                toController.text,
                              );

                            },

                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              foregroundColor:
                              const Color(0xFF304791),
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                BorderRadius.circular(12),
                              ),
                            ),

                            icon: const Icon(Icons.search),

                            label: Text(
                              context.localization.search,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            Obx(() {

              if (carouselController.routes.isEmpty) {
                return const Center(
                  child: Padding(
                    padding: EdgeInsets.all(20),
                    child: CircularProgressIndicator(),
                  ),
                );
              }

              return CarouselSlider.builder(

                itemCount: carouselController.routes.length,

                options: CarouselOptions(
                  height: MediaQuery.of(context).size.height * 0.24,
                  autoPlay: true,
                  enlargeCenterPage: true,
                  viewportFraction: 0.88,
                ),

                itemBuilder: (context, index, realIndex) {

                  final bus = carouselController.routes[index];

                  return GestureDetector(

                    onTap: () {

                      Get.toNamed(
                        BusDetailsScreen.name,
                        arguments: bus,
                      );

                    },

                    child: LayoutBuilder(
                      builder: (context, constraints) {

                        final width = constraints.maxWidth;
                        final height = constraints.maxHeight;

                        return Container(

                          width: width,
                          height: height,

                          margin: const EdgeInsets.symmetric(horizontal: 6),

                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(18),
                            gradient: const LinearGradient(
                              colors: [
                                Color(0xFF304791),
                                Color(0xFF516ECD),
                              ],
                            ),
                          ),

                          child: Padding(
                            padding: EdgeInsets.all(width * 0.04),

                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [

                                /// TOP SECTION
                                Row(
                                  children: [

                                    Expanded(
                                      child: FittedBox(
                                        alignment: Alignment.centerLeft,
                                        fit: BoxFit.scaleDown,
                                        child: Text(
                                          bus.busName,
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: width * 0.06,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),

                                    const SizedBox(width: 8),

                                    Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: width * 0.025,
                                        vertical: height * 0.02,
                                      ),

                                      decoration: BoxDecoration(
                                        color: bus.isAc
                                            ? Colors.green
                                            : Colors.orange,
                                        borderRadius:
                                        BorderRadius.circular(12),
                                      ),

                                      child: FittedBox(
                                        fit: BoxFit.scaleDown,
                                        child: Text(
                                          bus.isAc ? "AC" : "NON-AC",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: width * 0.03,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),

                                SizedBox(height: height * 0.04),

                                /// ROUTE
                                Expanded(
                                  child: Align(
                                    alignment: Alignment.topLeft,
                                    child: Text(
                                      "${bus.startPoint} → ${bus.endPoint}",
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        color: Colors.white70,
                                        fontSize: width * 0.038,
                                      ),
                                    ),
                                  ),
                                ),

                                /// STOPS
                                Expanded(
                                  flex: 2,
                                  child: Text(
                                    "Stops: ${bus.stops.take(3).join(' → ')}",
                                    maxLines: 3,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      color: Colors.white70,
                                      fontSize: width * 0.032,
                                    ),
                                  ),
                                ),

                                SizedBox(height: height * 0.02),

                                /// BUTTON
                                Align(
                                  alignment: Alignment.bottomRight,

                                  child: FittedBox(
                                    fit: BoxFit.scaleDown,

                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: width * 0.035,
                                        vertical: height * 0.018,
                                      ),

                                      decoration: BoxDecoration(
                                        color: Colors.white.withOpacity(0.15),
                                        borderRadius:
                                        BorderRadius.circular(10),
                                      ),

                                      child: Text(
                                        "View Details",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: width * 0.03,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  );
                },
              );
            }),

          ],
        ),
      ),
    );
  }
}
