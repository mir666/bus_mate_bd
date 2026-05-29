

import 'package:bus_mate_bd/data/models/location_model.dart';
import 'package:bus_mate_bd/features/map/providers/map_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:provider/provider.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  static const String name = '/map';

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final MapController _mapController = MapController();

  final TextEditingController _searchController = TextEditingController();

  final LatLng _dhakaCenter = LatLng(23.8103, 90.4125);

  LatLng? selectedLocation;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

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
                urlTemplate: "https://tile.openstreetmap.org/{z}/{x}/{y}.png",

                userAgentPackageName: 'com.example.bus_mate_bd',
              ),

              /// MARKER
              MarkerLayer(
                markers: [
                  Marker(
                    point: selectedLocation ?? _dhakaCenter,

                    width: 45,

                    height: 45,

                    child: const Icon(
                      Icons.location_pin,

                      color: Colors.red,

                      size: 45,
                    ),
                  ),
                ],
              ),
            ],
          ),

          /// SEARCH UI
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(14),

              child: Consumer<MapProvider>(
                builder: (context, mapProvider, child) {
                  return Column(
                    children: [
                      /// SEARCH BAR
                      Material(
                        elevation: 6,

                        borderRadius: BorderRadius.circular(18),

                        child: TextField(
                          controller: _searchController,

                          decoration: InputDecoration(
                            hintText: 'Search location',

                            prefixIcon: const Icon(Icons.search),

                            suffixIcon: _searchController.text.isNotEmpty
                                ? IconButton(
                                    onPressed: () {
                                      _searchController.clear();

                                      mapProvider.clearSuggestions();

                                      setState(() {});
                                    },

                                    icon: const Icon(Icons.close),
                                  )
                                : null,

                            filled: true,

                            fillColor: isDark
                                ? const Color(0xFF1E293B)
                                : Colors.white,

                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(18),

                              borderSide: BorderSide.none,
                            ),
                          ),

                          onChanged: (value) {
                            setState(() {});

                            mapProvider.searchLocation(value);
                          },
                        ),
                      ),

                      /// LOADING
                      if (mapProvider.isLoading)
                        const Padding(
                          padding: EdgeInsets.only(top: 12),

                          child: CircularProgressIndicator(),
                        ),

                      /// SUGGESTION LIST
                      if (mapProvider.suggestions.isNotEmpty)
                        Expanded(
                          child: Container(
                            margin: const EdgeInsets.only(top: 10),

                            decoration: BoxDecoration(
                              color: isDark
                                  ? const Color(0xFF1E293B)
                                  : Colors.white,

                              borderRadius: BorderRadius.circular(18),

                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.08),

                                  blurRadius: 12,
                                ),
                              ],
                            ),

                            child: ListView.separated(
                              padding: EdgeInsets.zero,

                              itemCount: mapProvider.suggestions.length,

                              separatorBuilder: (_, __) => Divider(
                                height: 1,
                                color: Colors.grey.shade300,
                              ),

                              itemBuilder: (context, index) {
                                final LocationModel item =
                                    mapProvider.suggestions[index];

                                return ListTile(
                                  leading: const Icon(Icons.location_on),

                                  title: Text(
                                    item.name,

                                    maxLines: 2,

                                    overflow: TextOverflow.ellipsis,
                                  ),

                                  onTap: () {
                                    final latLng = LatLng(item.lat, item.lon);

                                    setState(() {
                                      selectedLocation = latLng;
                                    });

                                    _mapController.move(latLng, 16);

                                    _searchController.text = item.name;

                                    mapProvider.clearSuggestions();
                                  },
                                );
                              },
                            ),
                          ),
                        ),
                    ],
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
