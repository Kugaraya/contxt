import 'package:flutter/material.dart';

class InboxModel extends StatelessWidget {
  InboxModel({this.title, this.subtitle, this.time, this.unread, this.animationController, this.slideOffset});
  
  final String title, subtitle, time, unread;
  final AnimationController animationController;
  final Animation<Offset> slideOffset;

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: slideOffset,
      child: ListTile(
        dense: true,
        isThreeLine: true,
        leading: CircleAvatar(
          child: Icon(Icons.person),
        ),
        title: Text("Contact Name",
          style: TextStyle(
            fontSize: 14.0,
            fontWeight: FontWeight.w500
          ),
        ),
        subtitle: Text("This is a very very long message for the sake of testing how many characters does a single ListTile support in this set dimension",
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          softWrap: true,
        ),
        trailing: Column(
          children: <Widget>[
            Text("12:01"),
            SizedBox(height: 10.0),
            CircleAvatar(
              backgroundColor: Colors.blue,
              foregroundColor: Colors.white,
              radius: 8.0,
              child: Center(
                child: Text("1",
                  style: TextStyle(
                    fontSize: 10.0
                  )
                ),
              )
            )
          ],
        ),
      ),
    );
  }
}