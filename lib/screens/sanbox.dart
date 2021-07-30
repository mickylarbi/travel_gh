import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key key}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(children: [
          SingleChildScrollView(
            controller: _scrollController,
            child: Column(),
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
                                padding: EdgeInsets.symmetric(horizontal: 24),
                                alignment: Alignment.centerLeft,
                                height: 50,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('data'),
                                  ],
                                )),
                          )
                        : Opacity(
                            opacity: 1 - (_scrollController.offset / 350) >= 0
                                ? 1 - (_scrollController.offset / 350)
                                : 0,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 24),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text('data'),
                                        ],
                                      ),
                                      Text(
                                        'From:',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      // customDropDownButton(),
                                      SizedBox(height: 20),
                                      Text(
                                        'To:',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      // customDropDownButton(true),
                                    ],
                                  ),
                                ),
                                TableCalendar(
                                  firstDay: DateTime.now(),
                                  focusedDay: DateTime.now(),
                                  lastDay:
                                      DateTime.now().add(Duration(days: 31)),
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
        ]),
      ),
      endDrawer: Drawer(),
    );
  }

  // customDropDownButton([bool isDestination = false]) {
  //   return Container(
  //     decoration: BoxDecoration(
  //         borderRadius: BorderRadius.circular(10), color: Color(0xFFF0F0F0)),
  //     child: DropdownButtonFormField(
  //       value: isDestination ? _selectedDestination : _selectedDeparture,
  //       onChanged: (newValue) {
  //         if (isDestination)
  //           _selectedDestination = newValue;
  //         else
  //           _selectedDeparture = newValue;
  //       },
  //       decoration: InputDecoration(
  //         contentPadding: EdgeInsets.symmetric(horizontal: 18),
  //         border: OutlineInputBorder(
  //             borderSide: BorderSide.none,
  //             borderRadius: BorderRadius.circular(10)),
  //       ),
  //       // items: vlValue
  //       //     .map((e) => DropdownMenuItem(
  //       //           value: e,
  //       //           child: Text(e),
  //       //         ))
  //       //     .toList(),
  //     ),
  //   );
  // }
}
