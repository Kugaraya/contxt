import 'package:ConTXT/models/menuclipper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:fluttertoast/fluttertoast.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key}) : super(key: key);
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  AnimationController _controller;
  int _itemCount = 1;

  @override
  void initState() {
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
      key: _scaffoldKey,
      drawer: _buildDrawer(),
      backgroundColor: Colors.grey[300],
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
                _scaffoldKey.currentState.openDrawer();
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

  _buildDrawer() {
    final String _img = "assets/img/user.jpg";
    return ClipPath(
        clipper: MenuClipper(),
        child: Container(
            padding: EdgeInsets.only(left: 16.0, right: 40),
            decoration: BoxDecoration(
              color: Colors.blue[900],
              boxShadow: [BoxShadow(color: Colors.black45)]
            ),
            width: 300.0,
            height: double.maxFinite,
            child: SafeArea(
              child: SingleChildScrollView(
                child: Column(
              children: <Widget>[
                Container(
                  alignment: Alignment.centerRight,
                  child: IconButton(
                    icon: Icon(
                      Icons.power_settings_new,
                      color: Colors.blue[200],
                    ),
                    onPressed: () {},
                  ),
                ),
                Container(
                  height: 90,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                        colors: [Colors.lightBlue[200], Colors.blue[700]]
                    )
                  ),
                  child: CircleAvatar(
                    radius: 40,
                    backgroundImage: AssetImage(_img),
                  ),
                ),
                SizedBox(height: 5.0),
                Text(
                  "Kim Testa",
                  style: TextStyle(color: Colors.white, fontSize: 18.0),
                ),
                Text(
                  "github@TK-Works",
                  style: TextStyle(color: Colors.blue[200], fontSize: 16.0),
                ),
                SizedBox(height: 30.0),
                _buildRow(Icons.home, "Home"),
                _buildDivider(),
                _buildRow(Icons.person_pin, "Your profile"),
                _buildDivider(),
                _buildRow(Icons.settings, "Settings"),
                _buildDivider(),
                _buildRow(Icons.email, "Contact us"),
                _buildDivider(),
                _buildRow(Icons.help, "Help"),
                _buildDivider(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Divider _buildDivider() {
    return Divider(
      color: Colors.blue[200],
    );
  }

  Widget _buildRow(IconData icon, String title) {
    final TextStyle tStyle = TextStyle(color: Colors.blue[200], fontSize: 16.0);

    return FlatButton(
      onPressed: () {},
      padding: EdgeInsets.symmetric(vertical: 8.0),
      child: Row(children: [
        Icon(icon, color: Colors.blue[200]),
        SizedBox(width: 10.0),
        Text(
          title,
          style: tStyle,
        ),
      ]),
    );
  }
}
