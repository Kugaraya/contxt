import 'package:flutter/material.dart';

class ActivitiesScreen extends StatefulWidget {
  @override
 State createState() => _ActivitiesScreenState();
}

class _ActivitiesScreenState extends State<ActivitiesScreen>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("List of Activities"),
        centerTitle: true,
        backgroundColor: Colors.indigo[300],
      ),
      body: Container(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          physics: ScrollPhysics(parent: BouncingScrollPhysics()),
          child: Column(
            children: <Widget>[
              FlatButton(
                child: Card(
                  child: Container(
                    child: Row(
                      children: <Widget>[
                        SizedBox(
                          child: Icon(Icons.arrow_right),
                          height: 55.0,
                          width: 55.0,
                        )
                      ],
                    ),
                  ),
                ),
                onPressed: () {},
              )
            ],
          ),
        ),
      ),
    );
  }
}