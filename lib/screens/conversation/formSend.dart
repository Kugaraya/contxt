import 'package:ConTXT/sim/sim_bloc_provider.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:sms_maintained/contact.dart';
import 'package:sms_maintained/sms.dart';

typedef void MessageSentCallback(SmsMessage message);

class FormSend extends StatelessWidget {
  FormSend(this.thread, {this.onMessageSent});

  final SmsThread thread;
  final MessageSentCallback onMessageSent;
  final TextEditingController _textField = TextEditingController();
  final SmsSender _sender = SmsSender();

  @override
  Widget build(BuildContext context) {
    final simCards = SimCardsBlocProvider.of(context);
    return Material(
      elevation: 4.0,
      child: Row(
        children: [
          Expanded(
            child: Container(
              child: TextField(
                controller: _textField,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  labelStyle: TextStyle(fontSize: 16.0),
                  hintText: "Send message:",
                ),
              ),
              padding: EdgeInsets.only(left: 20.0, top: 8.0, bottom: 8.0),
            ),
          ),
          IconButton(
              icon: StreamBuilder<SimCard>(
                  stream: simCards.onSimCardChanged,
                  initialData: simCards.selectedSimCard,
                  builder: (context, snapshot) {
                    return Row(
                      children: [
                        Icon(
                          Icons.sim_card,
                          color: snapshot.data.state == SimCardState.Ready
                              ? Colors.blue
                              : Colors.grey
                        ),
                        Text(snapshot.data.slot.toString(),
                          style: TextStyle(color: snapshot.data.state == SimCardState.Ready
                              ? Colors.black
                              : Colors.grey
                          ),
                        ),
                      ],
                    );
                  }),
              onPressed: () {
                SimCardsBlocProvider.of(context).toggleSelectedSim();
              }),
          IconButton(
            icon: Icon(Icons.send),
            onPressed: () {
              _sendMessage(context);
            },
            color: Colors.blue,
          ),
        ],
      ),
    );
  }

  void _sendMessage(BuildContext context) async {
    SmsMessage message =
        SmsMessage(thread.address, _textField.text, threadId: thread.id);
    message.onStateChanged.listen((SmsMessageState state) {
      if (state == SmsMessageState.Delivered) {
        print('Message delivered to ${message.address}');
        _notifyDelivery(message, context);
      }
      if (state == SmsMessageState.Sent) {
        print('Message sent to ${message.address}');
      }
    });

    final simCard = SimCardsBlocProvider.of(context).selectedSimCard;
    await _sender.sendSms(message, simCard: simCard);
    _textField.clear();
    onMessageSent(message);
  }

  void _notifyDelivery(SmsMessage message, BuildContext context) async {
    final contacts = ContactQuery();
    Contact contact = await contacts.queryContact(message.address);
    final snackBar = SnackBar(
        content: Text('Message to ${contact.fullName} delivered'));
    Scaffold.of(context).showSnackBar(snackBar);
  }
}
