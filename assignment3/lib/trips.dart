class Trip {
  final int? id;
  final String customerName;
  final String destination;
  final double price;
  final String additionalInfo;
  final int customerType;

  Trip({
    this.id,
    required this.customerName,
    required this.destination,
    required this.price,
    this.additionalInfo = '',
    this.customerType = -1,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'customerName': customerName,
      'destination': destination,
      'price': price,
      'additionalInfo': additionalInfo,
      'customerType': customerType,
    };
  }

  static Trip fromMap(Map<String, dynamic> map) {
    return Trip(
      id: map['id'],
      customerName: map['customerName'] ?? '',
      destination: map['destination'],
      price: map['price'],
      additionalInfo: map['additionalInfo'] ?? '',
      customerType: map['customerType'] ?? -1,
    );
  }
}
