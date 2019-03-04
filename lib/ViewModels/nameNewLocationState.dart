import 'dart:async';
import 'package:deepblue/ViewModels/registerNewLocationState.dart';
import 'package:deepblue/Views/nameNewLocationView.dart';
import 'package:deepblue/models/CoreFunctionsModel.dart';
import 'package:deepblue/models/RegisterLocationStyleModel.dart';
import 'package:deepblue/models/RegisterNewLocationModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating/flutter_rating.dart';

class NameNewLocation extends StatefulWidget{

  RegisterNewLocationModel registerLocationClass;
  CoreFunctionsModel coreClass;

  NameNewLocation(this.registerLocationClass, this.coreClass);

  @override
  NameNewLocationView createState() => NameNewLocationView();

}

abstract class NameNewLocationState extends State<NameNewLocation>{


  Color menuBackgroundColor = Colors.blue[900];
  Color locationNameUnderlineColor = Colors.grey[300];
  Color locationNameIconColor = Colors.grey[300];
  bool locationNameFocused = false;

  bool hochdruckReiniger = false;

  Map <String,RegisterLocationBoxStyle> boxStyleMap;

  
  
  //_RegisterLocationScreen(this.pushedLocation);
  
  FocusNode focusTextWidget = new FocusNode();
  final textFieldController = TextEditingController();
  

  @override
  void initState() {
    super.initState();
    focusTextWidget.addListener(_onFocusChange);

    boxStyleMap["Hochdruckreiniger"] = new RegisterLocationBoxStyle();
    boxStyleMap[0].option="Hochdruckreiniger";
    boxStyleMap["test"] = new RegisterLocationBoxStyle();
    boxStyleMap[1].option="test";


  }

  void _onFocusChange(){
    debugPrint("Focus: "+focusTextWidget.hasFocus.toString());
    if(!locationNameFocused){
      setState(() {
      locationNameUnderlineColor = widget.coreClass.getHighlightColor();
      locationNameIconColor = Colors.black;
      locationNameFocused = true;
      });
    }else{
      setState(() {
        locationNameUnderlineColor = Colors.grey[300];
        locationNameIconColor = Colors.grey[300];
        locationNameFocused = false;
      });
    }

  }

  @override
  void dispose(){
    textFieldController.dispose();
    super.dispose();
  }

  void navigatorPushRegisterNewLocation(){
    widget.registerLocationClass.setLocationName(textFieldController.text);
    Navigator.push(
      context, 
      MaterialPageRoute(builder: (context) => RegisterNewLocation(widget.registerLocationClass,widget.coreClass)),
    );
  }

    void toggleSwitch(bool e){
    if (this.mounted){
      setState((){

           // print(style.switchState());
            
      });
    }
  }

 


}