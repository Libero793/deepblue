
import 'dart:convert';
import 'dart:io';

import 'package:deepblue/ViewModels/homeScreenState.dart';
import 'package:deepblue/ViewModels/locatingScreenState.dart';
import 'package:deepblue/Views/startScreenView.dart';
import 'package:deepblue/models/setupFile.dart';
import 'package:flutter/material.dart';

class StartScreen extends StatefulWidget {

  @override
  StartScreenView createState() => new StartScreenView();

}

abstract class StartScreenState extends State<StartScreen> {

   
   SetupFile fileHandler = new SetupFile();
   Color homeLocationButtonColor = Colors.white;
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
      }
    );

   


  }

  void useCurrentLocation(){
    print(fileHandler.checkIfFileExists());
    Navigator.push(context,MaterialPageRoute(builder: (context) => LocatingScreen(fileHandler.checkIfFileExists())));
  }

  void useHomeLocation(){
    if(fileHandler.checkIfFileExists()){
       
          Map<String,dynamic> fileContent = fileHandler.readOutSetupFile(tempPath);      
          print(fileContent.toString());
          Map<String,dynamic> homeLocation = json.decode(fileContent["homeLocation"]).cast<String,double>();
          Navigator.push(context,MaterialPageRoute(builder: (context) => HomeScreen(homeLocation,false)));
    }else{
      print("Home Location Disabled");
    }
  }

}