import 'dart:convert';
import 'dart:developer';

import 'package:cooksy/models/restaurants.dart';
import 'package:cooksy/widgets/CustomButton.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:location/location.dart';
import 'package:cooksy/Screens/NearbyScreen/widgets/createMarker.dart';
import 'package:cooksy/Screens/directionScreen/widget/bottomContainer.dart';

class DirectionScreen extends StatefulWidget {
  const DirectionScreen({super.key});

  @override
  State<DirectionScreen> createState() => _DirectionScreenState();
}

class _DirectionScreenState extends State<DirectionScreen> with SingleTickerProviderStateMixin {
  GoogleMapController? _mapController;
  LocationData? _currentLocation;
  Set<Marker> _markers = {};
  Set<Marker> _allMarkers = {};
  Marker? _userLocationMarker;
  Set<Polyline> _polylines = {};

  bool _isBottomSheetVisible = false;

  final List<Restaurant> _restaurants = [
    Restaurant(
      id: 'veg1',
      name: 'Green Leaf',
      rating: 4.5,
      latitude: 33.494078,
      longitude: 73.0929396,
      image: 'assets/images/profile.jpg',
    ),
    Restaurant(
      id: 'res1',
      name: 'Spice Garden',
      rating: 4.3,
      latitude: 32.580583,
      longitude: 74.480874,
      image: 'assets/images/profile.jpg',
    ),
  ];

  @override
  void initState() {
    super.initState();
    _getUserLocation();
  }

  Future<void> _getUserLocation() async {
    Location location = Location();

    // Ensure service enabled
    bool serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        debugPrint("❌ Location service not enabled");
        return;
      }
    }

    // Ensure permission granted
    PermissionStatus permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        debugPrint("❌ Location permission not granted");
        return;
      }
    }

    // Get location
    final loc = await location.getLocation();
    if (loc.latitude == null || loc.longitude == null) {
      debugPrint("❌ Failed to fetch location");
      return;
    }

    setState(() {
      _currentLocation = loc;
    });

    await _updateUserLocationMarker();
    await _loadMarkers();

    _mapController?.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(target: LatLng(loc.latitude!, loc.longitude!), zoom: 16),
      ),
    );
  }

  Future<void> _updateUserLocationMarker() async {
    if (_currentLocation == null) return;

    final customIcon = await BitmapDescriptor.asset(
      const ImageConfiguration(size: Size(40, 40)),
      'assets/icons/current-location.png',
    );

    final marker = Marker(
      markerId: const MarkerId('user_location'),
      position: LatLng(_currentLocation!.latitude!, _currentLocation!.longitude!),
      icon: customIcon,
    );

    setState(() {
      _userLocationMarker = marker;
      _markers = {..._allMarkers, marker};
    });
  }

  Future<void> _loadMarkers() async {
    final restaurantMarkers = <Marker>{};

    for (final restaurant in _restaurants) {
      final icon = await createCustomMarkerIcon(restaurant.image, restaurant.rating, context);

      restaurantMarkers.add(
        Marker(
          markerId: MarkerId(restaurant.id),
          position: LatLng(restaurant.latitude, restaurant.longitude),
          icon: icon,
          consumeTapEvents: true,
          onTap: () {
            // Show bottom container
          },
        ),
      );
    }

    setState(() {
      _allMarkers = restaurantMarkers;
      _markers = {...restaurantMarkers, if (_userLocationMarker != null) _userLocationMarker!};
    });
  }

  Future<List<LatLng>> getRoutePoints(LatLng start, LatLng end) async {
    final apiKey = 'AIzaSyDnAF3JAM7UqTudig7J-VRqTsdiyQ4Hw-Q'; // replace with your key
    final url =
        'https://maps.googleapis.com/maps/api/directions/json?origin=${start.latitude},${start.longitude}&destination=${end.latitude},${end.longitude}&key=$apiKey';

    final response = await http.get(Uri.parse(url));
    final data = json.decode(response.body);
    log(response.body.toString());
    if (data['status'] != 'OK') return [];

    final points = data['routes'][0]['overview_polyline']['points'];
    return _decodePolyline(points);
  }

  List<LatLng> _decodePolyline(String encoded) {
    List<LatLng> poly = [];
    int index = 0, len = encoded.length;
    int lat = 0, lng = 0;

    while (index < len) {
      int b, shift = 0, result = 0;
      do {
        b = encoded.codeUnitAt(index++) - 63;
        result |= (b & 0x1f) << shift;
        shift += 5;
      } while (b >= 0x20);
      int dlat = ((result & 1) != 0 ? ~(result >> 1) : (result >> 1));
      lat += dlat;

      shift = 0;
      result = 0;
      do {
        b = encoded.codeUnitAt(index++) - 63;
        result |= (b & 0x1f) << shift;
        shift += 5;
      } while (b >= 0x20);
      int dlng = ((result & 1) != 0 ? ~(result >> 1) : (result >> 1));
      lng += dlng;

      poly.add(LatLng(lat / 1E5, lng / 1E5));
    }
    return poly;
  }

  Future<void> _drawAnimatedRoute(LatLng destination) async {
    if (_currentLocation == null) return;

    final userLatLng = LatLng(_currentLocation!.latitude!, _currentLocation!.longitude!);

    // Get route points from Directions API
    final routePoints = await getRoutePoints(userLatLng, destination);

    // Animate the line
    _animatePolyline(routePoints);
  }

  Future<void> _animatePolyline(List<LatLng> routePoints) async {
    if (routePoints.isEmpty) return;

    Set<Polyline> polylines = {};
    List<LatLng> drawnPoints = [];

    for (int i = 0; i < routePoints.length; i++) {
      drawnPoints.add(routePoints[i]);

      setState(() {
        polylines = {
          Polyline(
            polylineId: const PolylineId('route'),
            color: Colors.red,
            width: 5,
            points: List.from(drawnPoints), // progressively add points
          ),
        };
        _polylines = polylines;
      });

      // Small delay to create animation effect
      await Future.delayed(const Duration(milliseconds: 30));
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_currentLocation == null) {
      return const Scaffold(
        backgroundColor: Colors.white,
        body: Center(child: CircularProgressIndicator(color: Color(0xFFA93929))),
      );
    }

    return SafeArea(
      top: false,
      child: Scaffold(
        backgroundColor: Color(0xFFc8f2dd),
        appBar: AppBar(
          leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Icon(Icons.arrow_back, color: Colors.white),
          ),
          centerTitle: true,
          title: Text(
            "Directions to Cheff",
            style: GoogleFonts.poppins(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Colors.white,
            ),
          ),
          backgroundColor: Color(0xFFA93929),
        ),
        body: Column(
          children: [
            // Map area
            Expanded(
              child: GoogleMap(
                initialCameraPosition: CameraPosition(
                  target: LatLng(_currentLocation!.latitude!, _currentLocation!.longitude!),
                  zoom: 16,
                ),
                markers: _markers,
                polylines: _polylines,
                myLocationEnabled: false,
                myLocationButtonEnabled: true,
                zoomGesturesEnabled: true,
                scrollGesturesEnabled: true,
                rotateGesturesEnabled: true,
                tiltGesturesEnabled: true,
                onMapCreated: (controller) => _mapController = controller,
              ),
            ),

            // Bottom container with automatic height animation
            AnimatedSize(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              child: Bottomcontainer(
                resturants: _restaurants[0],
                isShowing: _isBottomSheetVisible,
                onTap: () {
                  log("djshjsdhsj");
                  _drawAnimatedRoute(LatLng(_restaurants[1].latitude, _restaurants[1].longitude));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
