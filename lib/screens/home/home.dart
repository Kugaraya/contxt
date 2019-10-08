import 'package:contxt/models/menuclipper.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.create),
        foregroundColor: Colors.white,
        backgroundColor: Colors.lightBlue,
        elevation: 3.0,
        onPressed: () {
          AlertDialog(
            content: Text("You pressed the FAB"),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(8.0))),
            elevation: 3.0,
            backgroundColor: Color.fromARGB(70, 255, 255, 255),
            contentPadding: EdgeInsets.all(5.0),
          );
        },
      ),
      key: _key,
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
                _key.currentState.openDrawer();
              },
            ),
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: true,
              title: Text('Messages'),
              background: Image.asset('assets/img/cover.jpg', fit: BoxFit.cover)
            ),
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
              color: Colors.blue[300],
              padding: EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  MaterialButton(
                    onPressed: () {},
                    child: Text("No unread messages", 
                      style: TextStyle(fontSize: 14.0, color: Colors.white)
                    ),
                  )
                ],
              )
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              child: Column(
                children: <Widget>[
                  for(int i=0; i<15; i++)
                    _addMessage(),
                ],
              )
            ),
          )
        ],
      )
    );
  }

  Widget _addMessage() {
    return Card(
      elevation: 1.0,
      margin: EdgeInsets.symmetric(vertical: 0.5, horizontal: 1.0),
      child: FlatButton(
        padding: EdgeInsets.symmetric(vertical: 2.0, horizontal: 0.0),
        child: Container(
          height: 55.0,
          child: Row(
            children: <Widget>[
              Container(
                width: 45.0,
                margin: EdgeInsets.symmetric(horizontal: 5.0),
                padding: EdgeInsets.all(4.0),
                child: CircleAvatar(
                  radius: 16.0,
                  child: Icon(Icons.person, size: 16.0,)
                ),
              ),
              Container(
                child: LimitedBox(
                  maxHeight: 55.0,
                  maxWidth: 300.0,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Text("Contact", textScaleFactor: 1.2, style: TextStyle(fontWeight: FontWeight.bold)),
                      Text("Aiyoo, just another message to be put here because why not and I need it for testing aaaaahhhh compiling takes so much time dammit please help aaaaa",
                        maxLines: 2,
                        softWrap: true,
                        overflow: TextOverflow.ellipsis,
                        textScaleFactor: 0.8,
                        style: TextStyle(fontWeight: FontWeight.normal),
                      )
                    ],
                  )
                )
              )
            ],
          ),
        ),
        onPressed: () {},
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
                    icon: Icon(Icons.power_settings_new, color: Colors.blue[200],),
                    onPressed: () {},
                  ),
                ),
                Container(
                  height: 90,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient:
                          LinearGradient(colors: [Colors.lightBlue[200], Colors.blue[700]])),
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
                  style: TextStyle(
                    color: Colors.blue[200],
                    fontSize: 16.0
                  ),
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
            )
          )
        )
      )
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
        Text(title, style: tStyle,),
      ]),
    );
  }

}