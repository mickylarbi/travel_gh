import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:travel_gh/screens/booking/search_trip_screen.dart';
import 'package:travel_gh/screens/booking/ticket_screen.dart';
import 'package:travel_gh/utils/models/company.dart';
import 'package:travel_gh/utils/models/route.dart';
import 'package:travel_gh/utils/models/trip.dart';
import 'package:travel_gh/utils/services/firebase_auth_service.dart';
import 'package:travel_gh/utils/services/firebase_storage_service.dart';
import 'package:travel_gh/utils/services/firestore_service.dart';

class PendingTripsScreen extends StatefulWidget {
  const PendingTripsScreen({Key key}) : super(key: key);

  @override
  _PendingTripsScreenState createState() => _PendingTripsScreenState();
}

class _PendingTripsScreenState extends State<PendingTripsScreen> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => true,
      child: Scaffold(
        appBar: AppBar(
          elevation: 5,
          iconTheme: IconThemeData(color: Colors.black),
          textTheme: TextTheme(
              headline6: TextStyle(color: Colors.black, fontSize: 16)),
          title: Text('Pending Trips'),
          backgroundColor: Colors.white,
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.only(top: 10, bottom: 30),
          child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
              stream: FireStoreService().tripListFromFirebase(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Container(
                      height: MediaQuery.of(context).size.height,
                      alignment: Alignment.center,
                      child: Text('Something went wrong'));
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Container(
                      height: MediaQuery.of(context).size.height,
                      alignment: Alignment.center,
                      child: CupertinoActivityIndicator());
                }

                return Column(
                    children: FireStoreService()
                        .getTripListFromSnapshot(snapshot)
                        .map((e) => tripCard(e))
                        .toList());
              }),
        ),
        drawer: Drawer(
          child: SingleChildScrollView(
              child: Column(
            children: [
              UserAccountsDrawerHeader(
                  accountName:
                      Text(FirebaseAuthService().currentUser.displayName),
                  accountEmail: Text(FirebaseAuthService().currentUser.email)),
              ListTile(
                title: Text('Search Trip'),
                onTap: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => SearchTripScreen()));
                },
              ),
              Divider(),
              ListTile(
                title: Text('Sign Out'),
                onTap: () {
                  FirebaseAuthService(context).signOutUser();
                },
              ),
            ],
          )),
        ),
      ),
    );
  }

  FutureBuilder tripCard(Trip trip) {
    Company tCompany;
    CustomRoute tRoute;
    return FutureBuilder<CustomRoute>(
        future: FireStoreService().getRouteWithId(trip.routeId),
        builder: (context, fsnapshot) {
          if (fsnapshot.hasError)
            return Container(
                margin: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                padding: EdgeInsets.all(18),
                height: 300,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text("Something went wrong"));

          if (fsnapshot.connectionState == ConnectionState.done) {
            tRoute = fsnapshot.data;
            return Container(
              height: 300,
              width: double.infinity,
              margin: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                      color: Colors.grey[300].withOpacity(.5),
                      blurRadius: 1,
                      spreadRadius: 1)
                ],
              ),
              child: Material(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(10),
                child: InkWell(
                  onTap: () {
                    if (tCompany != null)
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => TicketScreen(
                                    trip: trip,
                                    company: tCompany,
                                    route: tRoute,
                                  )));
                  },
                  child: Padding(
                    padding: EdgeInsets.all(18),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          DateFormat.yMMMMEEEEd()
                              .format(fsnapshot.data.dateTime),
                          style: TextStyle(fontSize: 16),
                        ),
                        Text(
                          DateFormat.jm()
                              .format(fsnapshot.data.dateTime)
                              .padLeft(8, '0'),
                          style: TextStyle(fontSize: 16),
                        ),
                        SizedBox(
                          height: 150,
                          child: FutureBuilder<Company>(
                              future: FireStoreService()
                                  .getCompanyWithId(fsnapshot.data.companyId),
                              builder: (context, ffsnapshot) {
                                if (ffsnapshot.hasError)
                                  return Text('Something went wrong');
                                if (ffsnapshot.connectionState ==
                                    ConnectionState.done) {
                                  tCompany = ffsnapshot.data;
                                  return Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      FutureBuilder<String>(
                                          future: FirebaseStorageService()
                                              .getCompanyPhotosUrl(
                                                  "${ffsnapshot.data.photoUrl}logo_transparent.png"),
                                          builder: (context, fffsnapshot) {
                                            if (fffsnapshot.hasError)
                                              return Text(
                                                  'Something went wrong');
                                            if (fffsnapshot.connectionState ==
                                                ConnectionState.done)
                                              return Image.network(
                                                fffsnapshot.data,
                                                height: 100,
                                              );
                                            return Container(
                                                height: 100,
                                                child:
                                                    CupertinoActivityIndicator());
                                          }),
                                      Text(ffsnapshot.data.name),
                                    ],
                                  );
                                }
                                return CupertinoActivityIndicator();
                              }),
                        ),
                        Text(
                            "${fsnapshot.data.departure} - ${fsnapshot.data.destination}"),
                        Text(
                            "${trip.seatsBooked} ${trip.seatsBooked == 1 ? "seat" : "seats"}")
                      ],
                    ),
                  ),
                ),
              ),
            );
          }

          return Container(
            margin: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            padding: EdgeInsets.all(18),
            height: 300,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(10),
            ),
          );
        });
  }
}
