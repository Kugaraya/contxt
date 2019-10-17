import 'package:flutter/material.dart';
import 'package:sms_maintained/contact.dart';

class ContactScreen extends StatefulWidget {
  ContactScreen({Key key}) : super(key: key);
  final String title = "Contacts";
  @override
  State createState() => ContactScreenState();
}

class ContactScreenState extends State<ContactScreen> with AutomaticKeepAliveClientMixin<ContactScreen> {
  ContactQuery query;
  List<Contact> contacts;

  void contactQuery() async {
    query = ContactQuery();
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Container(
      child: Column(
        children: <Widget>[
          RaisedButton(
            onPressed: () => print(query.toString() + " : " + contacts.toString()),
            child: Text("Test Contact Instances"),
          )
        ],
      )
    );
  }
}