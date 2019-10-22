import 'package:flutter/material.dart';

class ActivitiesScreen extends StatefulWidget {
  ActivitiesScreen({Key key}) : super(key: key);
  final String title = "Activities";
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
    List<List> _items = [
      ["/calculator", "Calculator"],
      ["/todo", "To Do"],
      ["/http", "HTTP Requests"]
    ];

    Widget _listCards(String _route, String _title, int _itemNum) {
      return Card(
        elevation: 3.0,
        child: FlatButton(
          padding: EdgeInsets.symmetric(horizontal: 0),
          child: Hero(
            tag: _title,
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
                      child: Text(_title)
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
          ),
          onPressed: () {
            Navigator.of(context).pushNamed(_route);
          },
        ),
      );
    }

    return Container(
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        physics: ScrollPhysics(parent: BouncingScrollPhysics()),
        child: Column(
          children: <Widget>[
            for(int i=0; i<_items.length; i++)
              _listCards(_items[i][0], _items[i][1], i+1)
          ],
        ),
      ),
    );
  }
}