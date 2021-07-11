import 'package:flutter/material.dart';
import 'package:travel_gh/screens/authentication/sign_in/sign_in_screen.dart';
import 'package:travel_gh/screens/booking/search_trip.dart';
import 'package:travel_gh/shared/background.dart';
import 'package:travel_gh/shared/custom_rounded_button.dart';
import 'package:travel_gh/shared/custom_textformfield.dart';
import 'package:travel_gh/shared/custom_textspan.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key key}) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool _tnCAgreed = false;
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
                    'Register',
                    style: TextStyle(fontWeight: FontWeight.w900, fontSize: 32),
                  ),
                  SizedBox(height: 50),
                  CustomTextFormField(
                    hintText: 'First name',
                  ),
                  SizedBox(height: 24),
                  CustomTextFormField(
                    hintText: 'Surname',
                  ),
                  SizedBox(height: 24),
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
                  CustomTextFormField(
                    hintText: 'Confirm password',
                    obscureText: true,
                  ),
                  SizedBox(height: 24),
                  tncRow(),
                  SizedBox(height: 24),
                  CustomRoundedButton(
                    height: 60,
                    width: double.infinity,
                    text: 'REGISTER',
                    onPressed: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (conotext) => SearchTripScreen()));
                    },
                  ),
                  SizedBox(height: 24),
                  CustomTextSpan(
                    firstText: 'Already have an account?',
                    secondText: 'Sign In',
                    onPressed: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SignInScreen()));
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

  Widget tncRow() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: InkWell(
        onTap: () {
          setState(() {
            _tnCAgreed = !_tnCAgreed;
          });
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Checkbox(
                value: _tnCAgreed,
                onChanged: (value) {
                  _tnCAgreed = value;
                  setState(() {});
                }),
            CustomTextSpan(
                firstText: 'Agree to the', secondText: 'Terms and Conditions'),
          ],
        ),
      ),
    );
  }
}
