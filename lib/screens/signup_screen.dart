import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';
import 'package:rider_app/main.dart';
import 'package:rider_app/screens/login_screen.dart';
import 'package:rider_app/screens/main_screen.dart';
import 'package:rider_app/widgets/progress_indicator.dart';

class SignUpScreen extends StatelessWidget {
  static const String idScreen = 'register';
  TextEditingController nameTextEditingController = TextEditingController();
  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController phoneTextEditingController = TextEditingController();
  TextEditingController passwordTextEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(
          children: [
            SizedBox(height: 20.0),
            Image(
              image: AssetImage('assets/images/logo.png'),
              width: 390.0,
              height: 250.0,
              alignment: Alignment.center,
            ),
            SizedBox(height: 1.0),
            Text(
              'Sign Up as a Rider',
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
                    controller: nameTextEditingController,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      labelText: 'Name',
                      labelStyle: TextStyle(fontSize: 14.0),
                      hintStyle: TextStyle(color: Colors.grey, fontSize: 10.0),
                    ),
                    style: TextStyle(fontSize: 14.0),
                  ),
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
                    controller: phoneTextEditingController,
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                      labelText: 'Phone Number',
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
                          'Create an Account',
                          style: TextStyle(
                            fontSize: 18.0,
                            fontFamily: 'Brand Bold',
                          ),
                        ),
                      ),
                    ),
                    onPressed: () {
                      if (nameTextEditingController.text.length < 4) {
                        displayToastMessage(
                            'Name must be atleast 4 charcters', context);
                      } else if (!emailTextEditingController.text
                          .contains('@')) {
                        displayToastMessage('Invalid Email Address', context);
                      } else if (phoneTextEditingController.text.isEmpty) {
                        displayToastMessage('Phone number Required', context);
                      } else if (passwordTextEditingController.text.length <
                          6) {
                        displayToastMessage(
                            'Password must be atleast 6 characters', context);
                      } else {
                        registerNewUser(context);
                      }
                    },
                  ),
                ],
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.pushNamedAndRemoveUntil(
                    context, LogInScreen.idScreen, (route) => false);
              },
              child: Text(
                'Already have an account? Login Here',
                style: TextStyle(color: Colors.black),
              ),
            ),
          ],
        ),
      ),
    ));
  }

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  void registerNewUser(BuildContext context) async {
      showDialog(context: context,
    barrierDismissible: false,
    builder: (BuildContext context){
     return ProgressDialog('Authenticating, Please wait');
    }
    
    
    );
    final User? user = (await _firebaseAuth
            .createUserWithEmailAndPassword(
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
      
      Map userDataMap = {
        'name': nameTextEditingController.text.trim(),
        'email': emailTextEditingController.text.trim(),
        'phone': phoneTextEditingController.text.trim(),
        
      };
      usersRef.child(user.uid).set(userDataMap);
      displayToastMessage('Your account has been Created Successfully', context);
      Navigator.pushNamedAndRemoveUntil(context, MainScreen.idScreen, (route) => false);
    } else {
      //error occured
      Navigator.pop(context);
      displayToastMessage('User has not been Created', context);
    }
  }
}

displayToastMessage(String message, BuildContext context) {
  Fluttertoast.showToast(msg: message);
}
