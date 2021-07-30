import 'package:flutter/material.dart';
import 'package:travel_gh/screens/auth/auth_widget.dart';
import 'package:travel_gh/shared/background.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 3)).then((value) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => AuthWidget()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackgroundDesign(
        child: Center(child: Image.asset('assets/images/travelghlogo.png')),
      ),
    );
  }
}
