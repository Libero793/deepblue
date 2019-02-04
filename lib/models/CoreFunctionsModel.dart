import 'dart:io';

import 'package:deepblue/models/setupFile.dart';

class CoreFunctionsModel{

  SetupFile setupFile;
  Map <String,double> selectedLocation;
  bool setAsHomeLocation = false;
  bool manualMapHintStatus;

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

}