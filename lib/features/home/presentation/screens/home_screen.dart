import 'package:bus_mate_bd/app/extensions/language_extension.dart';
import 'package:bus_mate_bd/app/providers/theme_provider.dart';
import 'package:bus_mate_bd/data/models/bus_route_model.dart';
import 'package:bus_mate_bd/features/bus/presentation/screens/bus_details_screen.dart';
import 'package:bus_mate_bd/features/common/presentation/widgets/language_selector.dart';
import 'package:bus_mate_bd/features/favorite/presentation/screen/favorite_screen.dart';
import 'package:bus_mate_bd/features/favorite/providers/favorite_provider.dart';
import 'package:bus_mate_bd/features/home/presentation/widgets/app_drawer.dart';
import 'package:bus_mate_bd/features/home/providers/home_provider.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  static const String name = '/home';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final fromController = TextEditingController();

  final toController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final screenWidth = MediaQuery.of(context).size.width;
    final themeProvider = context.watch<ThemeProvider>();

    return Scaffold(
      drawer: AppDrawer(),

      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),

        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: isDark
                  ? const [Color(0xFF16213E), Color(0xFF1F4068)]
                  : const [Color(0xFF304791), Color(0xFF516ECD)],
            ),
          ),
        ),

        elevation: 0,

        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, FavoriteScreen.name);
            },

            icon: const Icon(Icons.favorite_border_outlined),
          ),

          const Padding(
            padding: EdgeInsets.only(right: 10),

            child: LanguageSelector(),
          ),

          IconButton(
            onPressed: () {
              themeProvider.changeThemeMode(
                isDark ? ThemeMode.light : ThemeMode.dark,
              );
            },
            icon: Icon(
              isDark ? Icons.light_mode : Icons.dark_mode,
              color: Colors.white,
            ),
          ),
        ],
      ),

      body: Consumer<HomeProvider>(
        builder: (context, homeProvider, child) {
          final routes = homeProvider.searchResults;

          return SingleChildScrollView(
            child: Column(
              children: [
                /// TOP SEARCH SECTION
                _buildTopSearchSection(
                  isDark,
                  context,
                  screenWidth,
                  homeProvider,
                ),

                const SizedBox(height: 24),

                /// CAROUSEL
                if (homeProvider.isLoading)
                  const Center(child: CircularProgressIndicator())
                else if (routes.isEmpty)
                  const Padding(
                    padding: EdgeInsets.all(20),
                    child: Text(
                      'No buses found',
                      style: TextStyle(fontSize: 16),
                    ),
                  )
                else
                  CarouselSlider.builder(
                    itemCount: routes.length,

                    options: CarouselOptions(
                      height: screenWidth * 0.42,
                      autoPlay: true,
                      enlargeCenterPage: true,
                      viewportFraction: 0.82,
                    ),

                    itemBuilder: (context, index, realIndex) {
                      final bus = routes[index];

                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => BusDetailsScreen(bus: bus),
                            ),
                          );
                        },

                        child: _buildCarouselCard(context, bus),
                      );
                    },
                  ),

                const SizedBox(height: 28),

                /// AREA SECTIONS
                _buildAreaSection(
                  context: context,

                  title: "Gulistan Routes",

                  buses: routes
                      .where(
                        (e) => e.stops.any(
                          (s) => s.toLowerCase().contains('gulistan'),
                        ),
                      )
                      .toList(),
                ),

                _buildAreaSection(
                  context: context,

                  title: "Uttara Routes",

                  buses: routes
                      .where(
                        (e) => e.stops.any(
                          (s) => s.toLowerCase().contains('uttara'),
                        ),
                      )
                      .toList(),
                ),
                _buildAreaSection(
                  context: context,

                  title: "Dhanmondi Routes",

                  buses: routes
                      .where(
                        (e) => e.stops.any(
                          (s) => s.toLowerCase().contains('dhanmondi'),
                        ),
                      )
                      .toList(),
                ),
                _buildAreaSection(
                  context: context,

                  title: "Mirpur Routes",

                  buses: routes
                      .where(
                        (e) => e.stops.any(
                          (s) => s.toLowerCase().contains('mirpur'),
                        ),
                      )
                      .toList(),
                ),
                _buildAreaSection(
                  context: context,

                  title: "Sadarghat Routes",

                  buses: routes
                      .where(
                        (e) => e.stops.any(
                          (s) => s.toLowerCase().contains('sadarghat'),
                        ),
                      )
                      .toList(),
                ),
                _buildAreaSection(
                  context: context,

                  title: "Gabtoli Routes",

                  buses: routes
                      .where(
                        (e) => e.stops.any(
                          (s) => s.toLowerCase().contains('gabtoli'),
                        ),
                      )
                      .toList(),
                ),
                _buildAreaSection(
                  context: context,

                  title: "Shahbagh Routes",

                  buses: routes
                      .where(
                        (e) => e.stops.any(
                          (s) => s.toLowerCase().contains('shahbagh'),
                        ),
                      )
                      .toList(),
                ),
                _buildAreaSection(
                  context: context,

                  title: "Kawran Bazar Routes",

                  buses: routes
                      .where(
                        (e) => e.stops.any(
                          (s) => s.toLowerCase().contains('kawran bazar'),
                        ),
                      )
                      .toList(),
                ),
                _buildAreaSection(
                  context: context,

                  title: "Farmgate Routes",

                  buses: routes
                      .where(
                        (e) => e.stops.any(
                          (s) => s.toLowerCase().contains('farmgate'),
                        ),
                      )
                      .toList(),
                ),
                const SizedBox(height: 80),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildTopSearchSection(
    bool isDark,
    BuildContext context,
    double screenWidth,
    HomeProvider homeProvider,
  ) {
    return Container(
      width: double.infinity,

      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: isDark
              ? const [Color(0xFF16213E), Color(0xFF1F4068)]
              : const [Color(0xFF304791), Color(0xFF516ECD)],
        ),

        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(24),

          bottomRight: Radius.circular(24),
        ),
      ),

      child: Padding(
        padding: const EdgeInsets.all(24),

        child: Column(
          children: [
            Text(
              context.localization.goToYourDestination,

              style: const TextStyle(
                fontSize: 24,

                color: Colors.white,

                fontWeight: FontWeight.w700,
              ),
            ),

            SizedBox(height: screenWidth * 0.06),

            Row(
              children: [
                Expanded(
                  child: _buildTextField(
                    title: context.localization.from,

                    hint: context.localization.currentLocation,

                    controller: fromController,
                  ),
                ),

                const SizedBox(width: 16),

                Expanded(
                  child: _buildTextField(
                    title: context.localization.toDestination,

                    hint: context.localization.destination,

                    controller: toController,

                    suffixIcon: Icons.location_on_outlined,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 24),

            SizedBox(
              width: double.infinity,
              height: 58,

              child: Row(
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () {
                        homeProvider.searchRoute(
                          fromController.text,
                          toController.text,
                        );
                      },

                      style: ElevatedButton.styleFrom(
                        elevation: 8,

                        backgroundColor: Colors.white,

                        foregroundColor: const Color(0xFF304791),

                        shadowColor: Colors.black26,

                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 15,
                        ),

                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18),
                        ),
                      ),

                      icon: Container(
                        padding: const EdgeInsets.all(6),

                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                        ),

                        child: const Icon(Icons.search_rounded, size: 22),
                      ),

                      label: Text(
                        context.localization.search,

                        style: const TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 0.3,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(width: 12),

                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.4),

                      borderRadius: BorderRadius.circular(18),

                      border: Border.all(color: Colors.white.withValues(alpha: 0.3)),
                    ),

                    child: TextButton.icon(
                      onPressed: () {
                        fromController.clear();

                        toController.clear();

                        homeProvider.clearSearch();
                      },

                      style: TextButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 18,
                          vertical: 15,
                        ),

                        foregroundColor: Colors.white,

                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18),
                        ),
                      ),

                      icon: const Icon(
                        Icons.clear,
                        size: 20,
                        color: Colors.red,
                      ),

                      label: const Text(
                        "Clear",

                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 15,
                          color: Colors.red,
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
    );
  }

  Widget _buildTextField({
    required String title,

    required String hint,

    required TextEditingController controller,

    IconData? suffixIcon,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,

      children: [
        Text(
          title,

          style: const TextStyle(
            color: Colors.white,

            fontSize: 18,

            fontWeight: FontWeight.w600,
          ),
        ),

        const SizedBox(height: 10),

        Container(
          height: 52,

          decoration: BoxDecoration(
            color: Colors.white,

            borderRadius: BorderRadius.circular(14),
          ),

          child: TextField(
            controller: controller,

            decoration: InputDecoration(
              hintText: hint,

              border: InputBorder.none,

              contentPadding: const EdgeInsets.symmetric(
                horizontal: 14,

                vertical: 14,
              ),

              suffixIcon: suffixIcon != null ? Icon(suffixIcon) : null,
            ),
          ),
        ),
      ],
    );
  }
}

