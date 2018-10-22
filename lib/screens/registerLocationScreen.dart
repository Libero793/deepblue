import 'package:deepblue/screens/submitNewLocation.dart';
import 'package:flutter/material.dart';
import 'package:latlong/latlong.dart';
import 'package:deepblue/models/RegisterLocationModel.dart';


class RegisterLocationScreen extends StatefulWidget{

  Map<String, double> _pushedLocation;
  RegisterLocationScreen(this._pushedLocation);

  @override
  _RegisterLocationScreen createState() => _RegisterLocationScreen(_pushedLocation);

}

class _RegisterLocationScreen extends State<RegisterLocationScreen>{

  Color menuBackgroundColor = Colors.blue[900];

  Map<String, double> pushedLocation;
  _RegisterLocationScreen(this.pushedLocation);

  

  bool hochdruckReiniger = false;
  bool schaumBuerste = false;
  bool schaumPistole = false;
  bool fliessendWasser = false;
  bool motorWaesche = false;
  RegisterLocationModel registerModel = RegisterLocationModel(false, false, false, false, false);

  void toggleSwitch(bool e, String val){
    if (this.mounted){
      setState((){
            if(val=="hochdruckReiniger"){
              if(e){
                hochdruckReiniger=true;
              }else{
                hochdruckReiniger=false;
              }

              registerModel.setHochdruckReiniger(hochdruckReiniger);

            }else if(val == "schaumBuerste"){
              if(e){
                schaumBuerste=true;
              }else{
                schaumBuerste=false;
              }

              registerModel.setSchaumBuerste(schaumBuerste);

            }else if(val == "schaumPistole"){
              if(e){
                schaumPistole=true;
              }else{
                schaumPistole=false;
              }

              registerModel.setSchaumPistole(schaumPistole);

            }else if(val == "fliessendWasser"){
              if(e){
                fliessendWasser=true;
              }else{
                fliessendWasser=false;
              }

              registerModel.setFliessendWasser(fliessendWasser);

            }else if(val == "motorWaesche"){
              if(e){
                motorWaesche=true;
              }else{
                motorWaesche=false;
              }

              registerModel.setMotorWaesche(motorWaesche);

            }
        
      });
    }
  }

  /*void setBackgroundColorMenu(Color backgroundColor){
    this.menuBackgroundColor = backgroundColor;
  }*/
  
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    //print(pushedLocation['latitude']);
    return Scaffold(
      backgroundColor: menuBackgroundColor,
      appBar: AppBar(
        title: Text(""),
        centerTitle: true,
        backgroundColor: menuBackgroundColor,
        elevation: 0.0,
      ),

      body: new Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[

            Row(),

            Padding(
              padding: const EdgeInsets.fromLTRB(36.0, 40.0, 36.0, 0.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text("Waschbox hinzufügen", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 26.0)),
                ],
              )
            ),

            Padding(
              padding: const EdgeInsets.fromLTRB(36.0, 10.0, 36.0, 80.0),
              child: Text("Bitte gib ein paar Details an, über die Waschbox die du hinzufügen möchtest", 
                        style: TextStyle(fontSize: 14.0, color: Colors.white),
                     ),
            
            ),


