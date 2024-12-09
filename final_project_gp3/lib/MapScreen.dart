import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapScreen extends StatelessWidget {
  const MapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Map Screen'),
      ),
      body: GoogleMap(
        initialCameraPosition: const CameraPosition(
          target: LatLng(37.7749, -122.4194), // San Francisco's coordinates
          zoom: 12, // Zoom level
        ),
        markers: {
          Marker(
            markerId: MarkerId('eventLocation'), // Unique marker ID
            position: LatLng(37.7749, -122.4194), // Same as initialCameraPosition
            infoWindow: InfoWindow(
              title: 'Event Location',
              snippet: 'This is where the event will take place!',
            ),
          ),
        },
      ),
    );
  }
}
