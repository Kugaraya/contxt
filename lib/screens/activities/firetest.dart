import "package:cloud_firestore/cloud_firestore.dart";
import 'package:timeago/timeago.dart' as timeago;
import "package:flutter/material.dart";

class FireTest extends StatefulWidget {
  final String title = "Firebase Test";
  @override
  _FireTestState createState() => _FireTestState();
}

class _FireTestState extends State<FireTest> {
  final db = Firestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          String _textValue = '';
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) => SimpleDialog(
              title: Text("Add an item"),
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Row(
                    children: <Widget>[
                      Flexible(
                        child: TextField(
                          onChanged: (text) => _textValue = text,
                          autofocus: true
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 4.0),
                        child: IconButton(
                          icon: Icon(Icons.send),
                          onPressed: () =>_handleSubmitted(_textValue),
                        ),
                      ),
                    ],
                  )
                )
              ]
            )
          );
        },
        child: Icon(Icons.add_comment),
        foregroundColor: Colors.white,
        backgroundColor: Theme.of(context).primaryColor,
        elevation: 3.0,
      ),
      body: StreamBuilder(
        stream: db.collection("todo").snapshots(),
        builder: (context, snapshot) {
          if(!snapshot.hasData || snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return ListView.builder(
            itemCount: snapshot.data.documents.length,
            itemBuilder: (context, index){
              return _itemTiles(snapshot.data.documents[index]);
            },
          );
        },
      ),
    );
  }

  void _handleSubmitted(String text) async {
    Navigator.pop(context);
    await db.collection("todo").add({
      "entry" : text,
      "isDone" : false,
      "isStar" : false,
      "timestamp" : Timestamp.now()
    });
  }

  Widget _itemTiles(DocumentSnapshot document) {
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey[400], style: BorderStyle.solid, width: 0.33)
      ),
      child: ListTile(
        isThreeLine: true,
        leading: IconButton(
          color: document["isDone"] ? Colors.green : Colors.black,
          icon: Icon(document["isDone"] ? Icons.check_box : Icons.check_box_outline_blank),
          onPressed: () async {
            await db.collection("todo")
              .document(document.documentID)
              .updateData({"isDone" : document["isDone"] ? false : true, "timestamp" : Timestamp.now()});
            setState((){});
          },
        ),
        title: Text("Last updated: " + timeago.format(document["timestamp"].toDate())),
        subtitle: Text(document["entry"],
          style: TextStyle(
            color: Colors.black26
          ),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          softWrap: true
        ),
        trailing: IconButton(
          color: document["isStar"] ? Colors.yellow : Colors.black,
          icon: Icon(document["isStar"] ? Icons.star : Icons.star_border),
          onPressed: () async {
            await db.collection("todo")
              .document(document.documentID)
              .updateData({"isStar" : document["isStar"] ? false : true, "timestamp" : Timestamp.now()});
            setState((){});
          },
        ),
        onLongPress: () {
          showDialog(
            context: context,
            builder: (context) => SimpleDialog(
              title: Text("Delete entry?"),
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      RaisedButton(
                        color: Colors.red,
                        textColor: Colors.white,
                        splashColor: Colors.redAccent,
                        child: Text("Delete"),
                        onPressed: () async {
                          await db.collection("todo")
                            .document(document.documentID)
                            .delete();
                          Navigator.pop(context);
                          setState(() {});
                        },
                      ),
                      SizedBox(width: 16.0),
                      RaisedButton(
                        color: Colors.blue,
                        textColor: Colors.white,
                        splashColor: Colors.blueAccent,
                        child: Text("Cancel"),
                        onPressed: () {
                          Navigator.pop(context);
                          setState(() {});
                        },
                      ),
                    ],
                  ),
                ),
              ],
            )
          );
        },
        onTap: () async {
          String _updateValue = '';
          showDialog(
            context: context,
            builder: (context) => SimpleDialog(
              title: Text("Edit text"),
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: TextField(
                          autofocus: true,
                          onChanged: (text) => _updateValue = text,
                        ),
                      ),
                      RaisedButton(
                        color: Colors.blue,
                        textColor: Colors.white,
                        splashColor: Colors.blueAccent,
                        child: Text("Update"),
                        onPressed: () async {
                          await db.collection("todo")
                            .document(document.documentID)
                            .updateData({"entry" : _updateValue, "timestamp" : Timestamp.now()});
                          Navigator.pop(context);
                          setState(() {});
                        },
                      ),
                    ],
                  ),
                ),
              ],
            )
          );
        },
      ),
    );
  }
}