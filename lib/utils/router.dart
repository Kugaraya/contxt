import 'package:flutter/material.dart';

class Router {

  static MaterialPageRoute createRoute(route) {
    return MaterialPageRoute(builder: (_) => route);
  }
  
}