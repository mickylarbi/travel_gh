import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:travel_gh/screens/booking/pending_trips_screen.dart';
import 'package:travel_gh/shared/custom_rounded_button.dart';
import 'package:travel_gh/shared/custom_textformfield.dart';
import 'package:travel_gh/utils/services/firebase_auth_service.dart';

class SearchTripScreen extends StatefulWidget {
  const SearchTripScreen({Key key}) : super(key: key);

  @override
  _SearchTripScreenState createState() => _SearchTripScreenState();
}

class _SearchTripScreenState extends State<SearchTripScreen> {
  ScrollController _scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        body: SafeArea(
          child: Stack(
            children: [
              ListView(
                controller: _scrollController,
                children: [
                  Container(height: 350),
                  ...List.generate(10, (index) => tripCard(context))
                ],
              ),
              AnimatedBuilder(
                  animation: _scrollController,
                  builder: (context, snapshot) {
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
                                alignment: Alignment.bottomLeft,
                                child: Container(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 24),
                                    alignment: Alignment.centerLeft,
                                    height: 50,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text('data'),
                                        appBarActions(),
                                      ],
                                    )),
                              )
                            : Opacity(
                                opacity:
                                    1 - (_scrollController.offset / 350) >= 0
                                        ? 1 - (_scrollController.offset / 350)
                                        : 0,
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Padding(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 24),
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
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text('data'),
                                              appBarActions()
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
                                    TableCalendar(
                                      firstDay: DateTime.now(),
                                      focusedDay: DateTime.now(),
                                      lastDay: DateTime.now()
                                          .add(Duration(days: 31)),
                                      calendarStyle: CalendarStyle(
                                        todayDecoration: BoxDecoration(
                                            color: Colors.grey.withOpacity(.5),
                                            shape: BoxShape.circle),
                                        selectedDecoration: BoxDecoration(
                                            color: Color(4288653530),
                                            shape: BoxShape.circle),
                                      ),
                                      calendarFormat: CalendarFormat.week,
                                      availableCalendarFormats: {
                                        CalendarFormat.week: ''
                                      },
                                      onFormatChanged: (calendarFormat) {},
                                      // selectedDayPredicate: (day) {
                                      // return isSameDay(_selectedDay, day);
                                      // },
                                      onDaySelected: (selectedDay, focusedDay) {
                                        // setState(() {
                                        //   _selectedDay = selectedDay;
                                        //   _focusedDay = focusedDay;
                                        // });
                                      },
                                    ),
                                  ],
                                ),
                              ),
                      ),
                    );
                  }),
            ],
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
                        builder: (context) =>
                            PendingTripsScreen()));
            }),
        PopupMenuButton(
          icon: Icon(Icons.more_vert),
          onSelected: (value) {
            FirebaseAuthService(context)
                .signOutUser();
          },
          itemBuilder: (context) => [
            PopupMenuItem(
              child: Text('Sign Out'),
              value: 'Sign Out',
            )
          ],
        ),
      ],
    );
  }

  Container tripCard(BuildContext context) {
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
                Image.asset(
                  'assets/images/STC-SMALLyyy-LOGO-WHITE.png',
                  height: 50,
                  width: 140,
                ),
                Spacer(),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Icon(Icons.ac_unit, color: Color(0xFF00CAD9), size: 18),
                      Icon(Icons.wifi, color: Color(0xFF00CAD9), size: 18),
                      Icon(Icons.power, color: Color(0xFF00CAD9), size: 18),
                      FaIcon(FontAwesomeIcons.mugHot,
                          color: Color(0xFF00CAD9), size: 16),
                      FaIcon(FontAwesomeIcons.restroom,
                          color: Color(0xFF00CAD9), size: 16),
                    ]
                        .map((e) => Container(
                              // margin:
                              //     EdgeInsets.symmetric(horizontal: 1),
                              alignment: Alignment.center,
                              height: 28, width: 28,
                              decoration: BoxDecoration(
                                  border: Border.all(color: Color(0xFF00CAD9)),
                                  borderRadius: BorderRadius.circular(5)),
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
                      Text(
                        'GHC',
                        style: TextStyle(fontSize: 10),
                      ),
                      Text(' 40.00',
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
                      Text(
                        '08:00 ',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text('AM',
                          style: TextStyle(
                            fontSize: 10,
                          )),
                    ],
                  ),
                  Spacer(),
                  CustomRoundedButton(
                    // onPressed: () {
                    //   Navigator.push(
                    //       context,
                    //       MaterialPageRoute(
                    //           builder: (context) => BookingScreen()));
                    // },
                    text: 'BOOK NOW',
                    width: 100,
                    textStyle: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        letterSpacing: 1),
                    borderRadii: 5,
                  ),
                ]),
          ),
        ],
      ),
    );
  }
}
