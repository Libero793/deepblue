import 'dart:async';
import 'package:deepblue/ViewModels/homeScreenState.dart';
import 'package:deepblue/Views/locatingScreenView.dart';
import 'package:deepblue/ViewModels/manualLocationMapState.dart';
import 'package:deepblue/models/CoreFunctionsModel.dart';
import 'package:deepblue/models/setupFile.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart' as gps;
import 'package:location/location.dart' as locationPackage;
import 'package:flutter/services.dart';


class LocatingScreen extends StatefulWidget{

    CoreFunctionsModel coreClass;
    LocatingScreen(this.coreClass);

    LocatingScreenView createState() => new LocatingScreenView();
}

abstract class LocatingScreenState extends State<LocatingScreen>{

  locationPackage.LocationData _startLocation;
  locationPackage.LocationData _currentLocation;
  SetupFile fileHandler = new SetupFile();

  StreamSubscription<Map<String, double>> _locationSubscription;

  var _location = new locationPackage.Location();
  bool _permission = false;
  String error;

  bool currentWidget = true;

  bool pushedToHomeScreen=false;

  bool gpsAccessChecked=false;
  bool gpsStatus = true;
  bool setAsHomeLocation = false;
  Timer startGpsTimer;

  @override
  void dispose() {
    super.dispose();
  }

 
   initPlatformState() async {
     print("iniplatformState");
    locationPackage.LocationData currentLocation;

    var location = new locationPackage.Location();
    

    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      
      if(await location.hasPermission()){         //prüfe ob berechtigug bereits erteilt
        runServiceRequest(location);
      }else{                                      //wenn nciht dann frage berechtigung an
        if(await location.requestPermission()){
          print("reqPermission");
          runServiceRequest(location);
        }else{
          print("else triggered");
          initPlatformState();
        }
      }
      
      //currentLocation = await location.getLocation();
    } on PlatformException catch (e) {
      if (e.code == 'PERMISSION_DENIED') {
        error = 'Permission denied';
      } 
      initPlatformState();
    }

  }

  Future runServiceRequest(location) async {
        if(await location.requestService()){
          print("run location Lstener");
          
          runLocationListener();
        }else{
          initPlatformState();
        }
  }

  void runLocationListener(){
      var locationEvent;

      locationEvent= _location.onLocationChanged().listen((locationPackage.LocationData result) {
        
          
                  print(result.latitude);

                  if(!pushedToHomeScreen && result.latitude != null && result.longitude != null){
                    
                    var positionMap = new Map<String,double>();
                    positionMap["latitude"] = result.latitude;
                    positionMap["longitude"] = result.longitude;

                    widget.coreClass.setSelectedLocation(positionMap);
                
                    if(!pushedToHomeScreen){
                      locationEvent.cancel();
                      startGpsTimer.cancel();
                      Navigator.pop(context);
                      Navigator.push(context,MaterialPageRoute(builder: (context) => HomeScreen(widget.coreClass)));
                      setState(() {
                                      pushedToHomeScreen=true;
                                    });
                      
                    }
                  }
              
              
      });
      
  }

  void toggleHomeLocationBox(bool e){
    if(this.mounted){
      setState(() {
        setAsHomeLocation = e;
        widget.coreClass.setHomeLocationTrigger(e);
        print("homeLocationTrigger set to $e");
      });
    }
  }

  void pushToManualLocationMap(){
    Navigator.push(context,MaterialPageRoute(builder: (context) => ManualLocationMap(widget.coreClass)));
  }

  void hideHint(){
    setState(() {
      widget.coreClass.setManualMapHintStatus(false);
      SetupFile file = widget.coreClass.getSetupFile();
      file.writeToFile("manualMapHintStatus", "false");
      print("manualMapHintStatus changed to false");
    });
  }



  @override
  void initState() {
    super.initState();

    startGpsTimer = new Timer(const Duration(milliseconds: 3000), () {
      initPlatformState(); 
    });
      

  }


  
}
