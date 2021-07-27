import 'package:flutter/material.dart';
import 'package:travel_gh/screens/auth/register/register_screen.dart';
import 'package:travel_gh/shared/app_services.dart';
import 'package:travel_gh/shared/background.dart';
import 'package:travel_gh/shared/custom_rounded_button.dart';
import 'package:travel_gh/shared/custom_textformfield.dart';
import 'package:travel_gh/shared/custom_textspan.dart';
import 'package:travel_gh/utils/services/firebase_auth_service.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key key}) : super(key: key);

  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
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
                    controller: _emailController,
                    hintText: 'Email',
                    keyboardType: TextInputType.emailAddress,
                  ),
                  SizedBox(height: 24),
                  CustomTextFormField(
                    controller: _passwordController,
                    hintText: 'Password',
                    obscureText: true,
                  ),
                  SizedBox(height: 24),
                  CustomRoundedButton(
                    height: 60,
                    width: double.infinity,
                    text: 'SIGN IN',
                    onPressed: () {
                      if (_emailController.text.isEmpty &&
                          _passwordController.text.isEmpty) {
                        AppServices.showAlertDialog(context,
                            content: 'Enter email and password');
                      } else if (_emailController.text.isEmpty) {
                        AppServices.showAlertDialog(context,
                            content: 'Email field is empty');
                      } else if (_passwordController.text.isEmpty) {
                        AppServices.showAlertDialog(context,
                            content: 'Password field is empty');
                      } else if (!_emailController.text.contains(RegExp(
                          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+"))) {
                        AppServices.showAlertDialog(context,
                            content: 'Email address is invalid');
                      } else if (_passwordController.text.length < 6) {
                        AppServices.showAlertDialog(context,
                            content: 'Password is invalid');
                      } else
                        FirebaseAuthService(context).signInUser(
                            _emailController.text.trim(),
                            _passwordController.text);
                      // Navigacontext) => SearchTripScreen()));
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

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