            Container(
              decoration:  new BoxDecoration(
                                border: new Border(bottom: BorderSide(color: Colors.indigo[800])),
                           ),
                           child:  Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 32.0,vertical: 10.0),
                                child:    Row(
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            mainAxisSize: MainAxisSize.max,
                                            children: <Widget>[
                                                      Padding(
                                                        padding: const EdgeInsets.all(8.0),
                                                        child: new Text("Hochdruckreiniger", style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16.0, color: Colors.white),)    
                                                      ),
                                                      Padding(
                                                        padding: const EdgeInsets.symmetric(horizontal: 0.0, vertical:0.0),
                                                        child: Theme(
                                                          data: ThemeData(
                                                              disabledColor: Colors.white,
                                                              unselectedWidgetColor: Colors.white,
                                                          ),
                                                          child: Checkbox(
                                                              
                                                              value: hochdruckReiniger,
                                                              onChanged: (bool e) => toggleSwitch(e, 'hochdruckReiniger'),
                                                              activeColor: Colors.blue[900],
                                                            ),
                                                        ),
                                                        
                                                      ),

                                                    ],
                                            )    
                            ),
            ),  



            Container(
                       decoration:  new BoxDecoration(
                                      border: new Border(bottom: BorderSide(color: Colors.indigo[800])),
                                    ),
                      child:  Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 32.0,vertical: 10.0),
                                child:    Row(
                                                    crossAxisAlignment: CrossAxisAlignment.center,
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    mainAxisSize: MainAxisSize.max,
                                                    children: <Widget>[
                                                                        Padding(
                                                        padding: const EdgeInsets.all(8.0),
                                                        child: new Text("Schaumbürste", style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16.0, color: Colors.white),)    
                                                      ),
                                                      Padding(
                                                        padding: const EdgeInsets.symmetric(horizontal: 0.0, vertical:0.0),
                                                        child: Theme(
                                                          data: ThemeData(
                                                              disabledColor: Colors.white,
                                                              unselectedWidgetColor: Colors.white,
                                                          ),
                                                          child: Checkbox(
                                                              
                                                              value: schaumBuerste,
                                                              onChanged: (bool e) => toggleSwitch(e, 'schaumBuerste'),
                                                              activeColor: Colors.blue[900],
                                                            ),
                                                        ),
                                                      ),

                                                    ],
                                                  )    
                              ),
            ), 

            Container(
                       decoration:  new BoxDecoration(
                                      border: new Border(bottom: BorderSide(color: Colors.indigo[800])),
                                    ),
                      child:  Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 32.0,vertical: 10.0),
                                child:    Row(
                                                    crossAxisAlignment: CrossAxisAlignment.center,
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    mainAxisSize: MainAxisSize.max,
                                                    children: <Widget>[
                                                                        Padding(
                                                        padding: const EdgeInsets.all(8.0),
                                                        child: new Text("Schaumpistole", style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16.0, color: Colors.white),)    
                                                      ),
                                                      Padding(
                                                        padding: const EdgeInsets.symmetric(horizontal: 0.0, vertical:0.0),
                                                        child: Theme(
                                                          data: ThemeData(
                                                              disabledColor: Colors.white,
                                                              unselectedWidgetColor: Colors.white,
                                                          ),
                                                          child: Checkbox(
                                                              
                                                              value: schaumPistole,
                                                              onChanged: (bool e) => toggleSwitch(e, 'schaumPistole'),
                                                              activeColor: Colors.blue[900],
                                                            ),
                                                        ), 
                                                      ),

                                                    ],
                                                  )    
                              ),
            ), 

            Container(
                       decoration:  new BoxDecoration(
                                      border: new Border(bottom: BorderSide(color: Colors.indigo[800])),
                                    ),
                      child:  Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 32.0,vertical: 10.0),
                                child:    Row(
                                                    crossAxisAlignment: CrossAxisAlignment.center,
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    mainAxisSize: MainAxisSize.max,
                                                    children: <Widget>[
                                                                        Padding(
                                                        padding: const EdgeInsets.all(8.0),
                                                        child: new Text("Fließend Wasser", style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16.0, color: Colors.white),)    
                                                      ),
                                                      Padding(
                                                        padding: const EdgeInsets.symmetric(horizontal: 0.0, vertical:0.0),
                                                        child: Theme(
                                                          data: ThemeData(
                                                              disabledColor: Colors.white,
                                                              unselectedWidgetColor: Colors.white,
                                                          ),
                                                          child: Checkbox(
                                                              
                                                              value: fliessendWasser,
                                                              onChanged: (bool e) => toggleSwitch(e, 'fliessendWasser'),
                                                              activeColor: Colors.blue[900],
                                                            ),
                                                        ),
                                                      ),

                                                    ],
                                                  )    
                              ),
            ), 

            Container(
          
                      child:  Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 32.0,vertical: 10.0),
                                child:    Row(
                                                    crossAxisAlignment: CrossAxisAlignment.center,
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    mainAxisSize: MainAxisSize.max,
                                                    children: <Widget>[
                                                                        Padding(
                                                        padding: const EdgeInsets.all(8.0),
                                                        child: new Text("Motorwäsche erlaubt", style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16.0, color: Colors.white),)    
                                                      ),
                                                      Padding(
                                                        padding: const EdgeInsets.symmetric(horizontal: 0.0, vertical:0.0),
                                                        child: Theme(
                                                          data: ThemeData(
                                                              disabledColor: Colors.indigo,
                                                              unselectedWidgetColor: Colors.white,
                                                              
                                                          ),
                                                          child: Checkbox(
                                                              
                                                              value: motorWaesche,
                                                              onChanged: (bool e) => toggleSwitch(e, 'motorWaesche'),
                                                              activeColor: Colors.blue[900],
                                                            
                                                            ),
                                                        ),
                                                      ),

                                                    ],
                                                  )    
                              ),
            ), 
            


            new Expanded(
              child: new Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  new Expanded(
                    child: new GestureDetector(
                      onTap:(){
                        Navigator.push(
                          context, 
                          MaterialPageRoute(builder: (context) => SubmitNewLocationScreen(registerModel,pushedLocation)),
                        );
                      },
                      child: new Container(
                        color: Colors.white,
                        height: 60.0,
                        child: new Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Text("Weiter",style: TextStyle(color: menuBackgroundColor, fontSize: 16.0, fontWeight: FontWeight.bold))
                        ],
                        ),
                      )
                    ) 
                  )
                ],
              )
            )
          ],
        ),
      ),
    );
  }

}