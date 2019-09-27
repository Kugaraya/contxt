import 'package:flutter/material.dart';

class ContactScreen extends StatefulWidget {
  @override
  State createState() => ContactScreenState();
}

class ContactScreenState extends State<ContactScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Contacts"),
        backgroundColor: Colors.lightGreen[300],
        actions: <Widget>[
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
        ],
      ),
    );
  }
}