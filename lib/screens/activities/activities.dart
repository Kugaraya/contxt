import 'package:contxt/screens/calculator/calculator.dart';
import 'package:contxt/screens/todo/todo.dart';
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
    Map _items = {
      CalculatorScreen() : "Calculator",
      TodoScreen() : "To Do"
    };

    Widget _listCards(Widget _widget, String _title, int _itemNum) {
      return Card(
        child: FlatButton(
        padding: EdgeInsets.symmetric(horizontal: 0),
          child: Container(
            child: Row(
              children: <Widget>[
                SizedBox(
                  child: Center(
                    child: Text(_itemNum.toString() + ".", style: TextStyle(
                      fontSize: 15.0,
                    )),
                  ),
                  height: 55.0,
                  width: 55.0,
                ),
                Expanded(
                  child: Center(
                    child: Text("Title")
                  ),
                ),
                SizedBox(
                  child: Icon(Icons.chevron_right),
                  height: 55.0,
                  width: 55.0
                )
              ],
            ),
          ),
          onPressed: () {},
        ),
      );
    }

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
              _items.forEach((k,v) => {

              }),
            ],
          ),
        ),
      ),
    );
  }
}