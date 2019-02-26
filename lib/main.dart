import 'dart:collection';

import 'package:deepblue/ViewModels/locatingScreenState.dart';
import 'package:deepblue/ViewModels/startScreenState.dart';
import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';

void main() {
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
    .then((_) {
      runApp(new MyApp());
    });
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Demo',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
        canvasColor: Colors.transparent,
      ),
      initialRoute: 'locate',
      routes: {
        '/':(context) => new StartScreen(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
