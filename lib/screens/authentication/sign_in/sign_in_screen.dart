import 'package:flutter/material.dart';
import 'package:travel_gh/screens/authentication/register/register_screen.dart';
import 'package:travel_gh/screens/booking/search_trip.dart';
import 'package:travel_gh/shared/background.dart';
import 'package:travel_gh/shared/custom_rounded_button.dart';
import 'package:travel_gh/shared/custom_textformfield.dart';
import 'package:travel_gh/shared/custom_textspan.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key key}) : super(key: key);

  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        body: BackgroundDesign(
          child: Center(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 40, vertical: 30),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Sign In',
                    style: TextStyle(fontWeight: FontWeight.w900, fontSize: 32),
                  ),
                  SizedBox(height: 50),
                  CustomTextFormField(
                    hintText: 'Email',
                    keyboardType: TextInputType.emailAddress,
                  ),
                  SizedBox(height: 24),
                  CustomTextFormField(
                    hintText: 'Password',
                    obscureText: true,
                  ),
                  SizedBox(height: 24),
                  CustomRoundedButton(
                    height: 60,
                    width: double.infinity,
                    text: 'SIGN IN',
                    onPressed: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SearchTripScreen()));
                    },
                  ),
                  SizedBox(height: 24),
                  CustomTextSpan(
                    firstText: 'Don\'t have an account?',
                    secondText: 'Register',
                    onPressed: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => RegisterScreen()));
                    },
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
