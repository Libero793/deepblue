import 'dart:async';
import 'package:deepblue/ViewModels/homeScreenState.dart';
import 'package:deepblue/models/CoreFunctionsModel.dart';
import 'package:deepblue/models/RegisterNewLocationModel.dart';
import 'package:flutter/services.dart';
import 'package:flutter_udid/flutter_udid.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:deepblue/Views/safeNewLocationView.dart';


class SafeNewLocation extends StatefulWidget{

  CoreFunctionsModel coreClass;
  RegisterNewLocationModel registerLocationClass;
  SafeNewLocation(this.registerLocationClass, this.coreClass);

  @override
  SafeNewLocationView createState() => SafeNewLocationView();

}

abstract class SafeNewLocationState extends State<SafeNewLocation>{

  Color menuBackgroundColor = Colors.blue[900];

  Future httpReturn;  
  String finudid;
  


   void initState() {
    super.initState();
    initPlatformState();
    httpRequest();
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

  
   void httpRequest()async {

    var url = "https://www.nell.science/deepblue/index.php";
    String base64Image;

    if(widget.registerLocationClass.locationBase64Image != null){
      base64Image = widget.registerLocationClass.locationBase64Image;
    }else{
      base64Image ="empty";
    }

    print("LocationType: ${widget.registerLocationClass.locationType}");
    print("image: $base64Image");
  

    print(widget.registerLocationClass.getLocation()['latitude'].toString());
    print(widget.registerLocationClass.getLocation()['longitude'].toString());
    print(widget.registerLocationClass.hochdruckReiniger.toString());
    print(widget.registerLocationClass.schaumBuerste.toString());
    print(widget.registerLocationClass.schaumPistole.toString());
    print(widget.registerLocationClass.fliessendWasser.toString());
    print(widget.registerLocationClass.motorWaesche.toString());
    print(widget.registerLocationClass.getLocationName().toString());
    print(finudid.toString());

    http.post(url, body: {"registerNewLocation":"true",
                          "key": "0", 
                          "locationType" : widget.registerLocationClass.locationType,
                          "latitude": widget.registerLocationClass.getLocation()['latitude'].toString(), 
                          "longitude": widget.registerLocationClass.getLocation()['longitude'].toString(),
                          "base64Image" : base64Image,
                          "hochdruckReiniger": widget.registerLocationClass.hochdruckReiniger.toString(), 
                          "schaumBuerste": widget.registerLocationClass.schaumBuerste.toString(),
                          "schaumPistole": widget.registerLocationClass.schaumPistole.toString(),
                          "fliessendWasser": widget.registerLocationClass.fliessendWasser.toString(),
                          "motorWaesche": widget.registerLocationClass.motorWaesche.toString(),
                          "nameWaschbox": widget.registerLocationClass.getLocationName().toString(),
                          "udid": finudid.toString(),
                          
                          })
        .then((response) {
      print("register Response status: ${response.statusCode}");   
      print("Response body: ${response.body}");
      print("httpreq");
      
      if(response.statusCode == 200){
       
      }else{
        print("location registration failed");
      }

    });
    
  }

  void navigatorPushToHomeScreen(){
                            Navigator.pop(context);
                         Navigator.push(
                          context, 
                          MaterialPageRoute(builder: (context) => HomeScreen(widget.coreClass)),
                        );
  }


}