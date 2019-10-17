import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:sms_maintained/sms.dart';

class Badge extends StatelessWidget {
  Badge(this.messages) : super();

  final List<SmsMessage> messages;

  @override
  Widget build(BuildContext context) {
    if (_countUnreadMessages() == 0) {
      return null;
    }

    return CircleAvatar(
      radius: 10.0,
      backgroundColor: Colors.red,
      foregroundColor: Colors.white,
      child: Center(child: Text(_countUnreadMessages().toString(), style: TextStyle(fontSize: 10.0))),
    );
  }

  int _countUnreadMessages() {
    return messages
      .where((msg) => msg.kind == SmsMessageKind.Received && !msg.isRead)
      .length;
  }
}
