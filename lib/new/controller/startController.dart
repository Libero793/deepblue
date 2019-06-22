import 'package:deepblue/new/view/startView.dart';
import 'package:flutter/cupertino.dart';

class StartScreen extends StatefulWidget {

  StartScreen();
  
  @override
  StartScreenView createState() => new StartScreenView();

}

abstract class StartScreenController extends State<StartScreen>{

  FocusNode emailInputWidget = new FocusNode();
  final emailInputController = TextEditingController();

  
  FocusNode passwordInputWidget = new FocusNode();
  final passwortInputController = TextEditingController();


  fixSpacing(GlobalKey spacer){
     final RenderBox renderBoxRed = spacer.currentContext.findRenderObject();
     final sizeRed = renderBoxRed.size.height;   
     return sizeRed;
  }

  

}