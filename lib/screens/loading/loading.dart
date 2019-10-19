import 'package:ConTXT/models/navigator.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:splashscreen/splashscreen.dart';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  
  Widget build(BuildContext context) {
    return SplashScreen(
      seconds: 2,
      navigateAfterSeconds: NavigatorModel(),
      image: Image.asset('assets/logo.png'),
      backgroundColor: Colors.white,
      loadingText: Text("Loading..."),
      styleTextUnderTheLoader: TextStyle(
        fontSize: 8.0,
        color: Colors.grey[400]
      ),
      photoSize: 100.0,
      onClick: () => Fluttertoast.showToast(
        msg: "Relax, the app will load in a bit",
        backgroundColor: Colors.black38,
        gravity: ToastGravity.BOTTOM,
        fontSize: 12.0,
        textColor: Colors.white,
        timeInSecForIos: 1,
        toastLength: Toast.LENGTH_SHORT
      ),
    );
  }
}
