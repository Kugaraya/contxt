import 'package:flutter/material.dart';

class DashboardScreen extends StatefulWidget {
  final String title = "Dashboard";
  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("You haven't logged in yet")
      ),
    );
  }
}