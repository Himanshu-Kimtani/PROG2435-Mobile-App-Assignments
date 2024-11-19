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
  late String _customerType;
  late String _destination;
  late double _tripPrice;
  late String _customerTypeDetail;

  @override
  void initState() {
    super.initState();
    _customerName = widget.trip?.customerName ?? '';
    _customerType = widget.trip?.customerType ?? 'Individual'; // Default value
    _destination = widget.trip?.destination ?? '';
    _tripPrice = widget.trip?.tripPrice ?? 0.0;
    _customerTypeDetail = widget.trip?.customerTypeDetail ?? '';
  }

  void _saveTrip() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      final trip = Trip(
        id: widget.trip?.id,
        customerName: _customerName,
        customerType: _customerType,
        destination: _destination,
        tripPrice: _tripPrice,
        customerTypeDetail: _customerTypeDetail,
      );

      if (widget.trip == null) {
        await DatabaseHelper.instance.insertTrip(trip);
      } else {
        await DatabaseHelper.instance.updateTrip(trip);
      }

      Navigator.pop(context);
    }
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
                onSaved: (value) {
                  _customerName = value!;
                },
              ),
              DropdownButtonFormField<String>(
                value: _customerType,
                decoration: InputDecoration(labelText: 'Customer Type'),
                items: ['Individual', 'Family', 'Group']
                    .map((type) => DropdownMenuItem(
                          value: type,
                          child: Text(type),
                        ))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    _customerType = value!;
                    _customerTypeDetail = ''; // Clear detail when type changes
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please select a customer type';
                  }
                  return null;
                },
              ),
              TextFormField(
                initialValue: _destination,
                decoration: InputDecoration(labelText: 'Destination'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a destination';
                  }
                  return null;
                },
                onSaved: (value) {
                  _destination = value!;
                },
              ),
              TextFormField(
                initialValue: _tripPrice.toString(),
                decoration: InputDecoration(labelText: 'Trip Price'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || double.tryParse(value) == null) {
                    return 'Please enter a valid price';
                  }
                  return null;
                },
                onSaved: (value) {
                  _tripPrice = double.parse(value!);
                },
              ),
              if (_customerType == 'Individual')
                TextFormField(
                  initialValue: _customerTypeDetail,
                  decoration: InputDecoration(
                      labelText: 'Travel Insurance (Policy Number)'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the policy number';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _customerTypeDetail = value!;
                  },
                )
              else if (_customerType == 'Family')
                TextFormField(
                  initialValue: _customerTypeDetail,
                  decoration: InputDecoration(
                      labelText: 'Family Health Coverage (Insurance Company)'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the insurance company';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _customerTypeDetail = value!;
                  },
                )
              else if (_customerType == 'Group')
                TextFormField(
                  initialValue: _customerTypeDetail,
                  decoration: InputDecoration(
                      labelText: 'Organizing Hardware (Whistles, Flags, etc.)'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please specify the organizing hardware';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _customerTypeDetail = value!;
                  },
                ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _saveTrip,
                child: Text('Save'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
