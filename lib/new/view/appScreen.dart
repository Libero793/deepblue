import 'package:flutter/material.dart';
import 'package:path/path.dart';

class AppScreen extends StatelessWidget {
  AppScreen({this.title});
  String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            title,
          ),
          backgroundColor: Colors.black,
        ),
        body: 
        Container(
          color: Colors.white,
          child: OutlineButton(
            
          ),
        ));
  }

 
}