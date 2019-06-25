import 'package:deepblue/new/userHandlingInterface/controller/registrationController.dart';
import 'package:deepblue/new/commonInterface/view/patterns/designPatterns.dart';
import 'package:flutter/material.dart';
class RegistrationView extends RegistrationScreenController {

  var step;
  RegistrationView(this.step);

  DesignPatterns designPatterns = new DesignPatterns();


  @override
  void initState() {
    // TODO: implement initState

    super.initState();
  }

  void dispose() {
    // Clean up the controller when the widget is disposed.
    emailController.dispose();
    passwordController.dispose();
    passwordReviewController.dispose();
    super.dispose();
  }
  

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
            child: getRegistrationWidgets(step),
          ),      
        ),

        
      ),

      bottomNavigationBar: designPatterns.bottomButtonWidget(registerNewAccount),

    ); 
  }

  Widget getRegistrationWidgets(step){
    
    if(step == "mail"){
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[

          Padding(
            padding: EdgeInsets.all(0),
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(
                  width: 2,
                  color: Colors.white,
                ),
                borderRadius: BorderRadius.circular(400),
              ),
              child: Icon(Icons.account_circle,color: Colors.white,size: 100),
            )
            
          ),
          
          Padding(
            padding: EdgeInsets.fromLTRB(30,20,30,20),
            child: Text(errorText,style: TextStyle(color: Colors.red, fontSize: 16),textAlign: TextAlign.center),
          ),

          Padding(
            padding: EdgeInsets.fromLTRB(30, 10, 30, 10),
            child: designPatterns.inputBoxWidget(inputText:"Email",obscureText: false,controller: emailController),
          ),          

          Padding(
            padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
            child: designPatterns.inputBoxWidget(inputText:"Password",obscureText: true,controller:passwordController),
          ),

          Padding(
            padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
            child: designPatterns.inputBoxWidget(inputText:"Password wiederholen",obscureText: true,controller:passwordReviewController),
          ),

          
        

        ],
      );
    }else if (step=="account"){

    }

  }


 
}