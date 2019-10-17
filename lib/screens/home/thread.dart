import 'package:ConTXT/screens/conversation/conversation.dart';
import 'package:ConTXT/screens/home/avatar.dart';
import 'package:ConTXT/screens/home/badge.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sms_maintained/contact.dart';
import 'package:sms_maintained/sms.dart';

class Thread extends StatefulWidget {
  Thread(SmsThread thread, UserProfile userProfile)
      : thread = thread,
        userProfile = userProfile,
        super(key: ObjectKey(thread));

  final SmsThread thread;
  final UserProfile userProfile;

  @override
  _ThreadState createState() => _ThreadState();
}

class _ThreadState extends State<Thread> {
  @override
  Widget build(BuildContext context) {
    Widget _item = Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.black38,
          style: BorderStyle.solid,
          width: 0.5
        ),
      ),
      child: ListTile(
        isThreeLine: true,
        dense: true,
        leading: Avatar(widget.thread.contact.thumbnail, widget.thread.contact.fullName),
        title: Text(widget.thread.contact.fullName ?? widget.thread.contact.address, 
          style: TextStyle(
            fontSize: 14.0,
            fontWeight: FontWeight.w500
          ),
          maxLines: 1,
        ),
        subtitle: Text(
          widget.thread.messages.first.body.trim(),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          softWrap: true,
        ),
        trailing: Badge(widget.thread.messages),
        onTap: () => _showConversation(context),
        onLongPress: () => Fluttertoast.showToast(
          msg: "Long Press success",
          backgroundColor: Colors.black38,
          textColor: Colors.white,
          fontSize: 14.0,
          gravity: ToastGravity.BOTTOM,
          toastLength: Toast.LENGTH_SHORT,
          timeInSecForIos: 1
        ),
      ),
    );

    return _item;
  }

  void _showConversation(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => Conversation(widget.thread, widget.userProfile)));
  }
}
