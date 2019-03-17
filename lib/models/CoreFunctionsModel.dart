import 'dart:io';
import 'dart:ui';

import 'package:deepblue/models/setupFile.dart';
import 'package:flutter/material.dart';

class CoreFunctionsModel{

  SetupFile setupFile;
  Map <String,double> selectedLocation;
  bool setAsHomeLocation = false;
  bool manualMapHintStatus;
  static Color highlightColor = Color(0xfff6aa1c);
  Color eventColor = Color(0xffdb1529);
  Color washboxColor = Color(0xff308dcc);
  Color shootingColor = Color(0xff00af5a);

  getSetupFile(){
    return setupFile;
  }

  setSetupFile(file){
    setupFile=file;
  }

  getSelectedLocation(){
    return selectedLocation;
  }

  setSelectedLocation(location){
    selectedLocation = location;
  }

  getHomeLocationTrigger(){
    return setAsHomeLocation;
  }

  setHomeLocationTrigger(trigger){
    setAsHomeLocation=trigger;
  }

  getManualMapHintStatus(){
    return manualMapHintStatus;
  }

  setManualMapHintStatus(status){
    manualMapHintStatus=status;
  }

  getHighlightColor(){
    return highlightColor;
  }

  Color getShootingColor(){
    return shootingColor;
  }

  Color getWashboxColor(){
    return washboxColor;
  }

  Color getEventColor(){
    return eventColor;
  }

  Color getColorSheme(selected){
    switch (selected) {
      case "event":
          return eventColor;
        break;
      case "shooting":
          return shootingColor;
        break;
      case "washbox":
          return washboxColor;
        break;
      default:
    }
  }


}