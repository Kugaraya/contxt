import 'package:ConTXT/models/navigator.dart';
import 'package:ConTXT/models/menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sms_maintained/sms.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key}) : super(key: key);
  final String title = "Messages";
  final SmsQuery query = SmsQuery();

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {  
  AnimationController _controller;
  List<SmsMessage> messages;
  List<SmsThread> threads;
  int _itemCount = 1;

  void queryMsgs() async {
    messages = await widget.query.getAllSms;
    threads = await widget.query.getAllThreads;
  }

  @override
  void initState() {
    queryMsgs();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(
        milliseconds: 200,
      ),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.create),
        foregroundColor: Colors.white,
        backgroundColor: Colors.lightBlue,
        elevation: 3.0,
        onPressed: () {
          print(threads);
          print(messages);
          setState(() {
            _itemCount++;
            Fluttertoast.showToast(
              msg: "Item Count: $_itemCount",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIos: 1,
              backgroundColor: Color.fromARGB(80, 0, 0, 0),
              textColor: Colors.white,
              fontSize: 16.0
            );
          });
        },
      ),
      drawer: buildDrawer(),
      backgroundColor: Colors.white12,
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            backgroundColor: Colors.blue[300],
            expandedHeight: 150.0,
            pinned: true,
            automaticallyImplyLeading: false,
            leading: IconButton(
              icon: Icon(Icons.menu),
              onPressed: () {
                NavigatorModel().scaffoldKey.currentState.openDrawer();
              },
            ),
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: true,
              title: Text('Messages'),
              background: Image.asset('assets/img/cover.jpg', fit: BoxFit.cover)),
            actions: <Widget>[
              IconButton(
                tooltip: "Search",
                icon: Icon(Icons.search),
                onPressed: () {},
              ),
              IconButton(
                tooltip: "Settings",
                icon: Icon(Icons.settings),
                onPressed: () {},
              ),
            ],
          ),
          SliverToBoxAdapter(
            child: Column(
              children: <Widget>[
                Container(
                  color: Colors.blue,
                  padding: EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      MaterialButton(
                        onPressed: () {},
                        child: Text("No unread messages",
                          style: TextStyle(fontSize: 14.0, color: Colors.white)),
                      )
                    ],
                  )
                ),
              ],
            ),
          ),
          SliverToBoxAdapter(
            child: AnimatedContainer(
              duration: Duration(milliseconds: 300),
              curve: Curves.easeOut,
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                physics: BouncingScrollPhysics(),
                child: Column(
                  children: <Widget>[
                  for(int i=0; i<_itemCount; i++)
                    OutlineButton(
                      padding: EdgeInsets.all(0.0),
                      onPressed: () => Navigator.of(context).pushNamed('/messages/compose'),
                      child: ListTile(
                        dense: true,
                        isThreeLine: true,
                        leading: CircleAvatar(
                          child: Icon(Icons.person),
                        ),
                        title: Text("Contact Name",
                          style: TextStyle(
                            fontSize: 14.0,
                            fontWeight: FontWeight.w500
                          ),
                        ),
                        subtitle: Text("This is a very very long message for the sake of testing how many characters does a single ListTile support in this set dimension",
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          softWrap: true,
                        ),
                        trailing: Column(
                          children: <Widget>[
                            Text("12:01"),
                            SizedBox(height: 10.0),
                            CircleAvatar(
                              backgroundColor: Colors.blue,
                              foregroundColor: Colors.white,
                              radius: 8.0,
                              child: Center(
                                child: Text("1",
                                  style: TextStyle(
                                    fontSize: 10.0
                                  )
                                ),
                              )
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
