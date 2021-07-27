import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:travel_gh/screens/booking/booking_screen.dart';
import 'package:travel_gh/screens/booking/pending_trips_screen.dart';
import 'package:travel_gh/shared/app_services.dart';
import 'package:travel_gh/shared/custom_rounded_button.dart';
import 'package:travel_gh/utils/models/company.dart';
import 'package:travel_gh/utils/models/route.dart';
import 'package:travel_gh/utils/services/firebase_auth_service.dart';
import 'package:travel_gh/utils/services/firebase_storage_service.dart';
import 'package:travel_gh/utils/services/firestore_service.dart';

class SearchTripScreen extends StatefulWidget {
  const SearchTripScreen({Key key}) : super(key: key);

  @override
  _SearchTripScreenState createState() => _SearchTripScreenState();
}

class _SearchTripScreenState extends State<SearchTripScreen> {
  FireStoreService _fireStoreService = FireStoreService();
  FirebaseFirestore get firestore => _fireStoreService.firestore;

  ScrollController _scrollController = ScrollController();

  List<String> _departures = [];
  List<String> _destinations = [];
  List<DateTime> _dateTimes = [];

  String _selectedDeparture;
  String _selectedDestination;
  DateTime _selectedDateTime;

  DateTime _focusedDay = DateTime.now();

