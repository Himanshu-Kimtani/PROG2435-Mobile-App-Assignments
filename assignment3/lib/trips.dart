/// Enum for Destination
enum Destinations { blueMountain, niagaraFalls, banffNationalPark }

/// Enum for customer type
enum CustomerType { individual, family, group }

/// Base Trip class
class Trip {
  final String destination;
  final String contactPhone;
  final String email;
  final double price;

  Trip({
    required this.destination,
    required this.contactPhone,
    required this.email,
    required this.price,
  });

  // Base toString for common properties
  @override
  String toString() =>
      'Destination: $destination \nContact Phone: $contactPhone \nEmail: $email \nPrice: \$${price.toStringAsFixed(2)}';
}

/// IndividualTrip class with specific property: homeAddress
class IndividualTrip extends Trip {
  final String homeAddress;

  IndividualTrip({
    required super.destination,
    required super.contactPhone,
    required super.email,
    required super.price,
    required this.homeAddress,
  });

  @override
  String toString() {
    return '${super.toString()} \nHome Address: $homeAddress';
  }
}

/// FamilyTrip class with specific property: primaryContact
class FamilyTrip extends Trip {
  final String primaryContact;

  FamilyTrip({
    required super.destination,
    required super.contactPhone,
    required super.email,
    required super.price,
    required this.primaryContact,
  });

  @override
  String toString() {
    return '${super.toString()} \nPrimary Contact: $primaryContact';
  }
}

/// GroupTrip class with specific property: groupInsuranceNumber
class GroupTrip extends Trip {
  final String groupInsuranceNumber;

  GroupTrip({
    required super.destination,
    required super.contactPhone,
    required super.email,
    required super.price,
    required this.groupInsuranceNumber,
  });

  @override
  String toString() {
    return '${super.toString()} \nGroup Insurance Number: $groupInsuranceNumber';
  }
}

/// TripManager class to handle booking and displaying trips
class TripManager {
  final List<Trip> _trips = [];

  /// Adds a trip to the trip list
  void addTrip(Trip trip) {
    _trips.add(trip);
  }

  /// Returns all trip details as a string
  String showAllTrips() {
    if (_trips.isEmpty) {
      return 'No trips have been booked.';
    }
    return _trips.map((trip) => trip.toString()).join('\n\n');
  }

  /// Calculates the total price of all trips
  double calculateTotalPrice() {
    return _trips.fold(0.0, (total, trip) => total + trip.price);
  }
}
