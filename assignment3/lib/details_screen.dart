import 'package:flutter/material.dart';
import 'database_helper.dart';
import 'trips.dart';

class TripDetailScreen extends StatefulWidget {
  final Trip? trip;

  TripDetailScreen({this.trip});

  @override
  _TripDetailScreenState createState() => _TripDetailScreenState();
}

class _TripDetailScreenState extends State<TripDetailScreen> {
  final _formKey = GlobalKey<FormState>();
  late String _customerName;
  late String _destination;
  late double _price;
  late String _additionalInfo;
  int _customerType = -1;

  Map<String, String> packageMapping = {
    "1": "Blue Mountain",
    "2": "Niagara Falls",
    "3": "Banff National Park"
  };

  Map<String, Map<String, double>> packages = {
    "Individual": {
      "Blue Mountain": 200.0,
      "Niagara Falls": 100.0,
      "Banff National Park": 300.0,
    },
    "Family": {
      "Blue Mountain": 400.0,
      "Niagara Falls": 300.0,
      "Banff National Park": 700.0,
    },
    "Group": {
      "Blue Mountain": 700.0,
      "Niagara Falls": 1000.0,
      "Banff National Park": 1300.0,
    }
  };

  List<String> customerTypes = ['Individual', 'Family', 'Group'];

  @override
  void initState() {
    super.initState();
    _customerName = widget.trip?.customerName ?? '';
    _destination = widget.trip?.destination ?? '';
    _price = widget.trip?.price ?? 0.0;
    _additionalInfo = widget.trip?.additionalInfo ?? '';
    _customerType = widget.trip?.customerType ?? -1;
  }

  void _updatePrice() {
    if (_customerType != -1 && _destination.isNotEmpty) {
      String customerKey = customerTypes[_customerType];
      setState(() {
        _price = packages[customerKey]?[_destination] ?? 0.0;
        print('Customer Type: $customerKey'); // Debugging print statement
        print('Destination: $_destination'); // Debugging print statement
        print('Updated Price: $_price'); // Debugging print statement
      });
    } else {
      setState(() {
        _price = 0.0;
      });
    }
  }

  void _saveTrip() async {
    print('Save button pressed');
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      print('Form validated. Saving trip...');

      final trip = Trip(
        id: widget.trip?.id,
        customerName: _customerName,
        destination: _destination,
        price: _price,
        additionalInfo: _additionalInfo,
        customerType: _customerType,
      );

      if (widget.trip == null) {
        print('Inserting new trip: ${trip.customerName}, ${trip.destination}');
        await DatabaseHelper.instance.insertTrip(trip);
        print('New trip inserted');
      } else {
        print(
            'Updating existing trip: ${trip.customerName}, ${trip.destination}');
        await DatabaseHelper.instance.updateTrip(trip);
        print('Trip updated');
      }

      Navigator.pop(context, true); // Navigate back with a success result
    } else {
      print('Form validation failed');
    }
  }

  Widget _buildCustomerTypeDropdown() {
    return DropdownButtonFormField<int>(
      decoration: InputDecoration(labelText: 'Customer Type'),
      value: _customerType == -1 ? null : _customerType,
      items: [
        DropdownMenuItem(value: 0, child: Text('Individual')),
        DropdownMenuItem(value: 1, child: Text('Family')),
        DropdownMenuItem(value: 2, child: Text('Group')),
      ],
      onChanged: (value) {
        setState(() {
          _customerType = value!;
          _updatePrice(); // Call to update the price
        });
      },
      validator: (value) {
        if (value == null || value == -1) {
          return 'Please select a customer type';
        }
        return null;
      },
    );
  }

  Widget _buildDestinationDropdown() {
    return DropdownButtonFormField<String>(
      decoration: InputDecoration(labelText: 'Select Destination'),
      value: _destination.isEmpty ? null : _destination,
      items: packageMapping.entries
          .map((entry) => DropdownMenuItem<String>(
                value: entry.value,
                child: Text(entry.value),
              ))
          .toList(),
      onChanged: (value) {
        setState(() {
          _destination = value!;
          _updatePrice(); // Call to update the price
        });
      },
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please select a destination';
        }
        return null;
      },
    );
  }

  Widget _buildPriceDisplay() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Text(
        'Price: \$${_price.toStringAsFixed(2)}',
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.trip == null ? 'Add Trip' : 'Edit Trip'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                initialValue: _customerName,
                decoration: InputDecoration(labelText: 'Customer Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a customer name';
                  }
                  return null;
                },
                onChanged: (value) {
                  _customerName = value;
                },
              ),
              SizedBox(height: 16),
              _buildCustomerTypeDropdown(),
              SizedBox(height: 16),
              _buildDestinationDropdown(),
              SizedBox(height: 16),
              _buildPriceDisplay(),
              TextFormField(
                initialValue: _additionalInfo,
                decoration:
                    InputDecoration(labelText: 'Additional Information'),
                onChanged: (value) {
                  _additionalInfo = value;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _saveTrip(); // Call the _saveTrip() method when Save is pressed
                  }
                },
                child: Text('Save'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
