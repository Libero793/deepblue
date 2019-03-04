import 'package:flutter/material.dart';

class RegisterLocationBoxStyle {
  Color backgroundColor = Colors.white;
  Color textColor = Colors.grey;
  bool state = true;
  String option;

  
  switchState(){
    
      if(state){
        state=false;
      }else{
        state=true;
      }

      return state;
  }

 
}