//start dependencies

import 'package:ConTXT/screens/loading/loading.dart';
import 'package:ConTXT/screens/login/login.dart';
import 'package:flutter/material.dart';

//end dependencies
//start pages

import 'package:ConTXT/models/navigator.dart';
import 'package:ConTXT/screens/home/home.dart';
import 'package:ConTXT/screens/contacts/contacts.dart';
import 'package:ConTXT/screens/messaging/messaging.dart';
import 'package:ConTXT/screens/calculator/calculator.dart';

//end pages

void main() => runApp(ConTXT()); 

class ConTXT extends StatefulWidget {
  @override
  _ConTXTState createState() => _ConTXTState();
}

class _ConTXTState extends State<ConTXT> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ConTXT',
      theme: ThemeData(
        primaryColor: Colors.blue,
        accentColor: Colors.blue[300]
      ),
      initialRoute: '/',
      routes: {
        '/' : (context) => LoadingScreen(),
        '/login' : (context) => LoginScreen(),
        '/messages' : (context) => HomeScreen(),
        '/navigator' : (context) => NavigatorModel(),
        '/people' : (context) => ContactScreen(),
        '/calculator' : (context) => CalculatorScreen(),
        '/messages/compose' : (context) => MessageScreen(),
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
