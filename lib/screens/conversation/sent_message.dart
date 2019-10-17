import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:sms_maintained/contact.dart';
import 'package:sms_maintained/sms.dart';
import 'arrow_painter.dart';
import 'message.dart';

class SentMessage extends Message {
  SentMessage(SmsMessage message, bool compactMode, this.userProfile)
      : super(message,
            compactMode: compactMode,
            backgroundColor: Colors.lightBlue[100],
            arrowDirection: ArrowDirection.Right);

  final UserProfile userProfile;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                child: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Text(message.body.trim()),
                      Align(
                        child: Padding(
                          padding: EdgeInsets.only(top: 5.0),
                          child: Text(
                            time.format(context),
                            style: TextStyle(color: Colors.grey[500]),
                          ),
                        ),
                        alignment: Alignment.centerRight,
                      ),
                    ],
                  ),
                  margin: EdgeInsets.only(left: 48.0),
                  padding: EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: this.backgroundColor
                  ),
                ),
              ),
              Container(
                child:
                    createAvatar(userProfile.thumbnail, userProfile.fullName),
                margin: EdgeInsets.only(left: 8.0, top: 8.0),
              ),
            ],
          ),
          Container(
            width: double.infinity,
            child: createArrow(),
          ),
        ],
      ),
      margin: EdgeInsets.only(
          top: compactMode ? 2.0 : 10.0, bottom: 0.0, left: 15.0, right: 15.0),
    );
  }
}
