import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:travel_gh/shared/custom_rounded_button.dart';
import 'package:travel_gh/utils/services/firestore_service.dart';
// import 'package:travel_gh/utils/services/firestore_service.dart';

class Sandbox extends StatelessWidget {
  Sandbox({Key key}) : super(key: key);
  final List<String> names = [
    'Crown International Travel',
    'Happy Tours',
    'Insider Voyage',
    'Oasis Travel',
    'Soul Travel Inc'
  ];
  final List<String> photoUrls = [
    'gs://travel-gh-ea6ca.appspot.com/crown international travel',
    'gs://travel-gh-ea6ca.appspot.com/happy tours',
    'gs://travel-gh-ea6ca.appspot.com/insider voyage',
    'gs://travel-gh-ea6ca.appspot.com/oasis travel',
    'gs://travel-gh-ea6ca.appspot.com/soul travel inc'
  ];

  String getPrice(String departure, String destination, int featuresNumber) {
    int departureIndex = cities.indexOf(departure);
    int destinationIndex = cities.indexOf(destination);

    double heuristics =
        (coordinates[departureIndex][0] - coordinates[destinationIndex][0])
                .abs() +
            (coordinates[departureIndex][1] - coordinates[destinationIndex][1])
                .abs();
    return ((20.44989775051126 * heuristics) + (featuresNumber * 3))
        .roundToDouble()
        .toStringAsFixed(2);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: CustomRoundedButton(
            height: 60,
            text: 'UPLOAD',
            onPressed: () async {
              showDialog(
                  barrierDismissible: false,
                  context: context,
                  builder: (context) => AlertDialog(
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Populating Database'),
                            CupertinoActivityIndicator()
                          ],
                        ),
                      ));
              Random random = Random();
              String departure;
              String destination;
              String companyId;
              String price;
              List<String> features = [];
              int seatsAvailable;
              DateTime dateTime;
              DateTime today = DateTime.now();
              int daysInMonth = DateTimeRange(
                      start: today, end: DateTime(today.year, today.month + 1))
                  .duration
                  .inDays;
              int limit;
              departure = cities[random.nextInt(cities.length)];

              do {
                destination = cities[random.nextInt(cities.length)];
              } while (destination == departure);

              companyId = companyIds[random.nextInt(companyIds.length)];

              seatsAvailable = random.nextInt(30) + 1;

              dateTime = today
                  .add(Duration(
                      days: random.nextInt(daysInMonth),
                      hours: random.nextInt(24),
                      minutes: random.nextInt(2) * 30))
                  .roundDown(delta: Duration(minutes: 30));
              // dateTime=

              limit = random.nextInt(Features.values.length + 1);
              for (int i = 0; i < limit; i++) {
                int randomIndex = random.nextInt(limit);

                while (true) {
                  if (!features
                      .contains(Features.values[randomIndex].toString())) {
                    features.add(Features.values[randomIndex].toString());
                    break;
                  }
                  randomIndex = random.nextInt(limit);
                }
              }

              price = getPrice(departure, destination, features.length);

              // print(
              //     '$departure\n$destination\n$companyId\n$seatsAvailable\n$dateTime\n$features\n$price');

              try {
                await FireStoreService().firestore.collection('routes').add({
                  'departure': departure,
                  'destination': destination,
                  'companyId': companyId,
                  'seatsAvailable': seatsAvailable,
                  'dateTime': dateTime,
                  'features': features,
                  'price': price,
                }).then((value) {
                  Navigator.pop(context);
                  showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                            content: Text('Database populated successfully'),
                          ));
                }).catchError((error) {
                  print(error);
                });
              } catch (e) {
                print(e);
              }
            },
          ),
        ),
      ),
    );
  }
}

extension on DateTime {
  DateTime roundDown({Duration delta = const Duration(seconds: 15)}) {
    return DateTime.fromMillisecondsSinceEpoch(this.millisecondsSinceEpoch -
        this.millisecondsSinceEpoch % delta.inMilliseconds);
  }
}



List<String> companyIds = [
  '4pWMhNWtq8bP7pNIRZ3Y',
  'MvHChBWXLFZ4GEcSglXg',
  'RtiZ2qilj1r1NVF8jAMh',
  'dSsPC6IIgaYsLBXkqsJd',
  'gvQOwMBtjIkg8N29G6Et'
];

enum Features { temperatureControl, wifi, electricity, refreshment, restroom }

List<String> cities = [
  'Takoradi',
  'Cape Coast',
  'Accra',
  'Ho',
  'Koforidua',
  'Kumasi',
  'Tarkwa',
  'Tema',
  'Sunyani',
  'Tamale',
  'Wa',
  'Bolgatanga',
  'Obuasi',
  'Winneba'
];

List<List> coordinates = [
  [4.9016, -1.7831],
  [5.1315, -1.2795],
  [5.6037, -0.1870],
  [6.6101, 0.4785],
  [6.0784, -0.2714],
  [6.6666, -1.6163],
  [5.3018, -1.9930],
  [5.7348, 0.0302],
  [7.3349, -2.3123],
  [9.4034, -0.8424],
  [10.0601, -2.5099],
  [10.7875, -0.8580],
  [6.2012, -1.6913],
  [5.3622, -0.6299]
];
