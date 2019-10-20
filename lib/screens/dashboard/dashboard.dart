import 'package:flutter/material.dart';

class DashboardScreen extends StatefulWidget {
  final String title = "Dashboard";
  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> with AutomaticKeepAliveClientMixin<DashboardScreen> {
  @override
  bool get wantKeepAlive => true;
  
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          child: Column(
            children: <Widget>[
              RaisedButton(
                elevation: 3.0,
                onPressed: () {},
                color: Colors.grey[700],
                textColor: Colors.white70,
              )
            ],
          ),
        ),
      ),
    );
  }
}