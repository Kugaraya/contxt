//start dependencies

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

//end dependencies
//start pages

import 'package:ConTXT/models/navigator.dart';
import 'package:ConTXT/screens/home/home.dart';
import 'package:ConTXT/screens/contacts/contacts.dart';
import 'package:ConTXT/screens/messaging/messaging.dart';
import 'package:ConTXT/screens/calculator/calculator.dart';

//end pages

void main(){
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
    .then((_) => runApp(ConTXT()));
} 

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
        primaryColor: Colors.blue
      ),
      initialRoute: '/',
      routes: {
        '/' : (context) => NavigatorModel(),
        '/messages' : (context) => HomeScreen(),
        '/messages/compose' : (context) => MessageScreen(),
        '/people' : (context) => ContactScreen(),
        '/calculator' : (context) => CalculatorScreen(),
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
