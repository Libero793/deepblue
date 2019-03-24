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
import 'package:flutter_image_compress/flutter_image_compress.dart';
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
  bool hideSpacerWidget;

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
        hideSpacerWidget = true;

      }        
      break;

      case "washbox":{

        hideDateWidget=true;
        hideCheckboxWidget = false;
        hideSpacerWidget = true;

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
        hideSpacerWidget = false;
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
        FocusScope.of(context).requestFocus(new FocusNode());
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
    List <int> compressedImage;
    if(source == "gallery"){
      image = await ImagePicker.pickImage(source: ImageSource.gallery);
      compressedImage = await testCompressFile(image); 

    }else{
      image = await ImagePicker.pickImage(source: ImageSource.camera);
      compressedImage = await testCompressFile(image);
    }

    imageBytes = compressedImage;
    print(imageBytes);
    base64image = base64Encode(imageBytes);

    setState(() {
      locationImage = image;
      imageSelected = true;
      Navigator.pop(context);
    });

  }

   Future<List<int>> testCompressFile(File file) async {
    var result = await FlutterImageCompress.compressWithFile(
      file.absolute.path,
      minWidth: 600,
      minHeight: 400,
      quality: 94,
      rotate: 90,
    );
    print(file.lengthSync());
    print(result.length);
    return result;
  }


  void navigatorPushRegisterNewLocation(){
    var tempLocationName = textFieldController.text;
    if(tempLocationName.length > 30){
      tempLocationName = tempLocationName.substring(0,30);
    }

    if(tempLocationName.length >= 3){
      
      widget.registerLocationClass.locationName=tempLocationName;
      safeSelectedOptions();

      Navigator.push(
        context, 
        MaterialPageRoute(builder: (context) => SafeNewLocation(widget.registerLocationClass,widget.coreClass)),
      );

    }else{
      alertDialog("Location Name ungütlig", "Bitte gib deiner Location einen Namen, damit wir diese speichern können. Der Name muss mindestens aus 3 Buchstaben bestehen");
    }
   
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

        FocusScope.of(context).requestFocus(new FocusNode());
           // print(style.switchState());
            
      });
    }
  }

  void alertDialog(title,text){
     showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text(title),
          content: new Text(text),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("schließen"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }




 


}