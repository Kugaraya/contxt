//start dependencies

import 'package:ConTXT/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

//end dependencies
//start pages

import 'package:ConTXT/screens/home/home.dart';
import 'package:ConTXT/screens/contacts/contacts.dart';
import 'package:ConTXT/screens/dashboard/dashboard.dart';
import 'package:ConTXT/screens/activities/activities.dart';

//end pages

class NavigatorModel extends StatefulWidget {
  final Map<String, Widget> screens = {
    HomeScreen().title: HomeScreen(),
    ContactScreen().title: ContactScreen(),
    DashboardScreen().title: DashboardScreen(
      auth: Auth(),
    ),
    ActivitiesScreen().title: ActivitiesScreen(),
  };
  final Map<Color, Color> navColors = {
    Colors.blue[300]: Colors.blue,
    Colors.lightGreen[300]: Colors.lightGreen,
    Colors.teal[300]: Colors.teal,
    Colors.indigo[300]: Colors.indigo
  };

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  State createState() => NavigatorModelState();
}

class NavigatorModelState extends State<NavigatorModel> {
  int _currentIndex = 0;
  PageController _pageController = PageController(
    keepPage: true,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _currentIndex != 0 && _currentIndex != 2
          ? AppBar(
              leading: _currentIndex == 2
                  ? IconButton(
                      icon: Icon(Icons.menu),
                      onPressed: () {
                        widget.scaffoldKey.currentState.openDrawer();
                      },
                    )
                  : null,
              title: Text(widget.screens.keys.elementAt(_currentIndex)),
              backgroundColor: widget.navColors.keys.elementAt(_currentIndex),
              actions: _currentIndex < 2
                  ? <Widget>[
                      IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.search),
                        tooltip: "Search",
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.settings),
                        tooltip: "Settings",
                      ),
                    ]
                  : null,
            )
          : null,
      body: PageView(
        physics: ClampingScrollPhysics(),
        controller: _pageController,
        children: widget.screens.values.toList(),
        onPageChanged: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
      key: widget.scaffoldKey,
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.chat),
            backgroundColor: widget.navColors.values.elementAt(_currentIndex),
            title: Text(
              " ",
              style: TextStyle(fontSize: 1.0),
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people),
            backgroundColor: widget.navColors.values.elementAt(_currentIndex),
            title: Text(
              " ",
              style: TextStyle(fontSize: 1.0),
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.phone_android),
            backgroundColor: widget.navColors.values.elementAt(_currentIndex),
            title: Text(
              " ",
              style: TextStyle(fontSize: 1.0),
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.view_list),
            backgroundColor: widget.navColors.values.elementAt(_currentIndex),
            title: Text(
              " ",
              style: TextStyle(fontSize: 1.0),
            ),
          )
        ],
        onTap: (int index) {
          setState(() {
            _pageController.jumpToPage(index);
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
