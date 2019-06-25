import 'package:deepblue/new/commonInterface/controller/connectionUtilityController.dart';
import 'package:deepblue/new/userHandlingInterface/model/userRegistrationModel.dart';
import 'package:deepblue/new/userHandlingInterface/view/registrationView.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RegistrationScreen extends StatefulWidget {

  var step;
  RegistrationScreen(this.step);
  
  @override
  RegistrationView createState() => new RegistrationView(step);

}

abstract class RegistrationScreenController extends State<RegistrationScreen>{

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final passwordReviewController = TextEditingController();
  String errorText = "";

  registerNewAccount(){
    print(emailController.text);
    
    if(emailController.text.length < 10){
      setState(() {
        errorText ="Die Emailadresse ist nicht gültig.";
      });
    }else if(passwordController.text.length < 6){
      setState(() {
        errorText ="Das Password muss mindestens 6 Zeichen lang sein.";
      });
    }else if(passwordController.text != passwordReviewController.text){
      setState(() {
        errorText ="Die beiden Passwörter stimmen nicht überein.";
      });
    }else{
      errorText="Valid!";
      
      UserRegistrationModel userData = new UserRegistrationModel();
      userData.mail=emailController.text;
      userData.password=passwordReviewController.text;

      Navigator.push(context,MaterialPageRoute(builder: (context) => ConnectionUtility(userData)));
    }
    
  }
  

}