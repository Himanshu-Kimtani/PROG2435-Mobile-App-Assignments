import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart'; // Import for rendering SVGs

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.white, Color(0xFFF7F7F7)], // Subtle gradient
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          children: [
            // App Header Section
            Padding(
              padding: const EdgeInsets.only(top: 50, bottom: 20),
              child: Column(
                children: [
                  // Display your SVG logo
                  SvgPicture.asset(
                    'assets/logo-transparent-svg.svg', // Path to your SVG logo
                    height: 150,
                    placeholderBuilder: (BuildContext context) =>
                        const CircularProgressIndicator(), // Show progress indicator while loading
                  ),
                  const SizedBox(height: 10),
                  // App Title
                  const Text(
                    'Event Management App',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 5),
                  // Tagline
                  const Text(
                    'Your partner in planning events effortlessly.',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black54,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            // Card Section
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: GridView.count(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  children: [
                    // List Screen Card
                    _buildFeatureCard(
                      context,
                      icon: Icons.list_alt,
                      title: 'Event List',
                      color: Colors.deepPurple,
                      onTap: () {
                        Navigator.pushNamed(context, '/list');
                      },
                    ),
                    // Detail Screen Card
                    _buildFeatureCard(
                      context,
                      icon: Icons.edit_calendar,
                      title: 'Add Event',
                      color: Colors.teal,
                      onTap: () {
                        Navigator.pushNamed(context, '/detail');
                      },
                    ),
                    // Map Screen Card
                    _buildFeatureCard(
                      context,
                      icon: Icons.map_outlined,
                      title: 'Event Map',
                      color: Colors.orange,
                      onTap: () {
                        Navigator.pushNamed(context, '/map');
                      },
                    ),
                    // About Screen Card
                    _buildFeatureCard(
                      context,
                      icon: Icons.info_outline,
                      title: 'About',
                      color: Colors.blueAccent,
                      onTap: () {
                        Navigator.pushNamed(context, '/about');
                      },
                    ),
                  ],
                ),
              ),
            ),
            // Version Info
            const Padding(
              padding: EdgeInsets.only(bottom: 20),
              child: Text(
                'Version 1.0.0',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.black54,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Helper method to build feature cards
  Widget _buildFeatureCard(
    BuildContext context, {
    required IconData icon,
    required String title,
    required Color color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 5,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 50,
              color: color,
            ),
            const SizedBox(height: 10),
            Text(
              title,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: color,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
