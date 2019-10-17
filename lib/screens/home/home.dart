import 'package:ConTXT/sim/sim_bloc_provider.dart';
import 'package:ConTXT/sim/sim_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sms_maintained/sms.dart';
import 'package:sms_maintained/contact.dart';
import 'package:ConTXT/screens/home/thread.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key}) : super(key: key);
  final String title = "Messages";
  final SmsQuery query = SmsQuery();
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin,AutomaticKeepAliveClientMixin<HomeScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final UserProfileProvider _userProfileProvider = UserProfileProvider();
  final SmsQuery _query = SmsQuery();
  final SmsReceiver _receiver = SmsReceiver();
  final SmsSender _smsSender = SmsSender();
  final bloc = SimCardsBloc();
  bool _loading = true;
  List<SmsThread> _threads;
  UserProfile _userProfile;
  ScrollController scrollController = ScrollController();
  // Animation
  AnimationController opacityController;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    _receiver.onSmsReceived.listen(_onSmsReceived);
    _userProfileProvider.getUserProfile().then(_onUserProfileLoaded);
    _query.getAllThreads.then(_onThreadsLoaded);
    _smsSender.onSmsDelivered.listen(_onSmsDelivered);
    
    // Animation
    opacityController = AnimationController(
      duration: Duration(milliseconds: 500), vsync: this, value: 0.0
    );
  }

  @override
  Widget build(BuildContext context) {
    bloc.loadSimCards();
    super.build(context);
    return SimCardsBlocProvider(
      simCardBloc: bloc,
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.create),
          foregroundColor: Colors.white,
          backgroundColor: Colors.lightBlue,
          elevation: 3.0,
          onPressed: () {
            setState(() {
              Fluttertoast.showToast(
                msg: "Edit button pressed",
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
        backgroundColor: Colors.white12,
        body: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              backgroundColor: Colors.blue[300],
              expandedHeight: 150.0,
              pinned: true,
              automaticallyImplyLeading: false,
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
                margin: EdgeInsets.only(bottom: 0.0),
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
              child: Column(
                children: <Widget>[
                  Expanded(
                    child: _getThreadsWidgets()
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
  Widget _getThreadsWidgets() {
    if (_loading) {
      return Center(
        child: CircularProgressIndicator(),
      );
    } else {
      return FadeTransition(
        opacity: opacityController,
        child: ListView.builder(
          controller: scrollController,
          padding: EdgeInsets.all(0.0),
          physics: ClampingScrollPhysics(),
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          cacheExtent: 8.0,
          itemCount: _threads.length,
          itemBuilder: (context, index) {
            return Thread(_threads[index], _userProfile);
          },
        ),
      );
    }
  }

  void _onSmsReceived(SmsMessage sms) async {
    var thread = _threads.singleWhere((thread) {
      return thread.id == sms.threadId;
    }, orElse: () {
      var thread = SmsThread(sms.threadId);
      _threads.insert(0, thread);
      return thread;
    });

    thread.addNewMessage(sms);
    await thread.findContact();

    int index = _threads.indexOf(thread);
    if (index != 0) {
      _threads.removeAt(index);
      _threads.insert(0, thread);
    }

    setState(() {});
  }

  void _checkIfLoadCompleted() {
    if (_threads != null && _userProfile != null) {
      setState(() {
        _loading = false;
        opacityController.animateTo(1.0, curve: Curves.easeIn);
      });
    }
  }

  void _onThreadsLoaded(List<SmsThread> threads) {
    _threads = threads;
    _checkIfLoadCompleted();
  }

  void _onUserProfileLoaded(UserProfile userProfile) {
    _userProfile = userProfile;
    _checkIfLoadCompleted();
  }


  void _onSmsDelivered(SmsMessage sms) async {
    final contacts = ContactQuery();
    Contact contact = await contacts.queryContact(sms.address);
    final snackBar = SnackBar(
        content: Text('Message to ${contact.fullName} delivered'));
    Scaffold.of(context).showSnackBar(snackBar);
  }
}
