import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:sms_maintained/contact.dart';
import 'package:sms_maintained/sms.dart';

import 'arrow_painter.dart';
import 'message.dart';

class ReceivedMessage extends Message {
  ReceivedMessage(SmsMessage message, bool compactMode, this.contact)
      : super(message,
            compactMode: compactMode,
            backgroundColor: Colors.grey[300],
            arrowDirection: ArrowDirection.Left);

  final Contact contact;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                child: createAvatar(contact.thumbnail, contact.fullName),
                margin: EdgeInsets.only(right: 8.0, top: 8.0),
              ),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: this.backgroundColor
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(message.body.trim()),
                      Align(
                        child: Padding(
                          padding: EdgeInsets.only(top: 5.0),
                          child: Text(
                            time.format(context),
                            style: TextStyle(color: Colors.grey),
                          ),
                        ),
                        alignment: Alignment.centerLeft,
                      ),
                    ],
                  ),
                  margin: EdgeInsets.only(right: 48.0),
                  padding: EdgeInsets.all(10.0),
                ),
              ),
            ],
          ),
          this.createArrow()
        ],
      ),
      margin: EdgeInsets.only(
          top: compactMode ? 2.0 : 10.0, bottom: 0.0, left: 15.0, right: 15.0),
    );
  }
}
