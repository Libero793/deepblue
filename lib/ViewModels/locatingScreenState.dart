import 'dart:async';
import 'package:deepblue/ViewModels/homeScreenState.dart';
import 'package:deepblue/Views/locatingScreenView.dart';
import 'package:deepblue/ViewModels/manualLocationMapState.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart' as gps;
import 'package:geolocation/geolocation.dart' ;
import 'package:location/location.dart' as location;
import 'package:flutter/services.dart';


class LocatingScreen extends StatefulWidget{

    LocatingScreenView createState() => new LocatingScreenView();
}

abstract class LocatingScreenState extends State<LocatingScreen>{

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

  bool setAsHomeLocation = false;

  @override
  void dispose() {
    super.dispose();
    gpsTimer.cancel();
  }

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
              Navigator.push(context,MaterialPageRoute(builder: (context) => HomeScreen(positionMap,setAsHomeLocation)));
              setState(() {
                              pushedToHomeScreen=true;
                            });
              
              
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

  toggleHomeLocationBox(bool e){
    if(this.mounted){
      setState(() {
        setAsHomeLocation = e;
      });
    }
  }

  pushToManualLocationMap(){
    Navigator.push(context,MaterialPageRoute(builder: (context) => ManualLocationMap(setAsHomeLocation)));
  }



  @override
  void initState() {
    super.initState();

      if(!timerRunning){
          setState(() { timerRunning=true;  });
          const oneSec = const Duration(seconds:33);
          gpsTimer = new Timer.periodic(oneSec, (Timer t) => getLocation());
  }

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


  
}
