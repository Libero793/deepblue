import 'dart:async';

import 'package:deepblue/screens/homeScreen.dart';
import 'package:deepblue/screens/locatingScreen.dart';
import 'package:deepblue/screens/nameNewLocation.dart';
import 'package:flutter/material.dart';
import 'package:latlong/latlong.dart';
import 'package:deepblue/models/RegisterLocationModel.dart';
import 'package:http/http.dart' as http;


class confirmRegistrationScreen extends StatelessWidget{

  Color menuBackgroundColor = Colors.blue[900];  
   
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
  
    return Scaffold(
      backgroundColor: menuBackgroundColor,
      appBar: AppBar(
        title: Text(""),
        centerTitle: true,
        backgroundColor: menuBackgroundColor,
        elevation: 0.0,
        automaticallyImplyLeading: false,
      ),

      body: new Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[

            Row(),
            
            Padding(
              padding: const EdgeInsets.fromLTRB(24.0, 100.0, 24.0, 0.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Icon(Icons.beenhere, color: Colors.white,size: 150.0,),
                ],
              )
            ),

            Padding(
              padding: const EdgeInsets.fromLTRB(24.0, 20.0, 24.0, 0.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text("Gespeichert!", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 26.0,), textAlign: TextAlign.center,),
                ],
              )
            ),

            new Expanded(
              child: new Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  new Expanded(
                    child: new GestureDetector(
                      onTap:(){
                        Navigator.pop(context);
                         Navigator.push(
                          context, 
                          MaterialPageRoute(builder: (context) => LocatingScreen()),
                        );
                      },
                      child: new Container(
                        color: Colors.white,
                        height: 60.0,
                        child: new Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Text("Schliessen",style: TextStyle(color: menuBackgroundColor, fontSize: 16.0, fontWeight: FontWeight.bold)),
                        ],
                        ),
                      )
                    ) 
                  )
                ],
              )
            )

          ],
        ),
      ),
    );
  }

}