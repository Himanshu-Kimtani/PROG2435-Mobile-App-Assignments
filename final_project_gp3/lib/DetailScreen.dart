import 'package:flutter/material.dart';

class DetailScreen extends StatefulWidget {
  const DetailScreen({super.key});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  final _formKey = GlobalKey<FormState>();

  // Controllers for form fields
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _budgetController = TextEditingController();
  final TextEditingController _organizerController = TextEditingController();
  final TextEditingController _attendeesController = TextEditingController();

  String? _selectedCategory;
  final List<String> _categories = ['Party', 'Wedding', 'Conference', 'Other'];

  // Simulate saving to the database
  Future<void> _saveEventToDatabase() async {
    // Replace this with actual database logic
    final newEvent = {
      'name': _nameController.text,
      'date': _dateController.text,
      'time': _timeController.text,
      'location': _locationController.text,
      'description': _descriptionController.text,
      'budget': _budgetController.text,
      'organizer': _organizerController.text,
      'attendees': _attendeesController.text.split(','),
      'category': _selectedCategory,
    };

    print('Saving event to database: $newEvent');
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Event saved successfully!')),
    );

    Navigator.pop(context); // Go back to the previous screen
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Event Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              // Event Name
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Event Name',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the event name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),
              // Date & Time
              TextFormField(
                controller: _dateController,
                decoration: const InputDecoration(
                  labelText: 'Event Date',
                  border: OutlineInputBorder(),
                ),
                onTap: () async {
                  FocusScope.of(context).requestFocus(FocusNode());
                  final DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime.now(),
                    lastDate: DateTime(2100),
                  );
                  if (pickedDate != null) {
                    _dateController.text =
                        '${pickedDate.year}-${pickedDate.month}-${pickedDate.day}';
                  }
                },
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _timeController,
                decoration: const InputDecoration(
                  labelText: 'Event Time',
                  border: OutlineInputBorder(),
                ),
                onTap: () async {
                  FocusScope.of(context).requestFocus(FocusNode());
                  final TimeOfDay? pickedTime = await showTimePicker(
                    context: context,
                    initialTime: TimeOfDay.now(),
                  );
                  if (pickedTime != null) {
                    _timeController.text = pickedTime.format(context);
                  }
                },
              ),
              const SizedBox(height: 10),
              // Location
              TextFormField(
                controller: _locationController,
                decoration: const InputDecoration(
                  labelText: 'Location',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the location';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),
              // Description
              TextFormField(
                controller: _descriptionController,
                decoration: const InputDecoration(
                  labelText: 'Description',
                  border: OutlineInputBorder(),
                ),
                maxLines: 3,
              ),
              const SizedBox(height: 10),
              // Budget
              TextFormField(
                controller: _budgetController,
                decoration: const InputDecoration(
                  labelText: 'Budget',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 10),
              // Organizer Info
              TextFormField(
                controller: _organizerController,
                decoration: const InputDecoration(
                  labelText: 'Organizer',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 10),
              // Attendees
              TextFormField(
                controller: _attendeesController,
                decoration: const InputDecoration(
                  labelText: 'Attendees (comma-separated)',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 10),
              // Category
              DropdownButtonFormField<String>(
                value: _selectedCategory,
                decoration: const InputDecoration(
                  labelText: 'Category',
                  border: OutlineInputBorder(),
                ),
                items: _categories
                    .map((category) => DropdownMenuItem(
                          value: category,
                          child: Text(category),
                        ))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedCategory = value;
                  });
                },
                validator: (value) {
                  if (value == null) {
                    return 'Please select a category';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              // Save Button
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _saveEventToDatabase();
                  }
                },
                child: const Text('Save Event'),
              ),
              const SizedBox(height: 10),
              // Cancel Button
              OutlinedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Cancel'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
