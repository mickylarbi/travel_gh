import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:travel_gh/shared/app_services.dart';
import 'package:travel_gh/shared/background.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:travel_gh/utils/models/company.dart';
import 'package:travel_gh/utils/models/route.dart';
import 'package:travel_gh/utils/models/trip.dart';
import 'package:travel_gh/utils/services/firebase_auth_service.dart';
import 'package:travel_gh/utils/services/firestore_service.dart';

class TicketScreen extends StatelessWidget {
  final Trip trip;
  final CustomRoute route;
  final Company company;
  const TicketScreen({Key key, this.trip, this.route, this.company})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: BackgroundDesign(
          child: CustomScrollView(
            slivers: <Widget>[
              SliverAppBar(
                backgroundColor: Colors.transparent,
                elevation: 0,
                iconTheme: IconThemeData(color: Colors.black),
                textTheme: TextTheme(
                    headline6: TextStyle(color: Colors.black, fontSize: 16)),
                expandedHeight: 120,
                pinned: true,
                floating: false,
                flexibleSpace: FlexibleSpaceBar(
                  title: Text('Payment confirmed!',
                      style: TextStyle(color: Colors.black)),
                ),
                actions: [
                  PopupMenuButton(
                    icon: Icon(Icons.more_vert),
                    onSelected: (value) {
                      showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                                title: Text('Cancel trip?'),
                                actions: [
                                  TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: Text('NO')),
                                  TextButton(
                                      onPressed: () {
                                        AppServices.showAlertDialog(context,
                                            title: 'Cancelling trip',
                                            barrierDismissible: false);
                                        try {
                                          FireStoreService()
                                              .firestore
                                              .collection('trips')
                                              .doc(trip.id)
                                              .delete()
                                              .then((value) {
                                            Navigator.pop(context);
                                            Navigator.pop(context);
                                            Navigator.pop(context);
                                          });
                                        } catch (e) {
                                          Navigator.pop(context);
                                          Navigator.pop(context);
                                          print(e);
                                        }
                                      },
                                      child: Text(
                                        'YES',
                                        style: TextStyle(color: Colors.red),
                                      ))
                                ],
                              ));
                    },
                    itemBuilder: (context) => [
                      PopupMenuItem(
                        child: Text('Cancel Trip'),
                        value: 'Cancel Trip',
                      )
                    ],
                  ),
                ],
              ),
              SliverToBoxAdapter(
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30.0),
                    child: Card(
                      color: Color(0xFFFAFAFA),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      child: Padding(
                        padding: const EdgeInsets.all(40.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Center(
                              child: QrImage(
                                data: "1234567890",
                                version: QrVersions.auto,
                                size: 200.0,
                              ),
                            ),
                            SizedBox(height: 20),
                            Text(
                              'Name:',
                              style: TextStyle(
                                  color: Color(0xFF00C0CC),
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              FirebaseAuthService().currentUser.displayName,
                              style: TextStyle(fontSize: 20),
                            ),
                            SizedBox(height: 20),
                            Text(
                              'Route:',
                              style: TextStyle(
                                  color: Color(0xFF00C0CC),
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              "${route.departure} - ${route.destination}",
                              style: TextStyle(fontSize: 20),
                            ),
                            SizedBox(height: 20),
                            Text(
                              'Date:',
                              style: TextStyle(
                                  color: Color(0xFF00C0CC),
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              DateFormat.yMMMMEEEEd().format(route.dateTime),
                              style: TextStyle(fontSize: 20),
                            ),
                            SizedBox(height: 20),
                            Text(
                              'Time:',
                              style: TextStyle(
                                  color: Color(0xFF00C0CC),
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              DateFormat.jm()
                                  .format(route.dateTime)
                                  .padLeft(8, '0'),
                              style: TextStyle(fontSize: 20),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
