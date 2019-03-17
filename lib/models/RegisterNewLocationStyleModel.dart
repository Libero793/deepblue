import 'package:flutter/material.dart';

class RegisterLocationBoxStyle {
  Color backgroundColor = Colors.white;
  Color textColor = Colors.grey[400];
  bool state = false;
  String option;
  String dataValue;

  
  switchState(Color color){
      
      state=!state;
      if(state){
        backgroundColor=color;
        textColor=Colors.white;
      }else{
        backgroundColor=Colors.white;
        textColor=Colors.grey[400];
      }
      
      return state;
  }

 
}