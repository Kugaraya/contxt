import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:ConTXT/models/data.dart';
import 'package:ConTXT/utils/httpAPI.dart';

class HTTPScreen extends StatefulWidget {
  final String title = "HTTP Test";
  @override
  _HTTPScreenState createState() => _HTTPScreenState();
}

class _HTTPScreenState extends State<HTTPScreen> {
  var _isLoading = true;
  var users = List<User>();

  @override
  void initState() { 
    super.initState();
    _getUsers();  
  }

  @override
  void dispose() {
    super.dispose();
  }

  _getUsers() {
    API.getUsers().then((response) {
      setState(() {
        Iterable list = json.decode(response.body);
        users = list.map((model) => User.fromJson(model)).toList();
        Future.delayed(Duration(seconds: 2));
        _isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: _isLoading ? Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Center(
            child: CircularProgressIndicator(),
          )
        ]
      ) : ListView.builder(
        itemCount: users.length,
        itemBuilder: (context, index) {
          return Container(
            decoration: BoxDecoration(
              border: Border.all(width: 0.3, color: Colors.grey[400]),
            ),
            child: InkWell(
              onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => ItemContent(users[index]))),
              child: ListTile(
                leading: Text(users[index].id.toString() + "."),
                title: Text(users[index].name),
                subtitle: Text(users[index].email),
                trailing: Icon(Icons.chevron_right),
              ),
            ),
          );
        },
      )
    );
  }
}

class ItemContent extends StatelessWidget {
  ItemContent(this.userData);
  final User userData;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(userData.id.toString() + ". " + userData.name)
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              ListTile(
                leading: Icon(Icons.person),
                title: Text(userData.username),
              ),
              ListTile(
                leading: Icon(Icons.email),
                title: Text(userData.email),
              ),
              ListTile(
                leading: Icon(Icons.phone),
                title: Text(userData.phone),
              ),
              ListTile(
                leading: Icon(Icons.web),
                title: Text(userData.website),
              ),
            ],
          ),
        )
      )
    );
  }
}
