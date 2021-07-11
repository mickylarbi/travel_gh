import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class PendingTripsScreen extends StatefulWidget {
  const PendingTripsScreen({Key key}) : super(key: key);

  @override
  _PendingTripsScreenState createState() => _PendingTripsScreenState();
}

class _PendingTripsScreenState extends State<PendingTripsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pending Trips'),
        backgroundColor: Colors.white,
      ),
      body: ListView(
        padding: EdgeInsets.all(8),
        children: [
          Card(
            child: ListTile(
              leading: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(DateTime.now().day.toString()),
                  Text(DateFormat.MMM().format(DateTime.now())),
                ],
              ),
              title: Text('Kumasi - Cape Coast'),
              subtitle: Text('08:00AM'),
              trailing: Text('2 seats'),
            ),
          )
        ],
      ),
    );
  }
}
