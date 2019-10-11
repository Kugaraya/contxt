//start dependencies

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ConTXT/models/messages.dart';

//end dependencies

class MessageScreen extends StatefulWidget {
  @override
  State createState() => MessageScreenState();
}

class MessageScreenState extends State<MessageScreen> with TickerProviderStateMixin {
  final List<ChatMessage> _messages = <ChatMessage>[];
  final TextEditingController _textController = TextEditingController();
  bool _isComposing = false;

  @override
  void dispose() {
    for (ChatMessage message in _messages)
      message.animationController.dispose();
    super.dispose();
  }  

  Widget _buildTextComposer() {
    return IconTheme(
      data: IconThemeData(color: Theme.of(context).accentColor),
      child: Container(                                     
        margin: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Row(
          children: <Widget>[
            Flexible(
              child: TextField(
                controller: _textController,
                onChanged: (String text) {
                  setState(() {
                    _isComposing = text.length > 0;
                  });
                },                                  
                onSubmitted: _handleSubmitted,
                decoration: InputDecoration.collapsed(
                  hintText: "Send a message"),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 4.0),
              child: IconButton(
                icon: Icon(Icons.send),
                onPressed: _isComposing ?
                () => _handleSubmitted(_textController.text) : null,
              ),
            ),
          ],
        ),
      ),
    );  
  }

  void _handleSubmitted(String text) {
    _textController.clear();
    setState(() {
      _isComposing = false;
    });

    ChatMessage message = ChatMessage(
      text: text,
      animationController: AnimationController(
        duration: Duration(milliseconds: 700),
        vsync: this,
      )
    );
    setState(() {
      _messages.insert(0, message);
    });
    message.animationController.forward();
  }

  @override                                      
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Contact Name"),
        leading: Icon(Icons.menu),
        elevation: Theme.of(context).platform == TargetPlatform.iOS ? 0.0 : 4.0,
        backgroundColor: Colors.teal[300]
      ),
      body: Container(
        decoration: Theme.of(context).platform == TargetPlatform.iOS
        ? BoxDecoration(
          border: Border(
            top: BorderSide(color: Colors.grey[200]),
          ),
        ) : null,
        child: Column(
          children: <Widget>[
            Flexible(
              child: ListView.builder( 
                padding: EdgeInsets.all(8.0),
                reverse: true,
                itemBuilder: (_, int index) => _messages[index],
                itemCount: _messages.length,
              ),
            ),
            Divider(height: 1.0),
            Container(
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor),
              child: _buildTextComposer(),                       //modified
            ),
          ],
        ),
      ),
    );
  }
}