import 'package:cooksy/Screens/NearbyScreen/Screen/RadarLoadingScreen.dart';
import 'package:cooksy/Screens/NearbyScreen/widgets/RestaurantMarker.dart';
import 'package:cooksy/Screens/NearbyScreen/widgets/scanning_painter.dart';
import 'package:cooksy/models/restaurants.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'dart:math' as math;

class NearbyScreen extends StatefulWidget {
  const NearbyScreen({super.key});

  @override
  State<NearbyScreen> createState() => _NearbyScreenState();
}

class _NearbyScreenState extends State<NearbyScreen> with TickerProviderStateMixin {
  GoogleMapController? _mapController;
  LocationData? _currentLocation;
  late AnimationController _scanningController;
  late AnimationController _pulseController;
  late Animation<double> _scanningAnimation;
  late Animation<double> _pulseAnimation;

  // Sample nearby restaurants data with real coordinates
  final List<Restaurant> _restaurants = [
    Restaurant(
      id: 'veg1',
      name: 'Green Leaf',
      rating: 4.5,
      latitude: 33.494078,
      longitude: 73.0929396,
      image: 'veg1',
    ),
    Restaurant(
      id: 'veg2',
      name: 'Veggie Delight',
      rating: 4.1,
      latitude: 33.4947029,
      longitude: 73.0921478,
      image: 'veg2',
    ),
    Restaurant(
      id: 'veg3',
      name: 'Plant Paradise',
      rating: 4.8,
      latitude: 33.4947117,
      longitude: 73.0949464,
      image: 'veg3',
    ),
  ];

  @override
  void initState() {
    super.initState();
    _getUserLocation();

    // Initialize animations
    _scanningController = AnimationController(duration: const Duration(seconds: 3), vsync: this);

    _pulseController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );

    _scanningAnimation = Tween<double>(
      begin: 0,
      end: 2 * math.pi,
    ).animate(CurvedAnimation(parent: _scanningController, curve: Curves.linear));

    _pulseAnimation = Tween<double>(
      begin: 0.8,
      end: 1.2,
    ).animate(CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut));

    // Start animations
    _scanningController.repeat();
    _pulseController.repeat(reverse: true);
  }

  @override
  void dispose() {
    _scanningController.dispose();
    _pulseController.dispose();
    super.dispose();
  }

  Future<void> _getUserLocation() async {
    Location location = Location();

    bool serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) return;
    }

    PermissionStatus permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) return;
    }

    final loc = await location.getLocation();

    setState(() {
      _currentLocation = loc;
    });

    if (_mapController != null) {
      _mapController!.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(target: LatLng(loc.latitude!, loc.longitude!), zoom: 16),
        ),
      );
    }
  }

  Offset _latLngToScreenPoint(double latitude, double longitude) {
    if (_currentLocation == null) return const Offset(0, 0);

    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    // Calculate the difference from center
    final latDiff = latitude - _currentLocation!.latitude!;
    final lngDiff = longitude - _currentLocation!.longitude!;

    // Convert to screen coordinates (scale factor for zoom level 16)
    const double scale = 100000.0; // Adjust this value to scale properly

    final x = screenWidth / 2 + (lngDiff * scale);
    final y = screenHeight / 2 - (latDiff * scale);

    return Offset(x, y);
  }

  void _showRestaurantInfo(Restaurant restaurant) {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              restaurant.name,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.star, color: Colors.orange),
                Text('${restaurant.rating}'),
              ],
            ),
            const SizedBox(height: 16),
            ElevatedButton(onPressed: () => Navigator.pop(context), child: const Text('Close')),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Nearby"),
        centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: _currentLocation == null
          ? Center(child: const CircularProgressIndicator(color: Color(0xFFA93929)))
          // RadarLoadingScreen()
          : Stack(
              children: [
                GoogleMap(
                  initialCameraPosition: CameraPosition(
                    target: LatLng(_currentLocation!.latitude!, _currentLocation!.longitude!),
                    zoom: 16,
                  ),
                  myLocationEnabled: false,
                  myLocationButtonEnabled: false,
                  markers: {},
                  onMapCreated: (controller) {
                    _mapController = controller;
                  },
                ),
                // Scanning Animation Overlay
                Positioned.fill(
                  child: AnimatedBuilder(
                    animation: Listenable.merge([_scanningAnimation, _pulseAnimation]),
                    builder: (context, child) {
                      return CustomPaint(
                        painter: ScanningPainter(
                          scanningAngle: _scanningAnimation.value,
                          pulseScale: _pulseAnimation.value,
                        ),
                      );
                    },
                  ),
                ),
                // Restaurant Markers Overlay
                if (_currentLocation != null)
                  ..._restaurants.map((restaurant) {
                    final screenPoint = _latLngToScreenPoint(
                      restaurant.latitude,
                      restaurant.longitude,
                    );

                    return RestaurantMarker(
                      restaurant: restaurant,
                      position: screenPoint,
                      onTap: () => _showRestaurantInfo(restaurant),
                    );
                  }),
              ],
            ),
    );
  }
}
