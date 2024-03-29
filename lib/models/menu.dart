import 'package:ConTXT/models/menuclipper.dart';
import 'package:ConTXT/services/auth.dart';
import 'package:flutter/material.dart';

buildDrawer(
    Auth auth, String userEmail, String userID, VoidCallback logoutCallback) {
  return ClipPath(
    clipper: MenuClipper(),
    child: Container(
      padding: EdgeInsets.only(left: 16.0, right: 40),
      decoration: BoxDecoration(
          color: Colors.blue[900],
          boxShadow: [BoxShadow(color: Colors.black45)]),
      width: 300.0,
      height: double.maxFinite,
      child: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                alignment: Alignment.centerRight,
                child: IconButton(
                  icon: Icon(
                    Icons.power_settings_new,
                    color: Colors.blue[200],
                  ),
                  onPressed: () {
                    auth.signOut();
                    logoutCallback();
                  },
                ),
              ),
              Container(
                height: 90,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                        colors: [Colors.lightBlue[200], Colors.blue[700]])),
                child: CircleAvatar(
                    radius: 40,
                    child: Icon(Icons.person_pin,
                        color: Colors.white, size: 40.0)),
              ),
              SizedBox(height: 5.0),
              Text(
                userEmail,
                style: TextStyle(color: Colors.white, fontSize: 18.0),
              ),
              Text(
                userID,
                style: TextStyle(color: Colors.blue[200], fontSize: 14.0),
              ),
              SizedBox(height: 30.0),
              _buildRow(Icons.home, "Home"),
              _buildDivider(),
              _buildRow(Icons.person_pin, "Your profile"),
              _buildDivider(),
              _buildRow(Icons.settings, "Settings"),
              _buildDivider(),
              _buildRow(Icons.email, "Contact us"),
              _buildDivider(),
              _buildRow(Icons.help, "Help"),
              _buildDivider(),
            ],
          ),
        ),
      ),
    ),
  );
}

Divider _buildDivider() {
  return Divider(
    color: Colors.blue[200],
  );
}

Widget _buildRow(IconData icon, String title) {
  final TextStyle tStyle = TextStyle(color: Colors.blue[200], fontSize: 16.0);

  return FlatButton(
    onPressed: () {},
    padding: EdgeInsets.symmetric(vertical: 8.0),
    child: Row(children: [
      Icon(icon, color: Colors.blue[200]),
      SizedBox(width: 10.0),
      Text(
        title,
        style: tStyle,
      ),
    ]),
  );
}