/// AREA SECTION
Widget _buildAreaSection({
  required BuildContext context,

  required String title,

  required List<BusRouteModel> buses,
}) {
  final screenWidth = MediaQuery.of(context).size.width;

  if (buses.isEmpty) {
    return const SizedBox();
  }

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,

    children: [
      Padding(
        padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.04),

        child: Text(
          title,

          style: TextStyle(
            fontSize: screenWidth * 0.05,

            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      SizedBox(height: screenWidth * 0.03),

      SizedBox(
        height: screenWidth * 0.34,

        child: ListView.separated(
          scrollDirection: Axis.horizontal,

          padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.04),

          itemCount: buses.length,

          separatorBuilder: (_, _) => const SizedBox(width: 12),

          itemBuilder: (context, index) {
            final bus = buses[index];

            return _BusCard(bus: bus);
          },
        ),
      ),

      const SizedBox(height: 24),
    ],
  );
}

/// BUS CARD
class _BusCard extends StatelessWidget {
  final BusRouteModel bus;

  const _BusCard({required this.bus});

  @override
  Widget build(BuildContext context) {
    final favoriteProvider = context.watch<FavoriteProvider>();

    final isFavorite = favoriteProvider.isFavorite(bus);
    final bool isDark = Theme.of(context).brightness == Brightness.dark;

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,

          MaterialPageRoute(builder: (_) => BusDetailsScreen(bus: bus)),
        );
      },

      child: Container(
        width: 170,

        padding: const EdgeInsets.all(14),

        decoration: BoxDecoration(
          color: isDark ? const Color(0xFF252525) : Colors.white,

          borderRadius: BorderRadius.circular(20),

          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.06),

              blurRadius: 10,

              offset: const Offset(0, 5),
            ),
          ],
        ),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    bus.busName,

                    maxLines: 1,

                    overflow: TextOverflow.ellipsis,

                    style: const TextStyle(
                      fontWeight: FontWeight.bold,

                      fontSize: 18,
                    ),
                  ),
                ),

                GestureDetector(
                  onTap: () async {
                    await favoriteProvider.toggleFavorite(bus);
                  },

                  child: Icon(
                    isFavorite ? Icons.favorite : Icons.favorite_border,

                    color: isFavorite ? Colors.red : Colors.grey,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 10),

            Text(
              "${bus.startPoint} → ${bus.endPoint}",

              maxLines: 2,

              overflow: TextOverflow.ellipsis,
            ),

            const Spacer(),

            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),

              decoration: BoxDecoration(
                color: bus.isAc ? Colors.green : Colors.orange,

                borderRadius: BorderRadius.circular(10),
              ),

              child: Text(
                bus.isAc ? "AC" : "NON-AC",

                style: const TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// CAROUSEL CARD
Widget _buildCarouselCard(BuildContext context, BusRouteModel bus) {
  final size = MediaQuery.of(context).size;
  final isSmallDevice = size.height < 700;

  final titleSize = isSmallDevice ? 18.0 : 22.0;
  final subTextSize = isSmallDevice ? 12.0 : 14.0;
  final isDark = Theme.of(context).brightness == Brightness.dark;

  return Container(
    width: double.infinity,
    height: isSmallDevice ? 160 : 190,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(20),
      gradient: LinearGradient(
        colors: isDark
            ? const [Color(0xFF16213E), Color(0xFF1F4068)]
            : const [Color(0xFF304791), Color(0xFF516ECD)],
      ),
    ),

    child: Padding(
      padding: EdgeInsets.all(isSmallDevice ? 14 : 18),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          /// TOP ROW
          Row(
            children: [
              Expanded(
                child: Text(
                  bus.busName,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: titleSize,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              const SizedBox(width: 8),

              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: isSmallDevice ? 8 : 10,
                  vertical: isSmallDevice ? 3 : 5,
                ),
                decoration: BoxDecoration(
                  color: bus.isAc ? Colors.green : Colors.orange,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  bus.isAc ? "AC" : "NON-AC",
                  style: TextStyle(color: Colors.white, fontSize: subTextSize),
                ),
              ),
            ],
          ),

          /// ROUTE
          Text(
            "${bus.startPoint} → ${bus.endPoint}",
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(color: Colors.white70, fontSize: subTextSize),
          ),

          /// STOPS
          Text(
            "Stops: ${bus.stops.take(3).join(' → ')}",
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(color: Colors.white70, fontSize: subTextSize),
          ),
        ],
      ),
    ),
  );
}
