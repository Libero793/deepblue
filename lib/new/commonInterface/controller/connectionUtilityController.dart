
import 'package:deepblue/new/commonInterface/model/connectionHandler.dart';
import 'package:deepblue/new/userHandlingInterface/model/userRegistrationModel.dart';
import 'package:deepblue/new/commonInterface/view/connectionUtilityView.dart';
import 'package:flutter/cupertino.dart';

class ConnectionUtility extends StatefulWidget {
  UserRegistrationModel userData = new UserRegistrationModel();
  ConnectionUtility(this.userData);

  @override
  ConnectionUtilityScreen createState() => new ConnectionUtilityScreen();

}

abstract class ConnectionUtilityController extends State<ConnectionUtility>{

  registerNewUser(){
    ConnectionHandler connection = new ConnectionHandler();
    var json = {"registerNewUser":"true","key": "0","email":widget.userData.mail,"password":widget.userData.password};
    connection.httpRequest(json);
  }

}