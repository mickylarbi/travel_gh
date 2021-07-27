class CustomRoute {
  final String id;
  final String departure;
  final String destination;
  final String companyId;
  final String price;
  final List<String> features;
  final int seatsAvailable;
  final DateTime dateTime;

  CustomRoute(
      {this.departure,
      this.id,
      this.destination,
      this.companyId,
      this.price,
      this.features,
      this.seatsAvailable,
      this.dateTime});

  CustomRoute fromFirebase(Map<String, dynamic> firebaseMap, String rId) {
    return CustomRoute(
        departure: firebaseMap['departure'],
        destination: firebaseMap['destination'],
        companyId: firebaseMap['companyId'],
        price: firebaseMap['price'],
        features: List.from(firebaseMap['features']),
        seatsAvailable: firebaseMap['seatsAvailable'],
        dateTime: DateTime.fromMillisecondsSinceEpoch(
            firebaseMap['dateTime'].millisecondsSinceEpoch),
        id: rId);
  }
}
