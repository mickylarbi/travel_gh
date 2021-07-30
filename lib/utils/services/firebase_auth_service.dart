import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:travel_gh/screens/auth/auth_widget.dart';
import 'package:travel_gh/shared/app_services.dart';
import 'package:travel_gh/utils/models/custom_user.dart';

class FirebaseAuthService {
  BuildContext context;
  FirebaseAuth _auth = FirebaseAuth.instance;

  FirebaseAuthService([this.context]);

  Stream<User> get authStream => _auth.userChanges();
  User get currentUser => _auth.currentUser;
  // User get user => _auth.

  registerUser(CustomUser newUser, String password) async {
    try {
      AppServices.showAlertDialog(context,
          title: 'Creating account...', barrierDismissible: false);
      UserCredential _usercredential =
          await _auth.createUserWithEmailAndPassword(
              email: newUser.email, password: password);
      await _usercredential.user
          .updateDisplayName('${newUser.firstName} ${newUser.surname}');
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  AuthWidget(_usercredential.additionalUserInfo.isNewUser)));
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context);
      if (e.code == 'weak-password') {
        AppServices.showAlertDialog(context,
            content: 'The password provided is too weak.');
        print('${e.message}');
      } else if (e.code == 'email-already-in-use') {
        AppServices.showAlertDialog(context,
            content: 'An account already exists for that email.');
      }
    } catch (e) {
      Navigator.pop(context);
      AppServices.showAlertDialog(context, content: e.toString());
      print(e.toString());
    }
  }

  signInUser(String email, String password) async {
    AppServices.showAlertDialog(context,
        title: 'Signing in', barrierDismissible: false);
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => AuthWidget()));
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context);
      if (e.code == 'user-not-found') {
        AppServices.showAlertDialog(context,
            content: 'Email address not associated with an account');
      } else if (e.code == 'wrong-password') {
        AppServices.showAlertDialog(context, content: 'Password is wrong');
      }
    } catch (e) {
      Navigator.pop(context);
      AppServices.showAlertDialog(context, content: 'Something went wrong');
    }
  }

  signOutUser() async {
    try {
      AppServices.showAlertDialog(context,
          title: 'Signing Out', barrierDismissible: false);
      await _auth.signOut();
      Navigator.pop(context);

      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => AuthWidget()));
    } catch (e) {
      Navigator.pop(context);
      AppServices.showAlertDialog(context, content: 'Something went wrong');
    }
  }
}
