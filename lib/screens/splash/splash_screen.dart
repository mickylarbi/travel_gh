import 'package:flutter/material.dart';
import 'package:travel_gh/screens/auth/auth_widget.dart';
import 'package:travel_gh/shared/background.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  Animation _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
      reverseDuration: Duration(milliseconds: 500),
    );

    _animation = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeOutQuart,
        reverseCurve: Curves.easeInCubic));

    _animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed)
        Future.delayed(Duration(seconds: 2), () {
          _animationController.reverse();
        });

      if (status == AnimationStatus.dismissed)
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => AuthWidget()));
    });

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _animationController.forward();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackgroundDesign(
        child: Center(
          child: AnimatedBuilder(
            animation: _animation,
            builder: (context, child) {
              return Opacity(
                opacity: _animation.value,
                child: Image.asset('assets/images/travelghlogo.png'),
              );
            },
          ),
        ),
      ),
    );
  }

// TODO: no internet connection stuff
  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}
