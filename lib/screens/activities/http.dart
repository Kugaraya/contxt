import 'package:flutter/material.dart';

class HTTPScreen extends StatefulWidget {
  @override
  _HTTPScreenState createState() => _HTTPScreenState();
}

class _HTTPScreenState extends State<HTTPScreen> {
  // final String url = "" //JSON Placeholder thingy
  Future<dynamic> getData() async {
    // final response = await http.get(url);
    // print(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("HTTP Requests"),
      ),
      body: Container(
        child: Center(child: Text("HTTP Yeet"),)
      ),
    );
  }
}