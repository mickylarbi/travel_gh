import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:travel_gh/screens/auth/sign_in/sign_in_screen.dart';
import 'package:travel_gh/screens/booking/pending_trips_screen.dart';
import 'package:travel_gh/screens/booking/search_trip_screen.dart';
import 'package:travel_gh/utils/services/firebase_auth_service.dart';

class AuthWidget extends StatelessWidget {
  final bool isNewUser;
  AuthWidget([this.isNewUser = false]);

  @override
  Widget build(BuildContext context) {
    if (FirebaseAuthService().currentUser == null) return SignInScreen();
    return isNewUser ? SearchTripScreen() : PendingTripsScreen();
  }
}
