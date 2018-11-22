import 'dart:async';
import 'package:deepblue/screens/homeScreen.dart';
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
        /*if(!gpsStatus){

          Navigator.pop(context);
          Navigator.push(context,MaterialPageRoute(builder: (context) => LocatingScreen()));
        }*/
        // location service is enabled, and location permission is granted
        print("gps enabled");
        getPosition();
      } else {
        // location service is not enabled, restricted, or location permission is denied
        print("gps disabled");
        gpsStatus=false;
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
          const oneSec = const Duration(seconds:1);
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
                            child: Text("Bitte überprüfe ob dein GPS auf den Modus eingeschaltet ist, damit wir dir Waschboxen in deiner Nähe anzeigen können.", 
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
          ],
        ),
      ),
    );

      
  }
}
