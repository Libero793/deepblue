import 'dart:async';
import 'package:deepblue/screens/homeScreen.dart';
import 'package:flutter/material.dart';

import 'package:geolocator/geolocator.dart';


class LocatingScreen extends StatefulWidget{
   _locationState createState() => new _locationState();
}

 class _locationState extends State<LocatingScreen>{

 
  @override
  void initState() {
    
      
  }

  getPosition() async {

    GeolocationStatus geolocationStatus  = await Geolocator().checkGeolocationPermissionStatus();
    Position position = await Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.high);

    
    var positionMap = new Map<String,double>();
    positionMap["latitude"] = position.latitude;
    positionMap["longitude"] = position.longitude;

    Navigator.pop(context);
    Navigator.push(context,MaterialPageRoute(builder: (context) => HomeScreen(positionMap)));
  }


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
      
    getPosition();
  
    return Scaffold(
      backgroundColor: Colors.blue,
      appBar: AppBar(
        title: Text(""),
        centerTitle: true,
        backgroundColor: Colors.blue,
        elevation: 0.0,
      ),

    body: new Center( heightFactor: 100.00,
        child: Column(        
            
          children: <Widget>[
             
          Expanded(
            child: new Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                new Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                          padding: const EdgeInsets.fromLTRB(0.0,0.0,0.0,20.0),
                          child: Icon(Icons.location_off, size: 100.0, color: Colors.white,),
                      ),
                     
                  ],  
                ),

                new Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Padding(
                          padding: const EdgeInsets.fromLTRB(0.0,20.0,0.0,10.0),
                          child: Text("Standort suche läuft ...", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 26.0,)),
                      ),
                      
                     
                  ],  
                ),
                new Row(
                  children: <Widget>[
                    new Flexible(
                      child:Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          new Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 48.0),
                            child:  LinearProgressIndicator()                        

                          ),
                          new Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 48.0),
                            child: Text("Bitte überprüfe ob dein GPS eingeschaltet ist, damit wir dir Waschboxen in deiner Nähe anzeigen können.", 
                              style: TextStyle(fontSize: 14.0, color: Colors.white),
                            ),
                          ),

                        ],
                      ),
                    ),
                  ]
                ),
              ],
            )
          ),
                  
                /*
                Padding(
                  padding: const EdgeInsets.fromLTRB(34.0, 40.0, 36.0, 0.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text("Standort suche läuft ...", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 26.0,)),                     
                    ],
                  )
                ),

                Padding(
                  padding: const EdgeInsets.fromLTRB(36.0, 10.0, 36.0, 80.0),
                  child: Text("Bitte überprüfe ob dein GPS eingeschaltet ist, damit wir dir Waschboxen in deiner nähe anzeigen können.", 
                            style: TextStyle(fontSize: 14.0, color: Colors.white),
                        ),
                
                ),*/


          /*
          Expanded(
            child: new Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.fromLTRB(34.0, 40.0, 36.0, 0.0),
                  child: new Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
                        child: Text("Standort suche läuft ...", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 26.0,)),   
                      ),
                    ],
                  )
                ),
              ],  
            )
          ),*/

    

                          /*
                      Padding(
                        padding: const EdgeInsets.fromLTRB(34.0, 40.0, 36.0, 0.0),
                        child: Text("Bitte überprüfe ob dein GPS eingeschaltet ist, damit wir dir Waschboxen in deiner nähe anzeigen können.", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 26.0,)),   
                      )*/

            /*
            new Expanded(
              child: new Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  new Expanded(
                    child: new GestureDetector(
                      onTap:(){
                        Navigator.push(
                          context, 
                          MaterialPageRoute(builder: (context) => HomeScreen(null)),
                        );
                      },
                      child: new Container(
                        color: Colors.white,
                        height: 60.0,
                        child: new Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Text("Weiter",style: TextStyle(color: Colors.blue, fontSize: 16.0, fontWeight: FontWeight.bold))
                        ],
                        ),
                      )
                    ) 
                  )
                ],
              )
            )*/
          ],
        ),
      ),
    );

      
  }
}
