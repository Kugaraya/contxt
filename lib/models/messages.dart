//start dependencies

import 'package:flutter/material.dart';

//end dependencies
class ChatMessage extends StatelessWidget {
  ChatMessage({this.text, this.animationController});
  
  final AnimationController animationController;
  final String text;

  @override
  Widget build(BuildContext context) {
    return SizeTransition(
      sizeFactor: CurvedAnimation(
        parent: animationController, curve: Curves.easeOut),
        axisAlignment: 0.0,
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 10.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Expanded(
                child : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Text(text),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(left: 16.0),
                child: CircleAvatar(child: Image.asset('assets/img/user.jpg', fit: BoxFit.cover)),
              ),
            ],
          ),
        ),
      );
    }
}