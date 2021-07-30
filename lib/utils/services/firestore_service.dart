import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:travel_gh/utils/models/company.dart';
import 'package:travel_gh/utils/models/route.dart';
import 'package:travel_gh/utils/models/trip.dart';
import 'package:travel_gh/utils/services/firebase_auth_service.dart';

class FireStoreService {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  CollectionReference get _routesCollection => firestore.collection('routes');

  Stream routeListFirebaseStream(
      {String departure, String destination, DateTime dateTime}) {
    if (departure == null && destination == null && dateTime == null)
      return _routesCollection
          .where('dateTime', isGreaterThan: DateTime.now())
          .snapshots();
    else if (departure == null && destination == null)
      return _routesCollection
          .where('dateTime', isEqualTo: dateTime)
          .snapshots();
    else if (departure == null && dateTime == null)
      return _routesCollection
          .where('destination', isEqualTo: destination)
          .snapshots();
    else if (destination == null && dateTime == null)
      return _routesCollection
          .where('departure', isEqualTo: departure)
          .snapshots();
    else if (destination == null)
      _routesCollection
          .where('departure', isEqualTo: departure)
          .where('dateTime', isEqualTo: dateTime)
          .snapshots();
    else if (departure == null)
      _routesCollection
          .where('destination', isEqualTo: destination)
          .where('dateTime', isEqualTo: dateTime)
          .snapshots();
    else if (dateTime == null)
      _routesCollection
          .where('departure', isEqualTo: departure)
          .where('destination', isEqualTo: destination)
          .snapshots();
    return _routesCollection
        .where('departure', isEqualTo: departure)
        .where('destination', isEqualTo: destination)
        .where('dateTime', isEqualTo: dateTime)
        .snapshots();
  }

  Stream tripListFromFirebase() => firestore
      .collection('trips')
      .where('userId', isEqualTo: FirebaseAuthService().currentUser.uid)
      .snapshots();

  List<CustomRoute> getRouteListFromSnapshot(
          AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) =>
      snapshot.data.docs
          .map((e) => CustomRoute().fromFirebase(e.data(), e.id))
          .toList();

  List<Trip> getTripListFromSnapshot(
          AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) =>
      snapshot.data.docs
          .map((e) => Trip().fromFirebase(e.data(), e.id))
          .toList();

  Future<CustomRoute> getRouteWithId(String routeId) async {
    DocumentSnapshot firebaseRoute =
        await firestore.collection('routes').doc(routeId).get();
    return CustomRoute().fromFirebase(firebaseRoute.data(), routeId);
  }

  Future<Company> getCompanyWithId(String companyId) async {
    DocumentSnapshot firebaseCompany =
        await firestore.collection('companies').doc(companyId).get();
    return Company().fromFirebase(firebaseCompany.data(), companyId);
  }

  Future<Trip> getTripWithId(String tripId) async {
    DocumentSnapshot firebaseTrip =
        await firestore.collection('trips').doc(tripId).get();
    return Trip().fromFirebase(firebaseTrip.data(), tripId);
  }
  
}
