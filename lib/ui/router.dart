import 'package:ConTXT/models/navigator.dart';
import 'package:ConTXT/screens/activities/calculator.dart';
import 'package:ConTXT/screens/activities/firetest.dart';
import 'package:ConTXT/screens/activities/http.dart';
import 'package:ConTXT/screens/activities/todo.dart';
import 'package:ConTXT/screens/contacts/contacts.dart';
import 'package:ConTXT/screens/home/home.dart';
import 'package:ConTXT/screens/loading/loading.dart';
import 'package:flutter/material.dart';

class Router {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/' :
        return  MaterialPageRoute(
          builder: (_)=> LoadingScreen()
        );
      case '/messages' :
        return  MaterialPageRoute(
          builder: (_)=> HomeScreen()
        );
      case '/navigator' :
        return  MaterialPageRoute(
          builder: (_)=> NavigatorModel()
        );
      case '/people' :
        return  MaterialPageRoute(
          builder: (_)=> ContactScreen()
        );
      case '/calculator' :
        return  MaterialPageRoute(
          builder: (_)=> CalculatorScreen()
        );
      case '/todo' :
        return  MaterialPageRoute(
          builder: (_)=> TodoScreen()
        );
      case '/http' :
        return  MaterialPageRoute(
          builder: (_)=> HTTPScreen()
        );
      case '/firetest' :
        return MaterialPageRoute(
          builder: (_)=> FireTest()
        );
      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
              body: Center(
                child: Text('No route defined for ${settings.name}'),
              ),
            ));
    }
  }
}
