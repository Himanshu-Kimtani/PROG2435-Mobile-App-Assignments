import 'package:flutter/material.dart';
import 'database_helper.dart';
import 'details_screen.dart';
import 'trips.dart';

class TripListScreen extends StatefulWidget {
  @override
  _TripListScreenState createState() => _TripListScreenState();
}

class _TripListScreenState extends State<TripListScreen> {
  List<Trip> trips = [];

  @override
  void initState() {
    super.initState();
    _loadTrips();
  }

  Future<void> _loadTrips() async {
    final fetchedTrips = await DatabaseHelper.instance.fetchTrips();
    setState(() {
      trips = fetchedTrips;
    });
  }

  void _deleteTrip(int id) async {
    await DatabaseHelper.instance.deleteTrip(id);
    _loadTrips();
  }

  void _navigateToAddOrEditTrip(Trip? trip) async {
    // Navigate to TripDetailScreen and wait for the result
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => TripDetailScreen(trip: trip),
      ),
    );

    // If the result is true, refresh the trip list
    if (result == true) {
      _loadTrips();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Trips List'),
      ),
      body: trips.isEmpty
          ? Center(child: Text('No trips booked yet.'))
          : ListView.builder(
              itemCount: trips.length,
              itemBuilder: (context, index) {
                final trip = trips[index];
                return ListTile(
                  title: Text('${trip.customerName} - ${trip.destination}'),
                  subtitle: Text('Price: \$${trip.price.toStringAsFixed(2)}'),
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () => _deleteTrip(trip.id!),
                  ),
                  onTap: () {
                    _navigateToAddOrEditTrip(trip); // Navigate to edit trip
                  },
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _navigateToAddOrEditTrip(null); // Navigate to add a new trip
        },
        child: Icon(Icons.add),
        tooltip: 'Add New Trip',
      ),
    );
  }
}
