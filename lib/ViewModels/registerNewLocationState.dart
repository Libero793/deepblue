import 'dart:async';
import 'package:deepblue/ViewModels/confirmLocationRegistrationState.dart';
import 'package:deepblue/models/CoreFunctionsModel.dart';
import 'package:deepblue/models/RegisterNewLocationModel.dart';
import 'package:flutter/services.dart';
import 'package:flutter_udid/flutter_udid.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:deepblue/Views/registerNewLocationView.dart';


class RegisterNewLocation extends StatefulWidget{

  CoreFunctionsModel coreClass;
  RegisterNewLocationModel registerLocationClass;
  RegisterNewLocation(this.registerLocationClass, this.coreClass);

  @override
  RegisterNewLocationView createState() => RegisterNewLocationView();

}

abstract class RegisterNewLocationState extends State<RegisterNewLocation>{

  Color menuBackgroundColor = Colors.blue[900];

  Future httpReturn;
  String test;

  bool hochdruckReiniger = false;
  bool schaumBuerste = false;
  bool schaumPistole = false;
  bool fliessendWasser = false;
  bool motorWaesche = false;
  
  String finudid;
  


   void initState() {
    super.initState();
    initPlatformState();
  }

  Future<void> initPlatformState() async {
    String udid;
    try {
      udid = await FlutterUdid.consistentUdid;
    } on PlatformException {
      udid = 'Failed to get UDID.';
    }

    if (!mounted) return;

    setState(() {
      finudid = udid;
    });
  }


  void toggleSwitch(bool e, String val){
    if (this.mounted){
      setState((){
            if(val=="hochdruckReiniger"){
              if(e){
                hochdruckReiniger=true;
              }else{
                hochdruckReiniger=false;
              }

              widget.registerLocationClass.setHochdruckReiniger(hochdruckReiniger);

            }else if(val == "schaumBuerste"){
              if(e){
                schaumBuerste=true;
              }else{
                schaumBuerste=false;
              }

              widget.registerLocationClass.setSchaumBuerste(schaumBuerste);

            }else if(val == "schaumPistole"){
              if(e){
                schaumPistole=true;
              }else{
                schaumPistole=false;
              }

              widget.registerLocationClass.setSchaumPistole(schaumPistole);

            }else if(val == "fliessendWasser"){
              if(e){
                fliessendWasser=true;
              }else{
                fliessendWasser=false;
              }

              widget.registerLocationClass.setFliessendWasser(fliessendWasser);

            }else if(val == "motorWaesche"){
              if(e){
                motorWaesche=true;
              }else{
                motorWaesche=false;
              }

              widget.registerLocationClass.setMotorWaesche(motorWaesche);

            }
        
      });
    }
  }

  /*void setBackgroundColorMenu(Color backgroundColor){
    this.menuBackgroundColor = backgroundColor;
  }*/
  
   void httpRequest()async {

    var url = "http://www.nell.science/deepblue/index.php";

    print(widget.registerLocationClass.getLocation()['latitude'].toString());
    print(widget.registerLocationClass.getLocation()['longitude'].toString());
    print(widget.registerLocationClass.getHochdruckReiniger().toString());
    print(widget.registerLocationClass.getSchaumBuerste().toString());
    print(widget.registerLocationClass.getSchaumPistole().toString());
    print(widget.registerLocationClass.getFliessendWasser().toString());
    print(widget.registerLocationClass.getMotorWaesche().toString());
    print(widget.registerLocationClass.getLocationName().toString());
    print(finudid.toString());

    http.post(url, body: {"registerNewWashingLocation":"true",
                          "key": "0", 
                          "latitude": widget.registerLocationClass.getLocation()['latitude'].toString(), 
                          "longitude": widget.registerLocationClass.getLocation()['longitude'].toString(),
                          "hochdruckReiniger": widget.registerLocationClass.getHochdruckReiniger().toString(), 
                          "schaumBuerste": widget.registerLocationClass.getSchaumBuerste().toString(),
                          "schaumPistole": widget.registerLocationClass.getSchaumPistole().toString(),
                          "fliessendWasser": widget.registerLocationClass.getFliessendWasser().toString(),
                          "motorWaesche": widget.registerLocationClass.getMotorWaesche().toString(),
                          "nameWaschbox": widget.registerLocationClass.getLocationName().toString(),
                          "udid": finudid.toString(),
                          
                          })
        .then((response) {
      print("register Response status: ${response.statusCode}");   
      print("Response body: ${response.body}");
      print("httpreq");

      if(response.statusCode == 200){
        Navigator.pop(context);
        Navigator.push(
                          context, 
                          MaterialPageRoute(builder: (context) => ConfirmLocationRegistration(widget.coreClass)),
                        );
      }else{
        print("location registration failed");
      }

    });
    
  }


}