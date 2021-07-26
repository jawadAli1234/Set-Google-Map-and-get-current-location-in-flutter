import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:rider_app/screens/login_screen.dart';
import 'package:rider_app/screens/main_screen.dart';
import 'package:rider_app/screens/signup_screen.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}
DatabaseReference usersRef = FirebaseDatabase.instance.reference().child('users');

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Taxi Rider App',
      theme: ThemeData(
        fontFamily: 'Brand Bold',
      
        primarySwatch: Colors.blue,
      ),
      initialRoute: MainScreen.idScreen,
      routes: {
        SignUpScreen.idScreen: (context) => SignUpScreen(),
        LogInScreen.idScreen: (context) => LogInScreen(),
        MainScreen.idScreen: (context) => MainScreen(),

      },
    );
  }
}



