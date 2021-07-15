import 'package:flutter/material.dart';
import 'package:travel_gh/screens/booking/booking_screen.dart';
import 'package:travel_gh/screens/booking/pending_trips_screen.dart';
import 'package:travel_gh/shared/customSliverList.dart';
import 'package:travel_gh/shared/custom_rounded_button.dart';
import 'package:travel_gh/shared/custom_textformfield.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:date_picker_timeline/date_picker_timeline.dart';

class SearchTripScreen extends StatelessWidget {
  const SearchTripScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        body: SafeArea(
          child: CustomScrollView(
            slivers: [
              SliverPersistentHeader(
                  floating: true,
                  pinned: true,
                  delegate: CustomSliverPersistentHeader()),
              SliverList(
                  delegate: CustomSliverList([
                tripCard(context),
                tripCard(context),
                tripCard(context),
                tripCard(context),
                tripCard(context),
                tripCard(context),
                tripCard(context),
                tripCard(context),
                tripCard(context),
                tripCard(context),
                tripCard(context),
              ])),
            ],
          ),
        ),
      ),
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
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => BookingScreen()));
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
                ]),
          ),
        ],
      ),
    );
  }
}

class CustomSliverPersistentHeader extends SliverPersistentHeaderDelegate {
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    // DateTimeRange(
    //     start: DateTime.now(), end: DateTime.now() + DateTime.daysPerWeek);
    return appBarWidget(shrinkOffset, context);
  }

  appBarWidget(double shrinkOffset, BuildContext context) {
    if (shrinkOffset >= 50) {
      return AnimatedContainer(
          duration: Duration(milliseconds: 200),
          padding: EdgeInsets.symmetric(horizontal: 24),
          alignment: Alignment.centerLeft,
          height: shrinkOffset < 51 ? 350 : 50,
          color: Color(0xFF00CAD9),
          child: Text('From:  To:'));
    }
    return Container(
      alignment: Alignment.center,
      color: Color(0xFF00CAD9),
      child: Transform.translate(
        offset: Offset(0, -shrinkOffset),
        child: Opacity(
          opacity: 1 - (shrinkOffset / 350),
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
                        IconButton(
                            icon: Icon(Icons.menu),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          PendingTripsScreen()));
                            })
                      ],
                    ),
                    Text(
                      'From:',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                    CustomTextFormField(),
                    SizedBox(height: 20),
                    Text(
                      'To:',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                    CustomTextFormField(),
                  ],
                ),
              ),
              Expanded(
                flex: 2,
                child: ConstrainedBox(
                  constraints: BoxConstraints(maxHeight: 100, minHeight: 20),
                  child: DatePicker(
                    DateTime.now(),
                    // height: 70,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  // TODO: implement maxExtent
  double get maxExtent => 350;

  @override
  // TODO: implement minExtent
  double get minExtent => 50;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}

