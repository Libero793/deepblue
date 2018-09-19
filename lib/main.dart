import 'dart:collection';

import 'package:deepblue/screens/mapScreen.dart';
import 'package:flutter/material.dart';
import 'package:deepblue/screens/homeScreen.dart';
import 'dart:async';

void main(){
  runApp(new MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Demo',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/':(context) => new HomeScreen(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
