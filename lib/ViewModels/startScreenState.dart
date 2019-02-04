
import 'dart:convert';
import 'dart:io';

import 'package:deepblue/ViewModels/homeScreenState.dart';
import 'package:deepblue/ViewModels/locatingScreenState.dart';
import 'package:deepblue/Views/startScreenView.dart';
import 'package:deepblue/models/setupFile.dart';
import 'package:flutter/material.dart';
import 'package:deepblue/models/CoreFunctionsModel.dart';

class StartScreen extends StatefulWidget {

  @override
  StartScreenView createState() => new StartScreenView();

}

abstract class StartScreenState extends State<StartScreen> {

   
   SetupFile fileHandler = new SetupFile();
   Color homeLocationButtonColor = Colors.white;
   CoreFunctionsModel coreClass = new CoreFunctionsModel();
   String tempPath;

  @override
  void initState(){
    super.initState();    

    fileHandler.initFileDirectory().then(
      (initFuture) async {

        if(!fileHandler.checkIfFileExists()){
          setState(() {
            homeLocationButtonColor = Colors.grey[600];
          });
        }else{
          tempPath = await fileHandler.getFilePath();  
        }

        coreClass.setManualMapHintStatus(readOutMapHintStatus());
      }
    );

    coreClass.setSetupFile(fileHandler);

  }


  bool readOutMapHintStatus(){
    if(fileHandler.checkIfFileExists()){

      Map<String,dynamic> fileContent = fileHandler.readOutSetupFile(tempPath);
      if((fileContent["manualMapHintStatus"]) == "false"){
        print("manualMapHint hidden");
        return false;
      }else{
        print("manualMapHint not hidden");
        return true;
      }

    }else{
      print("setup file not found");
      return true;
    }
  }
  void useCurrentLocation(){
    print(fileHandler.checkIfFileExists());
    Navigator.push(context,MaterialPageRoute(builder: (context) => LocatingScreen(coreClass)));
  }

  void useHomeLocation(){
    if(fileHandler.checkIfFileExists()){
       
          Map<String,dynamic> fileContent = fileHandler.readOutSetupFile(tempPath);      
          print(fileContent.toString());
          Map<String,dynamic> homeLocation = json.decode(fileContent["homeLocation"]).cast<String,double>();
          coreClass.setHomeLocationTrigger(false);
          coreClass.setSelectedLocation(homeLocation);

          Navigator.push(context,MaterialPageRoute(builder: (context) => HomeScreen(coreClass)));
          
    }else{
      print("Home Location Disabled");
    }
  }

}