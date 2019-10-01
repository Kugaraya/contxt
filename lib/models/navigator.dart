//start dependencies

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

//end dependencies
//start pages

import 'package:contxt/screens/home/home.dart';
import 'package:contxt/screens/messaging/messaging.dart';
import 'package:contxt/screens/contacts/contacts.dart';
import 'package:contxt/screens/activities/activities.dart';

//end pages

class NavigatorModel extends StatefulWidget {
  @override
  State createState() => NavigatorModelState(); 
} 

class NavigatorModelState extends State<NavigatorModel> with TickerProviderStateMixin {
  int _currentIndex = 0;
  List<Widget> _content = [
    HomeScreen(),
    ContactScreen(),
    MessageScreen(),
    ActivitiesScreen()
  ];
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _content[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.chat),
            backgroundColor: Colors.blue[900],
            title: Text(" ",style: TextStyle(fontSize: 2.0),),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people),
            backgroundColor: Colors.lightGreen,
            title: Text(" ",style: TextStyle(fontSize: 2.0),),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.phone_android),
            backgroundColor: Colors.teal,
            title: Text(" ",style: TextStyle(fontSize: 2.0),),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.view_list),
            backgroundColor: Colors.indigo,
            title: Text(" ",style: TextStyle(fontSize: 2.0),),
          )
        ],
        onTap: (int index) {
          setState(() {
            _currentIndex = index;
          });
        },
        currentIndex: _currentIndex,
        iconSize: 20.0,
        type: BottomNavigationBarType.shifting,
        unselectedIconTheme: IconThemeData(color: Colors.white),
        selectedIconTheme: IconThemeData(color: Colors.white, size: 35.0),
      ),
    );
  }
}