  // TODO: change app bar title
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () async => false,
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Scaffold(
          body: SafeArea(
            child: Builder(builder: (context) {
              return Stack(
                children: [
                  SingleChildScrollView(
                    controller: _scrollController,
                    child: Column(
                      children: [
                        Container(height: 350),
                        StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                            stream: _fireStoreService.routeListFirebaseStream(
                                departure: _selectedDeparture,
                                destination: _selectedDestination,
                                dateTime: _selectedDateTime),
                            builder: (context, snapshot) {
                              if (snapshot.hasError) {
                                return Container(
                                    height: screenSize.height - 350,
                                    child: Center(
                                        child: Text('Something went wrong')));
                              }

                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return Container(
                                    height: screenSize.height - 350,
                                    child: Center(
                                        child: CupertinoActivityIndicator()));
                              }

                              FireStoreService()
                                  .getRouteListFromSnapshot(snapshot)
                                  .forEach((element) {
                                if (!_departures.contains(element.departure))
                                  _departures.add(element.departure);
                              });
                              FireStoreService()
                                  .getRouteListFromSnapshot(snapshot)
                                  .forEach((element) {
                                if (!_destinations
                                    .contains(element.destination))
                                  _destinations.add(element.destination);
                              });
                              FireStoreService()
                                  .getRouteListFromSnapshot(snapshot)
                                  .forEach((element) {
                                if (!_dateTimes.contains(element.dateTime))
                                  _dateTimes.add(element.dateTime);
                              });

                              return Column(
                                  children: FireStoreService()
                                      .getRouteListFromSnapshot(snapshot)
                                      .map((e) => tripCard(context, e))
                                      .toList());
                            }),
                      ],
                    ),
                  ),
                  AnimatedBuilder(
                      animation: _scrollController,
                      builder: (context, child) {
                        return Positioned(
                          top: _scrollController.offset > 300
                              ? -300
                              : -_scrollController.offset,
                          child: Container(
                            alignment: Alignment.center,
                            height: 350,
                            width: MediaQuery.of(context).size.width,
                            color: Color(0xFF00CAD9),
                            child: _scrollController.offset > 300
                                ? Align(
                                    alignment: Alignment.bottomCenter,
                                    child: Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 24),
                                        alignment: Alignment.centerLeft,
                                        height: 50,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              children: [
                                                if (_selectedDeparture != null)
                                                  Text(
                                                    'From: ',
                                                  ),
                                                if (_selectedDeparture != null)
                                                  Text(
                                                    '$_selectedDeparture  ',
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                if (_selectedDestination !=
                                                    null)
                                                  Text(
                                                    'To: ',
                                                    style: TextStyle(
                                                      color: Colors.grey,
                                                    ),
                                                  ),
                                                if (_selectedDestination !=
                                                    null)
                                                  Text(
                                                    '$_selectedDestination',
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                              ],
                                            ),
                                            appBarActions()
                                          ],
                                        )),
                                  )
                                : Opacity(
                                    opacity:
                                        1 - (_scrollController.offset / 350) >=
                                                0
                                            ? 1 -
                                                (_scrollController.offset / 350)
                                            : 0,
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 24),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Row(
                                                mainAxisSize: MainAxisSize.max,
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text('data'),
                                                  appBarActions()
                                                ],
                                              ),
                                              Text(
                                                'From:',
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              customDropDownButton(),
                                              SizedBox(height: 20),
                                              Text(
                                                'To:',
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              customDropDownButton(true),
                                            ],
                                          ),
                                        ),
                                        TableCalendar(
                                          firstDay: DateTime.now(),
                                          focusedDay: _focusedDay,
                                          lastDay: DateTime.now()
                                              .add(Duration(days: 31)),
                                          calendarStyle: CalendarStyle(
                                            todayDecoration: BoxDecoration(
                                                color:
                                                    Colors.grey.withOpacity(.5),
                                                shape: BoxShape.circle),
                                            selectedDecoration: BoxDecoration(
                                                color: Color(4288653530),
                                                shape: BoxShape.circle),
                                          ),
                                          calendarFormat: CalendarFormat.week,
                                          availableCalendarFormats: {
                                            CalendarFormat.week: ''
                                          },
                                          // enabledDayPredicate: (day) {
                                          //   return _dateTimes.contains(day);
                                          // },
                                          onFormatChanged: (calendarFormat) {},
                                          selectedDayPredicate: (day) {
                                            return isSameDay(
                                                _selectedDateTime, day);
                                          },
                                          onDaySelected:
                                              (selectedDay, focusedDay) {
                                            setState(() {
                                              _selectedDateTime = selectedDay;
                                              _focusedDay = focusedDay;
                                            });
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                          ),
                        );
                      }),
                ],
              );
            }),
          ),
        ),
      ),
    );
  }

  Row appBarActions() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
            icon: Icon(Icons.menu),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => PendingTripsScreen()));
            }),
        PopupMenuButton(
          icon: Icon(Icons.more_vert),
          onSelected: (value) {
            if (value == 'Sign Out') FirebaseAuthService(context).signOutUser();
            if (value == 'Clear') {
              _selectedDateTime =
                  _selectedDeparture = _selectedDestination = null;
              _scrollController.animateTo(0,
                  duration: Duration(milliseconds: 300), curve: Curves.easeOut);
              setState(() {});
            }
          },
          itemBuilder: (context) => [
            PopupMenuItem(
              child: Text('Clear'),
              value: 'Clear',
            ),
            PopupMenuItem(
              child: Text('Sign Out'),
              value: 'Sign Out',
            )
          ],
        ),
      ],
    );
  }

  customDropDownButton([bool isDestination = false]) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10), color: Color(0xFFF0F0F0)),
      child: DropdownButtonFormField(
        // validator: (string) {},
        value: isDestination ? _selectedDestination : _selectedDeparture,
        onChanged: (newValue) {
          if (isDestination) {
            _selectedDestination = newValue;
          } else {
            _selectedDeparture = newValue;
          }
          setState(() {});
        },
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(horizontal: 18),
          border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(10)),
        ),
        items: (isDestination ? _destinations : _departures)
            .map((e) => DropdownMenuItem(
                  value: e,
                  child: Text(e),
                ))
            .toList(),
      ),
    );
  }

  FutureBuilder tripCard(BuildContext context, CustomRoute route) {
    return FutureBuilder<Company>(
        future: FireStoreService().getCompanyWithId(route.companyId),
        builder: (context, fsnapshot) {
          Company company = fsnapshot.data;
          if (fsnapshot.hasError) {
            return Text("Something went wrong");
          }

          if (fsnapshot.connectionState == ConnectionState.done) {
            return Container(
              margin: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              padding: EdgeInsets.all(18),
              height: 140,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                      color: Color(0xFF00CAD9).withOpacity(.1),
                      blurRadius: 1,
                      spreadRadius: 1)
                ],
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(company.name),
                        Spacer(),
                        ConstrainedBox(
                          constraints:
                              BoxConstraints(maxHeight: 140, maxWidth: 50),
                          child: FutureBuilder<String>(
                              future: FirebaseStorageService().getCompanyPhotosUrl(
                                  '${company.photoUrl}linkedin_banner_image_1.png'),
                              builder: (context, ffsnapshot) {
                                if (ffsnapshot.hasError) {
                                  return Text("Something went wrong");
                                }

                                if (ffsnapshot.connectionState ==
                                    ConnectionState.done) {
                                  return Image.network(
                                    ffsnapshot.data,
                                  );
                                }
                                return CupertinoActivityIndicator();
                              }),
                        ),
                        Spacer(),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: AppServices.getFeaturesFromString(
                                    route.features)
                                .map((e) => Container(
                                      margin:
                                          EdgeInsets.symmetric(horizontal: 3),
                                      alignment: Alignment.center,
                                      height: 28,
                                      width: 28,
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: Color(0xFF00CAD9)),
                                          borderRadius:
                                              BorderRadius.circular(5)),
                                      child: e,
                                    ))
                                .toList()),
                      ],
                    ),
                  ),
                  VerticalDivider(),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.money,
                                color: Color(0xFF00CAD9),
                              ),
                              SizedBox(width: 10),
                              Text(
                                'GHC',
                                style: TextStyle(fontSize: 10),
                              ),
                              SizedBox(width: 2),
                              Text(route.price,
                                  style: TextStyle(
                                    color: Color(0xFF00CAD9),
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  )),
                            ],
                          ),
                          Divider(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.lock_clock,
                                color: Color(0xFF00CAD9),
                              ),
                              SizedBox(width: 10),
                              Text(
                                DateFormat.jm()
                                    .format(route.dateTime)
                                    .padLeft(8, '0')
                                    .substring(0, 5),
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(width: 2),
                              Text(
                                  DateFormat.jm()
                                      .format(route.dateTime)
                                      .padLeft(8, '0')
                                      .substring(6, 8),
                                  style: TextStyle(
                                    fontSize: 10,
                                  )),
                            ],
                          ),
                          Spacer(),
                          Stack(
                            fit: StackFit.loose,
                            alignment: Alignment.centerLeft,
                            clipBehavior: Clip.none,
                            children: [
                              CustomRoundedButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => BookingScreen(
                                                route: route,
                                                company: company,
                                              )));
                                },
                                text: 'BOOK NOW',
                                width: 100,
                                textStyle: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                    letterSpacing: 1),
                                borderRadii: 5,
                              ),
                              Positioned(
                                  left: -10,
                                  child: Container(
                                    alignment: Alignment.center,
                                    height: 24,
                                    width: 24,
                                    child: Text(
                                      route.seatsAvailable.toString(),
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        shape: BoxShape.circle),
                                  ))
                            ],
                          ),
                        ]),
                  ),
                ],
              ),
            );
          }
          return Container(
            margin: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            padding: EdgeInsets.all(18),
            height: 140,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(10),
            ),
          );
        });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _scrollController.dispose();
    super.dispose();
  }
}
