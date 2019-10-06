import 'package:ConTXT/models/menuclipper.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  int _itemCount = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.create),
        foregroundColor: Colors.white,
        backgroundColor: Colors.lightBlue,
        elevation: 2.0,
        onPressed: () {
          setState(() {
            _itemCount++;
            Fluttertoast.showToast(
                msg: "Tap Count: $_itemCount",
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
            child: Container(
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
          ),
          SliverToBoxAdapter(
            child: Container(
              child: ListView(
                physics: BouncingScrollPhysics(),
                children: <Widget>[
                  ListTile(
                    dense: true,
                    isThreeLine: true,
                    leading: CircleAvatar(
                      backgroundColor: Colors.blue,
                      foregroundColor: Colors.white,
                      child: Icon(Icons.person),
                    ),
                    title: Text("Contact Name"),
                    subtitle: Text("Message content here",
                      maxLines: 2,
                      softWrap: true,
                      overflow: TextOverflow.ellipsis,
                    ),
                    trailing: Column(
                      children: <Widget>[
                        Text("12:01"),
                        CircleAvatar(
                          backgroundColor: Colors.blue,
                          foregroundColor: Colors.white,
                          radius: 8.0,
                          child: Text("1", style: TextStyle(
                            fontSize: 7.0,
                            fontWeight: FontWeight.bold
                          ),)
                        )
                      ],
                    ),
                    onTap: () => Fluttertoast.showToast(
                      msg: "You tapped a list item",
                      gravity: ToastGravity.BOTTOM,
                      toastLength: Toast.LENGTH_SHORT
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      )
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
                boxShadow: [BoxShadow(color: Colors.black45)]),
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
                          colors: [Colors.lightBlue[200], Colors.blue[700]])),
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

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
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
