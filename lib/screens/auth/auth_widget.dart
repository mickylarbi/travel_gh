import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:travel_gh/screens/auth/sign_in/sign_in_screen.dart';
import 'package:travel_gh/screens/booking/pending_trips_screen.dart';
import 'package:travel_gh/screens/booking/search_trip_screen.dart';
import 'package:travel_gh/utils/services/firebase_auth_service.dart';
import 'package:travel_gh/utils/services/firestore_service.dart';

class AuthWidget extends StatelessWidget {
  final bool isNewUser;
  AuthWidget([this.isNewUser = false]);

  @override
  Widget build(BuildContext context) {
    if (FirebaseAuthService().currentUser == null) return SignInScreen();
    return FutureBuilder<QuerySnapshot<Map<String, dynamic>>>(
      future: FireStoreService()
          .firestore
          .collection('trips')
          .where('userId', isEqualTo: FirebaseAuthService().currentUser.uid)
          .get(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasError)
          return Scaffold(
            body: Center(
              child: Text('Something went wrong'),
            ),
          );

        if (snapshot.connectionState == ConnectionState.done) {
          print(FireStoreService().getTripListFromSnapshot(snapshot).length);
          return FireStoreService().getTripListFromSnapshot(snapshot).length ==
                  0
              ? SearchTripScreen()
              : PendingTripsScreen();
        }

        return Scaffold(
          body: Center(
            child: CupertinoActivityIndicator(),
          ),
        );
      },
    );
  }
}
