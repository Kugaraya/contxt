import 'package:ConTXT/utils/group.dart';
import 'package:flutter/material.dart';
import 'package:sms_maintained/sms.dart';

import 'messageGroup.dart';

class Messages extends StatelessWidget {
  final List<SmsMessage> messages;

  Messages(this.messages);

  @override
  Widget build(BuildContext context) {
    final groups = MessageGroupService.of(context).groupByDate(messages);
    return ListView.builder(
        reverse: true,
        itemCount: groups.length,
        itemBuilder: (context, index) {
          return MessageGroup(groups[index]);
        });
  }
}
