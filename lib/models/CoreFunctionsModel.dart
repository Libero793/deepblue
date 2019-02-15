import 'dart:io';
import 'dart:ui';

import 'package:deepblue/models/setupFile.dart';
import 'package:flutter/material.dart';

class CoreFunctionsModel{

  SetupFile setupFile;
  Map <String,double> selectedLocation;
  bool setAsHomeLocation = false;
  bool manualMapHintStatus;
  Color highlightColor = Color(0xff2980b9);

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


}