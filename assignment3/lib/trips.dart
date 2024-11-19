class Trip {
  final int? id;
  final String customerName;
  final String customerType;
  final String destination;
  final double tripPrice;
  final String
      customerTypeDetail; // Replace additionalInfo with customerTypeDetail

  Trip({
    this.id,
    required this.customerName,
    required this.customerType,
    required this.destination,
    required this.tripPrice,
    required this.customerTypeDetail,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'customerName': customerName,
      'customerType': customerType,
      'destination': destination,
      'tripPrice': tripPrice,
      'customerTypeDetail': customerTypeDetail,
    };
  }

  static Trip fromMap(Map<String, dynamic> map) {
    return Trip(
      id: map['id'],
      customerName: map['customerName'],
      customerType: map['customerType'],
      destination: map['destination'],
      tripPrice: map['tripPrice'],
      customerTypeDetail: map['customerTypeDetail'],
    );
  }
}
