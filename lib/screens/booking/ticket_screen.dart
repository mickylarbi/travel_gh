import 'package:flutter/material.dart';
import 'package:travel_gh/shared/background.dart';
import 'package:qr_flutter/qr_flutter.dart';

class TicketScreen extends StatelessWidget {
  const TicketScreen({Key key}) : super(key: key);

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
              ),
              SliverFillRemaining(
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
                              'Alexander The Great',
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
                              'Kumasi - Cape Coast',
                              style: TextStyle(fontSize: 20),
                            ),
                            SizedBox(height: 20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      'Date:',
                                      style: TextStyle(
                                          color: Color(0xFF00C0CC),
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      '21 April 2021',
                                      style: TextStyle(fontSize: 20),
                                    ),
                                  ],
                                ),
                                SizedBox(width: 20),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      'Time:',
                                      style: TextStyle(
                                          color: Color(0xFF00C0CC),
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      '08:00 AM',
                                      style: TextStyle(fontSize: 20),
                                    ),
                                  ],
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
