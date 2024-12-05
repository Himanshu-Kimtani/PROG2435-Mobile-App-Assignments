import 'package:flutter/material.dart';

class ListScreen extends StatefulWidget {
  const ListScreen({super.key});

  @override
  State<ListScreen> createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
  // Sample Data: Replace this with your database logic
  final List<Map<String, dynamic>> events = [
    {
      'name': 'Birthday Party for Sarah',
      'date': '2024-12-15',
      'time': '6:00 PM',
      'description': 'Celebrate Sarah’s birthday with friends and family.',
      'status': 'Upcoming',
    },
    {
      'name': 'Annual Sales Meeting',
      'date': '2024-12-10',
      'time': '10:00 AM',
      'description': 'Discuss yearly sales performance.',
      'status': 'Ongoing',
    },
    {
      'name': 'Networking Event',
      'date': '2024-11-30',
      'time': '2:00 PM',
      'description': 'Meet and connect with professionals in the industry.',
      'status': 'Completed',
    },
  ];

  String _searchText = '';
  String _selectedFilter = 'All';
  String _selectedSort = 'Date';

  @override
  Widget build(BuildContext context) {
    // Filter and sort events based on the user's input
    final filteredEvents = events
        .where((event) =>
            (_selectedFilter == 'All' || event['status'] == _selectedFilter) &&
            (event['name'].toLowerCase().contains(_searchText.toLowerCase())))
        .toList();

    if (_selectedSort == 'Date') {
      filteredEvents.sort((a, b) => a['date'].compareTo(b['date']));
    } else if (_selectedSort == 'Name') {
      filteredEvents.sort((a, b) => a['name'].compareTo(b['name']));
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Event List'),
        actions: [
          IconButton(
            icon: const Icon(Icons.calendar_view_month),
            onPressed: () {
              // TODO: Implement Calendar View toggle
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Calendar View Coming Soon!')),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Search Bar
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              onChanged: (value) {
                setState(() {
                  _searchText = value;
                });
              },
              decoration: InputDecoration(
                labelText: 'Search Events',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ),
          // Filters and Sort Options
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                DropdownButton<String>(
                  value: _selectedFilter,
                  items: ['All', 'Upcoming', 'Ongoing', 'Completed']
                      .map((filter) => DropdownMenuItem(
                            value: filter,
                            child: Text(filter),
                          ))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedFilter = value!;
                    });
                  },
                  hint: const Text('Filter by Status'),
                ),
                DropdownButton<String>(
                  value: _selectedSort,
                  items: ['Date', 'Name']
                      .map((sort) => DropdownMenuItem(
                            value: sort,
                            child: Text('Sort by $sort'),
                          ))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedSort = value!;
                    });
                  },
                  hint: const Text('Sort Events'),
                ),
              ],
            ),
          ),
          // Event List
          Expanded(
            child: ListView.builder(
              itemCount: filteredEvents.length,
              itemBuilder: (context, index) {
                final event = filteredEvents[index];
                return Dismissible(
                  key: Key(event['name']),
                  direction: DismissDirection.endToStart,
                  onDismissed: (direction) {
                    setState(() {
                      events.remove(event);
                    });
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('${event['name']} deleted')),
                    );
                  },
                  background: Container(
                    color: Colors.red,
                    alignment: Alignment.centerRight,
                    padding: const EdgeInsets.only(right: 20),
                    child: const Icon(Icons.delete, color: Colors.white),
                  ),
                  child: ListTile(
                    title: Text(event['name']),
                    subtitle: Text(
                        '${event['date']} at ${event['time']}\n${event['description']}'),
                    isThreeLine: true,
                    onTap: () {
                      Navigator.pushNamed(context, '/detail', arguments: event);
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/detail'); // Navigate to Detail Screen
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
