import 'package:flutter/material.dart';

class ContactScreen extends StatefulWidget {
  ContactScreen({Key key}) : super(key: key);
  final String title = "Contacts";
  @override
  State createState() => ContactScreenState();
}

class ContactScreenState extends State<ContactScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[

        ],
      )
    );
  }
}