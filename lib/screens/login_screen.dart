import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:rider_app/main.dart';
import 'package:rider_app/screens/main_screen.dart';
import 'package:rider_app/screens/signup_screen.dart';
import 'package:rider_app/widgets/progress_indicator.dart';

class LogInScreen extends StatelessWidget {
  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController passwordTextEditingController = TextEditingController();
  static const String idScreen = 'loinScreen';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(
          children: [
            SizedBox(height: 35.0),
            Image(
              image: AssetImage('assets/images/logo.png'),
              width: 390.0,
              height: 250.0,
              alignment: Alignment.center,
            ),
            SizedBox(height: 1.0),
            Text(
              'Log in as a Rider',
              style: TextStyle(fontFamily: 'Brand Bold', fontSize: 24.0),
            ),
            Padding(
              padding: EdgeInsets.all(20.0),
              child: Column(
                children: [
                  SizedBox(
                    height: 1.0,
                  ),
                  TextField(
                    controller: emailTextEditingController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      labelText: 'Email',
                      labelStyle: TextStyle(fontSize: 14.0),
                      hintStyle: TextStyle(color: Colors.grey, fontSize: 10.0),
                    ),
                    style: TextStyle(fontSize: 14.0),
                  ),
                  SizedBox(
                    height: 1.0,
                  ),
                  TextField(
                    controller: passwordTextEditingController,
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      labelStyle: TextStyle(fontSize: 14.0),
                      hintStyle: TextStyle(color: Colors.grey, fontSize: 10.0),
                    ),
                    style: TextStyle(fontSize: 14.0),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: StadiumBorder(),
                      primary: Colors.yellow,
                    ),
                    child: Container(
                      height: 50.0,
                      child: Center(
                        child: Text(
                          'Login',
                          style: TextStyle(
                            fontSize: 18.0,
                            fontFamily: 'Brand Bold',
                          ),
                        ),
                      ),
                    ),
                    onPressed: () {
                      if (!emailTextEditingController.text.contains('@')) {
                        displayToastMessage('Invalid Email Address', context);
                      } else if (passwordTextEditingController.text.isEmpty) {
                        displayToastMessage('Please enter password', context);
                      } else {
                        loginAndAuthenticateUser(context);
                      }
                    },
                  ),
                ],
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.pushNamedAndRemoveUntil(
                    context, SignUpScreen.idScreen, (route) => false);
              },
              child: Text(
                'Do not have an account? Register Here',
                style: TextStyle(color: Colors.black),
              ),
            ),
          ],
        ),
      ),
    ));
  }

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  void loginAndAuthenticateUser(BuildContext context) async {
    showDialog(context: context,
    barrierDismissible: false,
    builder: (BuildContext context){
     return ProgressDialog('Authenticating, Please wait');
    }
    
    
    );
    final User? user = (await _firebaseAuth
            .signInWithEmailAndPassword(
                email: emailTextEditingController.text,
                password: passwordTextEditingController.text)
            .catchError((errMsg) {
              Navigator.pop(context);
      displayToastMessage('Error: ' + errMsg, context);
    }))
        .user;
    if (user != null) //user Created
    {
      // save uer info to firebase

      usersRef.child(user.uid).once().then((DataSnapshot snap) {
        if (snap.value != null) {
          Navigator.pushNamedAndRemoveUntil(
              context, MainScreen.idScreen, (route) => false);
          displayToastMessage('You are logged-in', context);
        } else {
           Navigator.pop(context);
          _firebaseAuth.signOut();
          displayToastMessage('No records exists', context);
        }
      });
    } else {
       Navigator.pop(context);
      displayToastMessage('Error ocuured cannot signIn', context);
    }
  }
}
