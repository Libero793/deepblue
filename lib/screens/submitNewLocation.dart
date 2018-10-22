import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:deepblue/models/RegisterLocationModel.dart';
import 'package:flutter/material.dart';
import 'package:latlong/latlong.dart';


class SubmitNewLocationScreen extends StatefulWidget{

  RegisterLocationModel registerModel;
   Map<String, double> pushedLocation;
  SubmitNewLocationScreen(this.registerModel,this.pushedLocation);
  @override
  _SubmitNewLocationScreen createState() => _SubmitNewLocationScreen(registerModel,pushedLocation);

}

class _SubmitNewLocationScreen extends State<SubmitNewLocationScreen>{

  RegisterLocationModel registerModel;
  Map<String, double> pushedLocation;
  _SubmitNewLocationScreen (this.registerModel, this.pushedLocation);

  Color menuBackgroundColor = Colors.blue[900];
  
  //_RegisterLocationScreen(this.pushedLocation);
  Future httpReturn;
  String test;

 
 

  void httpRequest()async {

    var url = "http://www.nell.science/deepblue/index.php";

    http.post(url, body: {"getWashingLocations":"true",
                          "key": "0", 
                          "latitude": pushedLocation['latitude'].toString(), 
                          "longitude": pushedLocation['longitude'].toString(),
                          "hochdruckReiniger": registerModel.getHochdruckReiniger().toString(), 
                          "schaumBuerste": registerModel.getSchaumBuerste().toString(),
                          "schaumPistole": registerModel.getSchaumPistole().toString(),
                          "fliessendWasser": registerModel.getFliessendWasser().toString(),
                          "motorWaesche": registerModel.getMotorWaesche().toString(),
                          
                          })
        .then((response) {
      print("Response status: ${response.statusCode}");   
      print("Response body: ${response.body}");
      print("httpreq");

      setState((){
              test = response.body.toString();
          });

    });
    
  }
  
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    print("HochdruckReiniger ${registerModel.getHochdruckReiniger()}");
    print("schaum Buerste ${registerModel.getSchaumBuerste()}");
    print("schaum Pistole ${registerModel.getSchaumPistole()}");
    print("fliessend Wasser ${registerModel.getFliessendWasser()}");
    print("motor Waesche ${registerModel.getMotorWaesche()}");
    print("location: $pushedLocation");
    return Scaffold(
      backgroundColor: menuBackgroundColor,
      appBar: AppBar(
        title: Text(""),
        centerTitle: true,
        backgroundColor: menuBackgroundColor,
        elevation: 0.0,
      ),

      body: new Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[

            Row(),

            Padding(
              padding: const EdgeInsets.fromLTRB(36.0, 40.0, 36.0, 0.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text("Waschbox hinzufügen", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 26.0)),
                ],
              )
            ),

            Padding(
              padding: const EdgeInsets.fromLTRB(36.0, 10.0, 36.0, 80.0),
              child: Text("Bitte gib ein paar Details an, über die Waschbox die du hinzufügen möchtest", 
                        style: TextStyle(fontSize: 14.0, color: Colors.white),
                     ),
            
            ),

            


            new Expanded(
              child: new Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  new Expanded(
                    child: new GestureDetector(
                      onTap:(){
                        httpRequest();
                      },
                      child: new Container(
                        color: Colors.white,
                        height: 60.0,
                        child: new Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Text("Weiter",style: TextStyle(color: menuBackgroundColor, fontSize: 16.0, fontWeight: FontWeight.bold))
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