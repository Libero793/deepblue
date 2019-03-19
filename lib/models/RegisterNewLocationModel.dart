import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RegisterNewLocationModel{

  Map<String,double> location;
  String locationName;
  String locationType;
  String locationBase64Image = null;

  bool hochdruckReiniger=false;
  bool schaumBuerste=false;
  bool schaumPistole=false;
  bool fliessendWasser=false;
  bool motorWaesche=false;

  var startTime="2019-04-20 16:20";
  var endTime="2019-04-20 16:20";

  IconData icon;


  void setLocation(loc){
    location = loc;
  }

  Map <String,double> getLocation(){
    return location;
  }

  void setLocationType(String type){
    locationType = type;
  }

  String getLocationType(){
    return locationType;
  }

  IconData getIcon(){
    switch (locationType) {
      case "washbox" :  {
        return Icons.local_car_wash;
      }

      case "event" : {
        return Icons.star;
      }

      case "shooting" : {
        return Icons.camera_alt;
      }
        
        break;
      default:
    }
  }

  void setLocationName(name){
    locationName = name;
  }

  String getLocationName(){
    return locationName;
  }




}