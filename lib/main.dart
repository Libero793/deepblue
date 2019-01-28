import 'dart:collection';

import 'package:deepblue/ViewModels/locatingScreenState.dart';
import 'package:flutter/material.dart';
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
        canvasColor: Colors.transparent,
      ),
      initialRoute: 'locate',
      routes: {
        '/':(context) => new LocatingScreen(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
