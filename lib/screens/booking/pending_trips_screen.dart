import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:travel_gh/screens/booking/search_trip_screen.dart';
import 'package:travel_gh/screens/booking/ticket_screen.dart';
import 'package:travel_gh/shared/custom_textformfield.dart';
import 'package:travel_gh/utils/services/firebase_auth_service.dart';

class PendingTripsScreen extends StatefulWidget {
  const PendingTripsScreen({Key key}) : super(key: key);

  @override
  _PendingTripsScreenState createState() => _PendingTripsScreenState();
}

class _PendingTripsScreenState extends State<PendingTripsScreen> {
  DateTime _focusedDay = DateTime.now();

  DateTime _selectedDay;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          leading: SizedBox(),
          iconTheme: IconThemeData(color: Colors.black),
          textTheme: TextTheme(
              headline6: TextStyle(color: Colors.black, fontSize: 16)),
          title: Text('Pending Trips'),
          backgroundColor: Colors.white,
          actions: [
            IconButton(
                icon: Icon(Icons.list),
                onPressed: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => SearchTripScreen()));
                }),
            PopupMenuButton(
              icon: Icon(Icons.more_vert),
              onSelected: (value) {
                FirebaseAuthService(context).signOutUser();
              },
              itemBuilder: (context) => [
                PopupMenuItem(
                  
                  child: Text('Sign Out'),
                  value: 'Sign Out',
                )
              ],
            ),
          ],
        ),
        body: ListView(
          padding: EdgeInsets.all(8),
          children: [
            Card(
              child: ListTile(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => TicketScreen()));
                },
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
            ),
            Container(
              alignment: Alignment.center,
              height: 400,
              color: Color(0xFF00CAD9),
              child: Transform.translate(
                offset: Offset(0, 0),
                child: Opacity(
                  opacity: 1,
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 24),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('data'),
                                Row(
                                  children: [
                                    IconButton(
                                        icon: Icon(Icons.menu),
                                        onPressed: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      PendingTripsScreen()));
                                        }),
                                    PopupMenuButton(
                                      icon: Icon(Icons.more_vert),
                                      onSelected: (value) {
                                        FirebaseAuthService(context).signOutUser();
                                      },
                                      itemBuilder: (context) => [
                                        PopupMenuItem(
                                          child: Text('Sign Out'),
                                          value: 'Sign Out',
                                        )
                                      ],
                                    ),
                                  ],
                                )
                              ],
                            ),
                            Text(
                              'From:',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                            CustomTextFormField(),
                            SizedBox(height: 20),
                            Text(
                              'To:',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                            CustomTextFormField(),
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: TableCalendar(
                          firstDay: DateTime.now(),
                          focusedDay: _focusedDay,
                          lastDay: DateTime.now().add(Duration(days: 31)),
                          calendarStyle: CalendarStyle(
                            todayDecoration: BoxDecoration(
                                color: Colors.grey.withOpacity(.5),
                                shape: BoxShape.circle),
                            selectedDecoration: BoxDecoration(
                                color: Color(4288653530),
                                shape: BoxShape.circle),
                          ),
                          calendarFormat: CalendarFormat.week,
                          availableCalendarFormats: {CalendarFormat.week: ''},
                          onFormatChanged: (calendarFormat) {},
                          selectedDayPredicate: (day) {
                            return isSameDay(_selectedDay, day);
                          },
                          onDaySelected: (selectedDay, focusedDay) {
                            setState(() {
                              _selectedDay = selectedDay;
                              _focusedDay = focusedDay;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
//TODO: cancel trip