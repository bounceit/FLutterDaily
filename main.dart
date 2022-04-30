import 'package:flutter/material.dart';
import 'package:flutter_daily/pages/home.dart';
import 'package:flutter_daily/pages/main_screen.dart';


void main() => runApp(MaterialApp(
  theme: ThemeData(
    primaryColor: Colors.red,
  ),
  initialRoute: '/',
  routes: {
    '/': (context) => MainScreen(),
    '/daily': (context) => Home(),
  },
));