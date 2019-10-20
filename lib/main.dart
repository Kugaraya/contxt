//start dependencies

import 'package:ConTXT/screens/loading/loading.dart';
import 'package:ConTXT/screens/todo/todo.dart';
import 'package:ConTXT/sim/sim_bloc_provider.dart';
import 'package:ConTXT/sim/sim_bloc.dart';
import 'package:flutter/material.dart';

//end dependencies
//start pages

import 'package:ConTXT/models/navigator.dart';
import 'package:ConTXT/screens/home/home.dart';
import 'package:ConTXT/screens/contacts/contacts.dart';
import 'package:ConTXT/screens/calculator/calculator.dart';

//end pages

Future<void> main() async {
  runApp(ConTXT());
}

class ConTXT extends StatefulWidget {
  @override
  _ConTXTState createState() => _ConTXTState();
}

class _ConTXTState extends State<ConTXT> {
  final bloc = SimCardsBloc();

  @override
  Widget build(BuildContext context) {
    bloc.loadSimCards();

    return SimCardsBlocProvider(
      simCardBloc: bloc,
      child: MaterialApp(
        title: 'ConTXT',
        theme: ThemeData(
          primaryColor: Colors.blue,
          accentColor: Colors.blue[300]
        ),
        initialRoute: '/',
        routes: {
          '/' : (context) => LoadingScreen(),
          '/messages' : (context) => HomeScreen(),
          '/navigator' : (context) => NavigatorModel(),
          '/people' : (context) => ContactScreen(),
          '/calculator' : (context) => CalculatorScreen(),
          '/todo' : (context) => TodoScreen(),
        },
      ),
    );
  }
}
