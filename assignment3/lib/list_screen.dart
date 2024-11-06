import 'package:flutter/material.dart';
import 'database_helper.dart'; 
import 'trips.dart';
import 'details_screen.dart'; 

class TripListScreen extends StatefulWidget {
  @override
  _TripListScreenState createState() => _TripListScreenState();
}

class _TripListScreenState extends State<TripListScreen> {
  List<Trip> trips = [];

  @override
  void initState() {
    super.initState();
    _loadTrips(); // Load trips from the database when screen loads
  }

  Future<void> _loadTrips() async {
    final fetchedTrips = await DatabaseHelper.instance.fetchTrips();
    setState(() {
      trips = fetchedTrips;
    });
  }

  void _deleteTrip(int id) async {
    await DatabaseHelper.instance.deleteTrip(id);
    _loadTrips(); // Refresh the list after deletion
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
                  title: Text(trip.destination),
                  subtitle: Text('Price: \$${trip.price.toStringAsFixed(2)}'),
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () => _deleteTrip(trip.id!),
                  ),
                  onTap: () {
                    // Additional functionality could go here, like viewing details
                  },
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => TripPlannerForm()),
          ).then((_) => _loadTrips()); // Reload trips after returning
        },
        child: Icon(Icons.add),
        tooltip: 'Add New Trip',
      ),
    );
  }
}
