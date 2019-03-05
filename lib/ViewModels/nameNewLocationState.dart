import 'dart:async';
import 'dart:io';
import 'package:deepblue/ViewModels/registerNewLocationState.dart';
import 'package:deepblue/Views/nameNewLocationView.dart';
import 'package:deepblue/models/CoreFunctionsModel.dart';
import 'package:deepblue/models/RegisterNewLocationStyleModel.dart';
import 'package:deepblue/models/RegisterNewLocationModel.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

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
  List <String> boxStyleEntrys = new List();

  File locationImage;

  Future getImage(source) async {
    var image;
    if(source == "gallery"){
      image = await ImagePicker.pickImage(source: ImageSource.gallery);
    }else{
      image = await ImagePicker.pickImage(source: ImageSource.camera);
    }
    

    setState(() {
      locationImage = image;
    });
  }

  
  
  //_RegisterLocationScreen(this.pushedLocation);
  
  FocusNode focusTextWidget = new FocusNode();
  final textFieldController = TextEditingController();
  


  @override
  void initState() {
    super.initState();
    focusTextWidget.addListener(_onFocusChange);

    boxStyleMap = new Map();
    boxStyleEntrys.add("Hochdruckreiniger");
    boxStyleEntrys.add("Schaumbürste");
    boxStyleEntrys.add("Schaumpistole");
    boxStyleEntrys.add("Wasser");
    boxStyleEntrys.add("Motor Wäsche");

    for(var i=0;i<boxStyleEntrys.length;i++){
      boxStyleMap["${boxStyleEntrys[i]}"]=new RegisterLocationBoxStyle();
      boxStyleMap["${boxStyleEntrys[i]}"].option=boxStyleEntrys[i];
    }

    /*
    boxStyleMap["Hochdruckreiniger"] = new RegisterLocationBoxStyle();
    boxStyleMap["Hochdruckreiniger"].option="Hochdruckreiniger";
    
    boxStyleMap["test"] = new RegisterLocationBoxStyle();
    boxStyleMap[1].option="test";
    */

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

    void toggleSwitch(bool e, RegisterLocationBoxStyle styleObject){
    if (this.mounted){
      setState((){
            styleObject.switchState(widget.coreClass.getHighlightColor());
           // print(style.switchState());
            
      });
    }
  }

 


}