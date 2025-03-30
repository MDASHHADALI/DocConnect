import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapSample extends StatefulWidget {
  const MapSample({super.key});

  @override
  State<MapSample> createState() => MapSampleState();
}

class MapSampleState extends State<MapSample> {
  late GoogleMapController mapController;
  // Initial location (center of the map)
  final LatLng _initialPosition = const LatLng(28.7041, 77.1025); // Example: Delhi coordinates

  // Variable to store user's current location
  LatLng? _userLocation;

  @override
  void initState() {
    super.initState();
    _checkPermission();
  }
  // Check and request location permission
  Future<void> _checkPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Check if location services are enabled
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Enable Location Services'),
          content: const Text('Location services are disabled. Please enable them.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('OK'),
            ),
          ],
        ),
      );
      return;
    }

    // Check permission status
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      // Request permission if denied
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.deniedForever) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Location Permission Denied'),
            content: const Text(
                'Location permissions are permanently denied. You cannot use this feature.'),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('OK'),
              ),
            ],
          ),
        );
        return;
      }
    }

    if (permission == LocationPermission.whileInUse ||
        permission == LocationPermission.always) {
      // Permission granted
      _getUserLocation();
    }
  }

  // Method to get the user's current location
  Future<void> _getUserLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.high,
          distanceFilter: 100,
        )

      );
      setState(() {
        _userLocation = LatLng(position.latitude, position.longitude);
      });
      _moveToUserLocation(_userLocation!);
    } catch (e) {
      debugPrint('Error getting location: $e');
    }
  }

  // Method to move the camera to the user's location
  void _moveToUserLocation(LatLng location) {
    mapController.animateCamera(CameraUpdate.newLatLng(location));

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightGreenAccent,
      floatingActionButton: FloatingActionButton(onPressed: ()async{_getUserLocation();},child: const Icon(Icons.my_location,size: 30,),),
      appBar: AppBar(
        leading: IconButton(icon:const Icon(Icons.navigate_before,color: Colors.white,), onPressed: () { Get.back(); },),
        title: const Text('Google Maps ',style: TextStyle(
          color: Colors.white,
        ),),
        backgroundColor: Colors.green,
      ),
      body: GoogleMap(
        onMapCreated: (GoogleMapController controller) {
          mapController = controller;
        },
        myLocationButtonEnabled: false,
        zoomGesturesEnabled: true,
        zoomControlsEnabled: false,
        initialCameraPosition: CameraPosition(
          target: _initialPosition,
          zoom: 10.0,
        ),
        markers: _userLocation != null
            ? {
          Marker(
            markerId: const MarkerId('userLocation'),
            position: _userLocation!,
            infoWindow: const InfoWindow(
              title: 'Your Location',
            ),
          ),
        }
            : {},
      ),
    );
  }
}
