import 'package:ConTXT/screens/conversation/conversationStore.dart';
import 'package:ConTXT/screens/conversation/formSend.dart';
import 'package:ConTXT/screens/conversation/messages.dart';
import 'package:ConTXT/utils/colors.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:sms_maintained/contact.dart';
import 'package:sms_maintained/sms.dart';

class Conversation extends StatefulWidget {
  Conversation(this.thread, this.userProfile) : super();

  final SmsThread thread;
  final UserProfile userProfile;

  @override
  State<Conversation> createState() => _ConversationState();
}

class _ConversationState extends State<Conversation> {
  final SmsReceiver _receiver = SmsReceiver();

  @override
  void initState() {
    _receiver.onSmsReceived.listen((sms) {
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.thread.contact.fullName ?? widget.thread.contact.address),
          backgroundColor: ContactColor.getColor(widget.thread.contact.fullName),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: ConversationStore(
              widget.userProfile,
              widget.thread,
              child: Messages(widget.thread.messages),
            ),
          ),
          FormSend(
            widget.thread,
            onMessageSent: _onMessageSent,
          ),
        ],
      ),
    );
  }

  void _onMessageSent(SmsMessage message) {
    setState(() {
      widget.thread.addNewMessage(message);
    });
  }
}
