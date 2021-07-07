import 'package:flutter/material.dart';
import 'package:travel_gh/shared/background.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackgroundDesign(
        child: Center(child: Image.asset('assets/images/travelghlogo.png')),
      ),
    );
  }
}
