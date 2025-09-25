import 'package:cooksy/Screens/NearbyScreen/widgets/createMarker.dart';
import 'package:cooksy/Screens/NearbyScreen/widgets/resturantInfo.dart';
import 'package:cooksy/models/restaurants.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:lottie/lottie.dart' hide Marker;

class NearbyScreen extends StatefulWidget {
  const NearbyScreen({super.key});

  @override
  State<NearbyScreen> createState() => _NearbyScreenState();
}

class _NearbyScreenState extends State<NearbyScreen> {
  GoogleMapController? _mapController;
  LocationData? _currentLocation;
  Set<Marker> _markers = {};
  Set<Marker> _allMarkers = {};
  Marker? _userLocationMarker;
  final double minZoomForMarkers = 14;

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
    Restaurant(
      id: 'res2',
      name: 'Grill & Chill',
      rating: 4.1,
      latitude: 32.581100,
      longitude: 74.480500,
      image: 'assets/images/profile.jpg',
    ),
    Restaurant(
      id: 'res3',
      name: 'Pizza Corner',
      rating: 4.6,
      latitude: 32.580000,
      longitude: 74.481300,
      image: 'assets/images/profile.jpg',
    ),
  ];

  @override
  void initState() {
    super.initState();
    _getUserLocation();
  }

  Future<void> _updateUserLocationMarker() async {
    if (_currentLocation == null) return;

    final customIcon = await BitmapDescriptor.asset(
      const ImageConfiguration(size: Size(40, 40)),
      'assets/icons/home-3d.png',
    );

    final marker = Marker(
      markerId: const MarkerId('user_location'),
      position: LatLng(_currentLocation!.latitude!, _currentLocation!.longitude!),
      icon: customIcon,
    );

    setState(() {
      _userLocationMarker = marker;
      // Keep restaurant markers too
      _markers = {..._allMarkers, marker};
    });
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
    await _updateUserLocationMarker();

    await _loadMarkers();

    if (_mapController != null) {
      _mapController!.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(target: LatLng(loc.latitude!, loc.longitude!), zoom: 16),
        ),
      );
    }
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
          infoWindow: InfoWindow.noText, // avoids default centering
          consumeTapEvents: true, // important: prevents automatic camera movement
          onTap: () {
            // Your custom popup function
            resturantInfo(context, restaurant);
          },
        ),
      );
    }

    setState(() {
      _allMarkers = restaurantMarkers;
      _markers = {...restaurantMarkers, if (_userLocationMarker != null) _userLocationMarker!};
    });
  }

  // void _onCameraMove(CameraPosition position) {
  //   if (_allMarkers.isEmpty) return;

  //   if (position.zoom < minZoomForMarkers) {
  //     // Only hide restaurant markers
  //     setState(() {
  //       _markers = {if (_userLocationMarker != null) _userLocationMarker!};
  //     });
  //   } else {
  //     // Show restaurant markers along with user marker
  //     setState(() {
  //       _markers = {..._allMarkers, if (_userLocationMarker != null) _userLocationMarker!};
  //     });
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    if (_currentLocation == null) {
      return const Scaffold(
        backgroundColor: Colors.white,
        body: Center(child: CircularProgressIndicator(color: Color(0xFFA93929))),
      );
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Nearby Cheffs",
          style: GoogleFonts.poppins(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
        ),
        backgroundColor: Color(0xFFA93929),
      ),
      body: Stack(
        children: [
          // Google Map should be interactive
          GoogleMap(
            initialCameraPosition: CameraPosition(
              target: LatLng(_currentLocation!.latitude!, _currentLocation!.longitude!),
              zoom: 16,
            ),
            myLocationEnabled: false,
            myLocationButtonEnabled: true,
            markers: _markers,
            zoomGesturesEnabled: false, // disable zoom
            scrollGesturesEnabled: false, // disable scroll/pan
            rotateGesturesEnabled: false, // disable rotation
            tiltGesturesEnabled: false,
            // onCameraMove: _onCameraMove, // listen to camera changes
            onMapCreated: (controller) {
              _mapController = controller;
            },
          ),

          // Centered Lottie animation (non-blocking)
          Center(
            child: IgnorePointer(
              ignoring: true,
              child: Lottie.asset(
                'assets/animation.json',
                width: MediaQuery.of(context).size.width * 0.9,
                height: MediaQuery.of(context).size.height * 0.9,
                fit: BoxFit.contain,
                repeat: true,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
