
import 'package:deepblue/ViewModels/homeScreenState.dart';
import 'package:deepblue/models/CoreFunctionsModel.dart';
import 'package:flutter/material.dart';
import 'package:deepblue/Views/confirmLocationRegistrationView.dart';


class ConfirmLocationRegistration extends StatefulWidget{

  Color menuBackgroundColor = Colors.blue[900];  
  Map <String, double> currentLocation;
  CoreFunctionsModel coreClass;

  ConfirmLocationRegistration(this.coreClass);

  @override
  ConfirmLocationRegistrationView createState() => ConfirmLocationRegistrationView();

}

abstract class ConfirmLocationRegistrationState extends State<ConfirmLocationRegistration>{

  void navigatorPushToHomeScreen(){
                            Navigator.pop(context);
                         Navigator.push(
                          context, 
                          MaterialPageRoute(builder: (context) => HomeScreen(widget.coreClass)),
                        );
  }
   
  

}