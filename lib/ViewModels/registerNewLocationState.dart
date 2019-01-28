import 'dart:async';
import 'package:deepblue/ViewModels/confirmLocationRegistrationState.dart';
import 'package:flutter/services.dart';
import 'package:flutter_udid/flutter_udid.dart';
import 'package:flutter/material.dart';
import 'package:deepblue/models/RegisterLocationModel.dart';
import 'package:http/http.dart' as http;
import 'package:deepblue/Views/registerNewLocationView.dart';


class RegisterNewLocation extends StatefulWidget{

  Map<String, double> pushedLocation;
  Map<String, double> currentLocation;
  String locationName;
  RegisterNewLocation(this.pushedLocation,this.currentLocation,this.locationName);

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
  RegisterLocationModel registerModel = RegisterLocationModel(false, false, false, false, false);
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

              registerModel.setHochdruckReiniger(hochdruckReiniger);

            }else if(val == "schaumBuerste"){
              if(e){
                schaumBuerste=true;
              }else{
                schaumBuerste=false;
              }

              registerModel.setSchaumBuerste(schaumBuerste);

            }else if(val == "schaumPistole"){
              if(e){
                schaumPistole=true;
              }else{
                schaumPistole=false;
              }

              registerModel.setSchaumPistole(schaumPistole);

            }else if(val == "fliessendWasser"){
              if(e){
                fliessendWasser=true;
              }else{
                fliessendWasser=false;
              }

              registerModel.setFliessendWasser(fliessendWasser);

            }else if(val == "motorWaesche"){
              if(e){
                motorWaesche=true;
              }else{
                motorWaesche=false;
              }

              registerModel.setMotorWaesche(motorWaesche);

            }
        
      });
    }
  }

  /*void setBackgroundColorMenu(Color backgroundColor){
    this.menuBackgroundColor = backgroundColor;
  }*/
  
   void httpRequest()async {

    var url = "http://www.nell.science/deepblue/index.php";

    http.post(url, body: {"registerNewWashingLocation":"true",
                          "key": "0", 
                          "latitude": widget.pushedLocation['latitude'].toString(), 
                          "longitude": widget.pushedLocation['longitude'].toString(),
                          "hochdruckReiniger": registerModel.getHochdruckReiniger().toString(), 
                          "schaumBuerste": registerModel.getSchaumBuerste().toString(),
                          "schaumPistole": registerModel.getSchaumPistole().toString(),
                          "fliessendWasser": registerModel.getFliessendWasser().toString(),
                          "motorWaesche": registerModel.getMotorWaesche().toString(),
                          "nameWaschbox": widget.locationName.toString(),
                          "udid": finudid.toString(),
                          
                          })
        .then((response) {
      print("Response status: ${response.statusCode}");   
      print("Response body: ${response.body}");
      print("httpreq");

      if(response.statusCode == 200){
        Navigator.pop(context);
        Navigator.push(
                          context, 
                          MaterialPageRoute(builder: (context) => ConfirmLocationRegistration(widget.currentLocation)),
                        );
      }else{
        print("location registration failed");
      }

    });
    
  }


}