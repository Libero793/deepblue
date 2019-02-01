
import 'package:deepblue/ViewModels/locatingScreenState.dart';
import 'package:deepblue/Views/startScreenView.dart';
import 'package:deepblue/models/readFileModel.dart';
import 'package:flutter/material.dart';

class StartScreen extends StatefulWidget {

  @override
  StartScreenView createState() => new StartScreenView();

}

abstract class StartScreenState extends State<StartScreen> {

   String fileName = "deepblueSetup.json";
   ReadFile fileHandler = new ReadFile();
   Color homeLocationButtonColor = Colors.white;

  @override
  void initState(){
    super.initState();
    
    fileHandler.initFileDirectory(fileName);

    if(!fileHandler.checkIfFileExists(fileName)){
      setState(() {
        homeLocationButtonColor = Colors.grey[600];
      });
    }


  }

  void useCurrentLocation(){
    Navigator.push(context,MaterialPageRoute(builder: (context) => LocatingScreen()));
  }

  void useHomeLocation(){
    if(fileHandler.checkIfFileExists(fileName)){
      print("push to Home Location");
    }else{
      print("Home Location Disabled");
    }
  }

}