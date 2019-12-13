import 'package:ConTXT/models/menu.dart';
import 'package:ConTXT/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

class DashboardMain extends StatefulWidget {
  DashboardMain(
      {Key key, this.auth, this.userId, this.userEmail, this.logoutCallback})
      : super(key: key);

  final BaseAuth auth;
  final VoidCallback logoutCallback;
  final String userId;
  final String userEmail;

  @override
  _DashboardMainState createState() => _DashboardMainState();
}

class _DashboardMainState extends State<DashboardMain> {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController _recipientCtrl = TextEditingController();
  TextEditingController _messageCtrl = TextEditingController();
  @override
  Widget build(BuildContext context) {
    String _apiKey = "3c2ccf85";
    String _apiSecret = "FZbHYXBeOiBMUw3x";
    String _recipient = "";
    String _sender = widget.userEmail;
    String _message = "";

    _sendMessage() async {
      // set up POST request arguments
      _recipient = "63" + _recipientCtrl.text;
      _message = _messageCtrl.text;
      String _url =
          "https://rest.nexmo.com/sms/json?api_key=$_apiKey&api_secret=$_apiSecret&to=$_recipient&from=$_sender&text=$_message";

      // var content = json.encode({
      //   "api_key": _apiKey,
      //   "api_secret": _apiSecret,
      //   "to": _recipient,
      //   "from": _sender,
      //   "text": _message
      // });

      var response = await http.post(_url);

      print(response.body);

      if (response.statusCode == 200) {
        setState(() {
          _recipient = "";
          _message = "";
          _recipientCtrl.clear();
          _messageCtrl.clear();
        });
      } else {
        Fluttertoast.showToast(
            msg: "Whoops, an issue has occurred",
            backgroundColor: Colors.red,
            gravity: ToastGravity.BOTTOM,
            fontSize: 12.0,
            textColor: Colors.white,
            timeInSecForIos: 1,
            toastLength: Toast.LENGTH_SHORT);
      }
    }

    return Scaffold(
        key: _scaffoldKey,
        drawer: buildDrawer(widget.auth, widget.userEmail, widget.userId,
            widget.logoutCallback),
        appBar: AppBar(
          title: Text("Dashboard"),
          leading: IconButton(
            icon: Icon(
              Icons.menu,
              color: Colors.white,
            ),
            onPressed: () {
              _scaffoldKey.currentState.openDrawer();
            },
          ),
          backgroundColor: Colors.teal,
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            TextField(
              controller: _recipientCtrl,
              maxLength: 10,
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                prefixText: "+63",
                labelText: "Enter recipient number",
                counterStyle: TextStyle(fontSize: 14.0),
                contentPadding: EdgeInsets.all(10.0),
              ),
              onChanged: (text) {
                setState(() {
                  _recipient = "63" + text;
                  print(_recipient);
                });
              },
            ),
            TextField(
              controller: _messageCtrl,
              keyboardType: TextInputType.text,
              minLines: 1,
              maxLines: 10,
              textInputAction: TextInputAction.newline,
              decoration: InputDecoration(
                  hintText: "Send Text Message",
                  counterStyle: TextStyle(fontSize: 14.0),
                  contentPadding: EdgeInsets.all(10.0),
                  suffixIcon: IconButton(
                    icon: Icon(Icons.send, color: Colors.teal),
                    onPressed: _sendMessage,
                  )),
              onChanged: (text) {
                setState(() {
                  _message = text;
                });
              },
            ),
          ],
        ));
  }
}
