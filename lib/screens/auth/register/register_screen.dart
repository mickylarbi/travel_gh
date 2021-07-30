import 'package:flutter/material.dart';
import 'package:travel_gh/screens/auth/sign_in/sign_in_screen.dart';
import 'package:travel_gh/shared/app_services.dart';
import 'package:travel_gh/shared/background.dart';
import 'package:travel_gh/shared/custom_rounded_button.dart';
import 'package:travel_gh/shared/custom_textformfield.dart';
import 'package:travel_gh/shared/custom_textspan.dart';
import 'package:travel_gh/utils/services/firebase_auth_service.dart';
import 'package:travel_gh/utils/models/custom_user.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key key}) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool _tnCAgreed = false;

  TextEditingController _firstNameController = TextEditingController();
  TextEditingController _surnameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();

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
                    controller: _firstNameController,
                    hintText: 'First name',
                  ),
                  SizedBox(height: 24),
                  CustomTextFormField(
                    controller: _surnameController,
                    hintText: 'Surname',
                  ),
                  SizedBox(height: 24),
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
                  CustomTextFormField(
                    controller: _confirmPasswordController,
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
                      onPressed: validate),
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
              firstText: 'I agree to the',
              secondText: 'Terms and Conditions',
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }

  validate() {
    if (_firstNameController.text.isEmpty ||
        _surnameController.text.isEmpty ||
        _emailController.text.isEmpty ||
        _passwordController.text.isEmpty ||
        _confirmPasswordController.text.isEmpty) {
      AppServices.showAlertDialog(context,
          content: 'One or more fields are empty');
    } else if (!_emailController.text.contains(RegExp(
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+"))) {
      AppServices.showAlertDialog(context, content: 'Email address is invalid');
    } else if (_passwordController.text != _confirmPasswordController.text) {
      AppServices.showAlertDialog(context, content: 'Passwords do not match');
    } else if (_passwordController.text.length < 6) {
      AppServices.showAlertDialog(context,
          content: 'Password should not be less than 6 characters');
    } else if (!_tnCAgreed) {
      AppServices.showAlertDialog(context,
          content: 'You have to agree to the Terms and Conditions');
    } else
    
      FirebaseAuthService(context).registerUser(
          CustomUser(
              firstName: _firstNameController.text.trim(),
              surname: _surnameController.text.trim(),
              email: _emailController.text.trim()),
          _passwordController.text);
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _surnameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }
}
