import 'package:bus_mate_bd/features/map/controllers/map_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';

class MapScreen extends StatefulWidget {

  const MapScreen({super.key});

  static const String name = '/map';

  @override
  State<MapScreen> createState() =>
      _MapScreenState();
}

class _MapScreenState
    extends State<MapScreen> {

  final MapController _mapController =
  MapController();

  final BusMapController controller = Get.find<BusMapController>();

  final TextEditingController
  _searchController =
  TextEditingController();

  final LatLng _dhakaCenter =
  LatLng(23.8103, 90.4125);

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      body: Stack(

        children: [

          /// MAP
          FlutterMap(

            mapController: _mapController,

            options: MapOptions(
              initialCenter: _dhakaCenter,
              initialZoom: 13,
              minZoom: 3,
              maxZoom: 18,
            ),

            children: [

              TileLayer(

                urlTemplate:
                "https://tile.openstreetmap.org/{z}/{x}/{y}.png",

                userAgentPackageName:
                'com.example.bus_mate_bd',
              ),

              MarkerLayer(

                markers: [

                  Marker(

                    point: _dhakaCenter,

                    width: 40,
                    height: 40,

                    child: const Icon(
                      Icons.location_pin,
                      color: Colors.red,
                      size: 40,
                    ),
                  ),
                ],
              ),
            ],
          ),

          /// SEARCH UI
          SafeArea(

            child: Padding(

              padding:
              const EdgeInsets.all(12),

              child: Column(

                children: [

                  /// SEARCH BAR
                  Material(

                    elevation: 4,
                    borderRadius:
                    BorderRadius.circular(14),

                    child: TextField(

                      controller:
                      _searchController,

                      decoration:
                      InputDecoration(

                        hintText:
                        'Search location',

                        prefixIcon:
                        const Icon(Icons.search),

                        suffixIcon:
                        _searchController
                            .text
                            .isNotEmpty

                            ? IconButton(

                          onPressed: () {

                            _searchController
                                .clear();

                            controller
                                .clearSuggestions();

                            setState(() {});
                          },

                          icon: const Icon(
                            Icons.close,
                          ),
                        )

                            : null,

                        filled: true,
                        fillColor:
                        Colors.white,

                        border:
                        OutlineInputBorder(

                          borderRadius:
                          BorderRadius.circular(
                            14,
                          ),

                          borderSide:
                          BorderSide.none,
                        ),
                      ),

                      onChanged: (value) {

                        setState(() {});

                        controller
                            .searchLocation(
                          value,
                        );
                      },
                    ),
                  ),

                  /// SUGGESTION BOX
                  Obx(() {

                    if (controller
                        .suggestions
                        .isEmpty) {

                      return const SizedBox();
                    }

                    return Container(

                      margin:
                      const EdgeInsets.only(
                        top: 8,
                      ),

                      decoration:
                      BoxDecoration(

                        color: Colors.white,

                        borderRadius:
                        BorderRadius.circular(
                          14,
                        ),

                        boxShadow: [

                          BoxShadow(
                            blurRadius: 10,
                            color: Colors.black12,
                          ),
                        ],
                      ),

                      child: ListView.separated(

                        shrinkWrap: true,

                        itemCount:
                        controller
                            .suggestions
                            .length,

                        separatorBuilder:
                            (_, __) =>
                        const Divider(
                          height: 1,
                        ),

                        itemBuilder:
                            (context, index) {

                          final item =
                          controller
                              .suggestions[index];

                          return ListTile(

                            leading:
                            const Icon(
                              Icons.location_on,
                            ),

                            title: Text(
                              item.name,
                              maxLines: 1,
                              overflow:
                              TextOverflow
                                  .ellipsis,
                            ),

                            onTap: () {

                              final latLng =
                              LatLng(
                                item.lat,
                                item.lon,
                              );

                              _mapController.move(
                                latLng,
                                16,
                              );

                              _searchController
                                  .text =
                                  item.name;

                              controller
                                  .clearSuggestions();

                              setState(() {});
                            },
                          );
                        },
                      ),
                    );
                  }),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}