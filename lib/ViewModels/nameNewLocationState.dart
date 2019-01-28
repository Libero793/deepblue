import 'dart:async';
import 'package:deepblue/ViewModels/registerNewLocationState.dart';
import 'package:deepblue/Views/nameNewLocationView.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating/flutter_rating.dart';

class NameNewLocation extends StatefulWidget{

   Map<String, double> pushedLocation;
   Map<String, double> currentLocation;
  NameNewLocation(this.pushedLocation, this.currentLocation);

  @override
  NameNewLocationView createState() => NameNewLocationView();

}

abstract class NameNewLocationState extends State<NameNewLocation>{


  Color menuBackgroundColor = Colors.blue[900];
  
  
  //_RegisterLocationScreen(this.pushedLocation);
  
  FocusNode focus = new FocusNode();
  final textFieldController = TextEditingController();
  

  @override
  void initState() {
    super.initState();
    focus.addListener(_onFocusChange);
  }

  void _onFocusChange(){
    debugPrint("Focus: "+focus.hasFocus.toString());
  }

  @override
  void dispose(){
    textFieldController.dispose();
    super.dispose();
  }

  void navigatorPushRegisterNewLocation(){
     Navigator.push(
      context, 
      MaterialPageRoute(builder: (context) => RegisterNewLocation(widget.pushedLocation,widget.currentLocation,textFieldController.text)),
    );
  }

 


}