//start dependencies

import 'package:flutter/material.dart';
import 'package:contxt/models/navigator.dart';

//end dependencies
//start pages

import 'package:contxt/screens/home/home.dart';
import 'package:contxt/screens/contacts/contacts.dart';
import 'package:contxt/screens/messaging/messaging.dart';
import 'package:contxt/screens/calculator/calculator.dart';

//end pages

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
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
}
