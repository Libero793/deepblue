import 'package:deepblue/new/view/startView.dart';
import 'package:flutter/cupertino.dart';

class StartScreen extends StatefulWidget {

  StartScreen();
  
  @override
  StartScreenView createState() => new StartScreenView();

}

abstract class StartScreenController extends State<StartScreen>{

  FocusNode focusTextWidget = new FocusNode();
  final textFieldController = TextEditingController();

  

}