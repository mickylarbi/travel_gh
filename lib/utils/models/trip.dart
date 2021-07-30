class Trip {
  String id;
  String userId;
  String routeId;
  int seatsBooked;
  Trip({this.routeId, this.seatsBooked, this.userId, this.id});

  Trip fromFirebase(Map<String, dynamic> firebaseMap, String tId) => Trip(
      userId: firebaseMap['userId'],
      routeId: firebaseMap['routeId'],
      seatsBooked: firebaseMap['seatsBooked'],
      id: tId);
}
