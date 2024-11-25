import 'package:flutter/material.dart';
import 'database_helper.dart';
import 'details_screen.dart';
import 'trips.dart';

class TripListScreen extends StatefulWidget {
  const TripListScreen({super.key});

  @override
  _TripListScreenState createState() => _TripListScreenState();
}

class _TripListScreenState extends State<TripListScreen> {
  List<Trip> trips = [];
  double tripsTotal = 0;

  @override
  void initState() {
    super.initState();
    _loadTrips();
  }

  Future<void> _loadTrips() async {
    final fetchedTrips = await DatabaseHelper.instance.fetchTrips();
    setState(() {
      trips = fetchedTrips;
      tripsTotal = trips.fold(0.0, (sum, trip) => sum + trip.tripPrice);
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
        title: const Text('Trips List'),
      ),
      body: trips.isEmpty
          ? const Center(child: Text('No trips booked yet.'))
          : Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Total Trips: ${trips.length}',
                    style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Total Trips Cost: \$$tripsTotal',
                    style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
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
                          icon: const Icon(Icons.delete),
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
            MaterialPageRoute(builder: (context) => const TripDetailScreen()),
          ).then((_) => _loadTrips());
        },
        tooltip: 'Add New Trip',
        child: const Icon(Icons.add),
      ),
    );
  }
}
