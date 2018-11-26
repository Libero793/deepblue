import 'dart:async';
import 'package:deepblue/screens/homeScreen.dart';
import 'package:deepblue/screens/manualLocationMapScreen.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart' as gps;
import 'package:geolocation/geolocation.dart' ;
import 'package:location/location.dart' as location;
import 'package:flutter/services.dart';
import 'package:settings/settings.dart';


class LocatingScreen extends StatefulWidget{

     
   _locationState createState() => new _locationState();
}

 class _locationState extends State<LocatingScreen>{

  Map<String, double> _startLocation;
  Map<String, double> _currentLocation;

  StreamSubscription<Map<String, double>> _locationSubscription;

  location.Location _location = new location.Location();
  bool _permission = false;
  String error;

  bool currentWidget = true;
  Timer gpsTimer;

  bool pushedToHomeScreen=false;

  bool gpsAccessChecked=false;
  bool gpsStatus = true;
  bool timerRunning=false;



  getPosition() async {

          print("getposition");
          

          gps.Position position = await gps.Geolocator().getCurrentPosition(desiredAccuracy: gps.LocationAccuracy.high);
          gpsTimer.cancel();
          print("gpsPosition:$position");
          if(!pushedToHomeScreen && position != null){
            print("got${position.toString()}");
            var positionMap = new Map<String,double>();
            positionMap["latitude"] = position.latitude;
            positionMap["longitude"] = position.longitude;
        
            if(!pushedToHomeScreen){
              Navigator.pop(context);
              Navigator.push(context,MaterialPageRoute(builder: (context) => HomeScreen(positionMap)));
              pushedToHomeScreen=true;
              
            }
          }
          
    
  }

  getLocation() async{

      print("trytogetlocation");

      final GeolocationResult result = await Geolocation.isLocationOperational();
      if(result.isSuccessful) {
        // location service is enabled, and location permission is granted
        print("gps enabled");
        getPosition();
      } else {
        // location service is not enabled, restricted, or location permission is denied
        print("gps disabled");
    
        //Settings.openGPSSettings();

        //Navigator.pop(context);
        //Navigator.push(context,MaterialPageRoute(builder: (context) => LocatingScreen()));
      }
  
    

  }

   initPlatformState() async {
    Map<String, double> location;
    // Platform messages may fail, so we use a try/catch PlatformException.

    try {
      _permission = await _location.hasPermission();
      location = await _location.getLocation();


      error = null;
    } on PlatformException catch (e) {
      if (e.code == 'PERMISSION_DENIED') {
        error = 'Permission denied';
      } else if (e.code == 'PERMISSION_DENIED_NEVER_ASK') {
        error = 'Permission denied - please ask the user to enable it from the app settings';
      }

      location = null;
    }

    if (this.mounted){
      setState(() {
          _startLocation = location;
      });
    }

  }



  @override
  void initState() {
    super.initState();



    initPlatformState();

    _locationSubscription =
        _location.onLocationChanged().listen((Map<String,double> result) {
            if (this.mounted){
              setState(() {
                _currentLocation = result;
              });
            }
          //print("currentloc$_currentLocation");
        });
  }


  @override
  Widget build(BuildContext context) {
  

  //getLocation();
  //getPosition();

  if(!timerRunning){
          setState(() { timerRunning=true;  });
          const oneSec = const Duration(seconds:33);
          gpsTimer = new Timer.periodic(oneSec, (Timer t) => getLocation());
  }


    return Scaffold(
      backgroundColor: Colors.blue,
      appBar: AppBar(
        title: Text(""),
        centerTitle: true,
        backgroundColor: Colors.blue,
        elevation: 0.0,
    ),




    body: new Center(
        child: Stack(        
            
          children: <Widget>[
             
          Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[

                Expanded(
                  child: new Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
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
                              ],
                            ),
                          ),
                        ]
                      ),

                      new Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.max,
                        children: <Widget>[
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 45.0),
                              child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  mainAxisSize: MainAxisSize.max,
                                  children: <Widget>[
                                    Icon(Icons.info_outline,size: 40.0,color: Colors.white),                     
                                    Container(
                                      width: 230.0,
                                      color: Colors.blue,
                                      child:new Padding(
                                          padding: const EdgeInsets.fromLTRB(20.0,0.0,0.0,0.0),
                                          child: Text("Verwende den Karten Modus, falls dein Standort über GPS nicht automatisch lokalisiert werden kann.", 
                                            style: TextStyle(fontSize: 12.0, color: Colors.white),
                                            textAlign: TextAlign.left,
                                          ),
                                        ),
                                    )
                                  ]
                                )
                            )
                            
                          )
                          
                        ]
                      ),
                    ],
                  )
                )
              ]
          ),
              
  
         
          new Column(
            children: <Widget>[
              Expanded(
                child: Container(
                  
                  child: new Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        new Expanded(
                          child: new GestureDetector(
                            onTap:(){
                              Navigator.push(context,MaterialPageRoute(builder: (context) => manualLocationMapScreen()));
                            },
                              child: new Container(
                                color: Colors.white,
                                height: 60.0,
                                child: new Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Text("Karten Modus",style: TextStyle(color: Colors.blue, fontSize: 16.0, fontWeight: FontWeight.bold)),
                                ],
                                ),
                              )
                            ) 
                          )
                        ],
                  )
                )
              )
            ]
          )
       

          ],
        ),
      ),
    );

      
  }
}
