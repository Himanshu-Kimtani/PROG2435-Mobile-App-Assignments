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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Trips List'),
      ),
      body: trips.isEmpty
          ? Center(child: Text('No trips booked yet.'))
          : Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    'Total Trips: ${trips.length}',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: trips.length,
                    itemBuilder: (context, index) {
                      final trip = trips[index];
                      return ListTile(
                        title:
                            Text('${trip.customerName} - ${trip.customerType}'),
                        subtitle: Text(
                          'Destination: ${trip.destination}, Price: \$${trip.tripPrice.toStringAsFixed(2)}\nDetails: ${trip.customerTypeDetail}',
                        ),
                        trailing: IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () => _deleteTrip(trip.id!),
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  TripDetailScreen(trip: trip),
                            ),
                          ).then((_) => _loadTrips());
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => TripDetailScreen()),
          ).then((_) => _loadTrips());
        },
        child: Icon(Icons.add),
        tooltip: 'Add New Trip',
      ),
    );
  }
}
