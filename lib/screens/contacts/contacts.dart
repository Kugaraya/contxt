import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:contacts_service/contacts_service.dart';

class ContactScreen extends StatefulWidget {
  ContactScreen({Key key}) : super(key: key);
  final String title = "Contacts";
  @override
  State createState() => ContactScreenState();
}

class ContactScreenState extends State<ContactScreen> with AutomaticKeepAliveClientMixin<ContactScreen> {
  Iterable<Contact> _contacts;

  @override
  void initState() {
    super.initState();
    refreshContacts();
  }

  @override
  bool get wantKeepAlive => true;

  refreshContacts() async {
    var contacts = await ContactsService.getContacts();
    setState(() {
      _contacts = contacts;
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: SafeArea(
        child: _contacts != null ?
          ListView.builder(
            itemCount: _contacts?.length ?? 0,
            itemBuilder: (context, index) {
              Contact c = _contacts?.elementAt(index);
              return ListTile(
                onTap: () {},
                leading: (c.avatar != null && c.avatar.length > 0) ?
                  CircleAvatar(backgroundImage: MemoryImage(c.avatar)) :
                  CircleAvatar(child: Text(c.initials())),
                title: Text(c.displayName ?? ""),
              );
            },
          ) : Center(child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}