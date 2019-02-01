
import 'package:deepblue/ViewModels/homeScreenState.dart';
import 'package:flutter/material.dart';
import 'package:deepblue/Views/confirmLocationRegistrationView.dart';


class ConfirmLocationRegistration extends StatefulWidget{

  Color menuBackgroundColor = Colors.blue[900];  
  Map <String, double> currentLocation;

  ConfirmLocationRegistration(this.currentLocation);

  @override
  ConfirmLocationRegistrationView createState() => ConfirmLocationRegistrationView();

}

abstract class ConfirmLocationRegistrationState extends State<ConfirmLocationRegistration>{

  void navigatorPushToHomeScreen(){
                            Navigator.pop(context);
                         Navigator.push(
                          context, 
                          MaterialPageRoute(builder: (context) => HomeScreen(widget.currentLocation,false)),
                        );
  }
   
  

}