import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:deepblue/ViewModels/safeNewLocationState.dart';
import 'package:deepblue/Views/registerNewLocationView.dart';
import 'package:deepblue/models/CoreFunctionsModel.dart';
import 'package:deepblue/models/RegisterNewLocationStyleModel.dart';
import 'package:deepblue/models/RegisterNewLocationModel.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class RegisterNewLocation extends StatefulWidget{

  RegisterNewLocationModel registerLocationClass;
  CoreFunctionsModel coreClass;

  RegisterNewLocation(this.registerLocationClass, this.coreClass);

  @override
  RegisterNewLocationView createState() => RegisterNewLocationView();

}

abstract class RegisterNewLocationState extends State<RegisterNewLocation>{


  Color menuBackgroundColor = Colors.blue[900];
  Color locationNameUnderlineColor = Colors.grey[400];
  Color locationNameIconColor = Colors.grey[400];
  bool locationNameFocused = false;

  bool hideSafeButton = false;
  bool imageSelected = false;


  Map <String,RegisterLocationBoxStyle> boxStyleMap;
  List <String> boxStyleEntrys = new List();

  List<int> imageBytes;
  String base64image;
  File locationImage;

  String hintTextName;
  String locationType;

  bool hideDateWidget;
  bool hideCheckboxWidget;

  double lowerSlideValue = 0;
  double upperSlideValue = 50;

  
  
  //_RegisterLocationScreen(this.pushedLocation);
  
  FocusNode focusTextWidget = new FocusNode();
  final textFieldController = TextEditingController();
  


  @override
  void initState() {
    super.initState();
    focusTextWidget.addListener(_onFocusChange);
    locationImage = null;

    locationType = widget.registerLocationClass.locationType;
    boxStyleMap = new Map();

    switch (locationType) {
      case "event" :{

        hintTextName = "Event Name";
        hideDateWidget = false;
        hideCheckboxWidget = true;

      }        
      break;

      case "washbox":{

        hideDateWidget=true;
        hideCheckboxWidget = false;

        hintTextName = "Location Name";
        boxStyleEntrys.add("Hochdruckreiniger");
        boxStyleEntrys.add("Schaumbürste");
        boxStyleEntrys.add("Schaumpistole");
        boxStyleEntrys.add("Wasser");
        boxStyleEntrys.add("Motor Wäsche");
        

        for(var i=0;i<boxStyleEntrys.length;i++){
          boxStyleMap["${boxStyleEntrys[i]}"]=new RegisterLocationBoxStyle();
          boxStyleMap["${boxStyleEntrys[i]}"].option=boxStyleEntrys[i];
        }

      }
      break;

      case "shooting":{
        hideDateWidget=true;
        hideCheckboxWidget = true;
        hintTextName = "Location Name";

      }
      break;

      default:
    }

  }

  void _onFocusChange(){
    debugPrint("Focus: "+focusTextWidget.hasFocus.toString());
    if(!locationNameFocused){
      setState(() {
      locationNameUnderlineColor = widget.coreClass.getColorSheme(locationType);
      locationNameIconColor = widget.coreClass.getColorSheme(locationType);
      locationNameFocused = true;
      hideSafeButton = true;
      });
    }else{
      setState(() {
        locationNameUnderlineColor = Colors.grey[400];
        locationNameIconColor = Colors.grey[400];
        locationNameFocused = false;
        hideSafeButton = false;
      });
    }

  }

  @override
  void dispose(){
    textFieldController.dispose();
    super.dispose();
  }


  Future getImage(source) async {
    var image;
    if(source == "gallery"){
      image = await ImagePicker.pickImage(source: ImageSource.gallery);
    }else{
      image = await ImagePicker.pickImage(source: ImageSource.camera);
    }

    imageBytes = image.readAsBytesSync();
    print(imageBytes);
    base64image = base64Encode(imageBytes);

    setState(() {
      locationImage = image;
      imageSelected = true;
      Navigator.pop(context);
    });

  }


  void navigatorPushRegisterNewLocation(){
    widget.registerLocationClass.setLocationName(textFieldController.text);
    safeSelectedOptions();
    Navigator.push(
      context, 
      MaterialPageRoute(builder: (context) => SafeNewLocation(widget.registerLocationClass,widget.coreClass)),
    );
  }

  void safeSelectedOptions(){

    widget.registerLocationClass.locationBase64Image = base64image;
    for(int i=0;i<boxStyleEntrys.length;i++){
      switch (boxStyleMap["${boxStyleEntrys[i]}"].option) {
        case "Hochdruckreiniger": 
          widget.registerLocationClass.hochdruckReiniger=boxStyleMap["${boxStyleEntrys[i]}"].state;
          break;
        case "Schaumbürste":
          widget.registerLocationClass.schaumBuerste=boxStyleMap["${boxStyleEntrys[i]}"].state;
          break;
        case "Schaumpistole":
          widget.registerLocationClass.schaumPistole=boxStyleMap["${boxStyleEntrys[i]}"].state;
          break;
        case "Wasser":
          widget.registerLocationClass.fliessendWasser=boxStyleMap["${boxStyleEntrys[i]}"].state;
          break;
        case "Motor Wäsche":
          widget.registerLocationClass.motorWaesche=boxStyleMap["${boxStyleEntrys[i]}"].state;
          break;
        default:
      }
      
    }
  }

  void toggleSwitch(bool e, RegisterLocationBoxStyle styleObject){
    if (this.mounted){
      setState((){
            styleObject.switchState(widget.coreClass.getColorSheme(locationType));
           // print(style.switchState());
            
      });
    }
  }




 


}