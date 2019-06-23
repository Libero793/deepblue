import 'package:deepblue/new/view/registrationView.dart';
import 'package:deepblue/new/view/startView.dart';
import 'package:flutter/cupertino.dart';

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
    }
    
  }
  

}