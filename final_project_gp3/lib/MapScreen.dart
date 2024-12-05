import 'package:flutter/material.dart';

class MapScreen extends StatelessWidget {
  const MapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Map Screen'),
      ),
      body: const Center(
        child: Text(
          'Visualize event locations on a map.',
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
