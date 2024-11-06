/// Enum for Destination
enum Destinations { blueMountain, niagaraFalls, banffNationalPark }

/// Enum for customer type
enum CustomerType { individual, family, group }

/// Base Trip class
class Trip {
  int? id; // Optional ID for database
  final String destination;
  final String contactPhone;
  final String email;
  final double price;

  Trip({
    this.id,
    required this.destination,
    required this.contactPhone,
    required this.email,
    required this.price,
  });

  // Convert Trip to map for database storage
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'destination': destination,
      'contactPhone': contactPhone,
      'email': email,
      'price': price,
    };
  }

  // Create Trip from map
  static Trip fromMap(Map<String, dynamic> map) {
    return Trip(
      id: map['id'],
      destination: map['destination'],
      contactPhone: map['contactPhone'],
      email: map['email'],
      price: map['price'],
    );
  }

  // Base toString for common properties
  @override
  String toString() =>
      'Destination: $destination \nContact Phone: $contactPhone \nEmail: $email \nPrice: \$${price.toStringAsFixed(2)}';
}

/// IndividualTrip class with specific property: homeAddress
class IndividualTrip extends Trip {
  final String homeAddress;

  IndividualTrip({
    int? id,
    required String destination,
    required String contactPhone,
    required String email,
    required double price,
    required this.homeAddress,
  }) : super(
          id: id,
          destination: destination,
          contactPhone: contactPhone,
          email: email,
          price: price,
        );

  @override
  String toString() {
    return '${super.toString()} \nHome Address: $homeAddress';
  }

  @override
  Map<String, dynamic> toMap() {
    return super.toMap()..['homeAddress'] = homeAddress;
  }

  static IndividualTrip fromMap(Map<String, dynamic> map) {
    return IndividualTrip(
      id: map['id'],
      destination: map['destination'],
      contactPhone: map['contactPhone'],
      email: map['email'],
      price: map['price'],
      homeAddress: map['homeAddress'],
    );
  }
}

/// FamilyTrip class with specific property: primaryContact
class FamilyTrip extends Trip {
  final String primaryContact;

  FamilyTrip({
    int? id,
    required String destination,
    required String contactPhone,
    required String email,
    required double price,
    required this.primaryContact,
  }) : super(
          id: id,
          destination: destination,
          contactPhone: contactPhone,
          email: email,
          price: price,
        );

  @override
  String toString() {
    return '${super.toString()} \nPrimary Contact: $primaryContact';
  }

  @override
  Map<String, dynamic> toMap() {
    return super.toMap()..['primaryContact'] = primaryContact;
  }

  static FamilyTrip fromMap(Map<String, dynamic> map) {
    return FamilyTrip(
      id: map['id'],
      destination: map['destination'],
      contactPhone: map['contactPhone'],
      email: map['email'],
      price: map['price'],
      primaryContact: map['primaryContact'],
    );
  }
}

/// GroupTrip class with specific property: groupInsuranceNumber
class GroupTrip extends Trip {
  final String groupInsuranceNumber;

  GroupTrip({
    int? id,
    required String destination,
    required String contactPhone,
    required String email,
    required double price,
    required this.groupInsuranceNumber,
  }) : super(
          id: id,
          destination: destination,
          contactPhone: contactPhone,
          email: email,
          price: price,
        );

  @override
  String toString() {
    return '${super.toString()} \nGroup Insurance Number: $groupInsuranceNumber';
  }

  @override
  Map<String, dynamic> toMap() {
    return super.toMap()..['groupInsuranceNumber'] = groupInsuranceNumber;
  }

  static GroupTrip fromMap(Map<String, dynamic> map) {
    return GroupTrip(
      id: map['id'],
      destination: map['destination'],
      contactPhone: map['contactPhone'],
      email: map['email'],
      price: map['price'],
      groupInsuranceNumber: map['groupInsuranceNumber'],
    );
  }
}
