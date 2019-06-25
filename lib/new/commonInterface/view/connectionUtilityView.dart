import 'package:deepblue/new/commonInterface/controller/connectionUtilityController.dart';
import 'package:flutter/material.dart';

class ConnectionUtilityScreen extends ConnectionUtilityController {
  @override
Widget build(BuildContext context) { 

    

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text("", style: TextStyle(color: Colors.black),),
        centerTitle: true,
        backgroundColor: Colors.black,
        elevation: 0.0,
        iconTheme: IconThemeData(
            color: Colors.white, //change your color here
        ),
      ),
      
      body: 
      Theme(
        data: ThemeData(
          hintColor: Colors.white,
          primaryColor: Colors.white,                     //input Box Außenfarbe
          accentColor: Colors.white,
        ),
        child: Container(
          width: MediaQuery.of(context).size.width,
          height:MediaQuery.of(context).size.height,
          child: SingleChildScrollView(
            child: GestureDetector(
              onTap: (){
                registerNewUser();
              },
              child: Container(
                width: 200,
                height: 300,
                color: Colors.red,
              ),
            )
          ),      
        ),

        
      ),
    ); 
  }
  
}