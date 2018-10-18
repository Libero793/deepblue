import 'package:flutter/material.dart';
import 'package:latlong/latlong.dart';


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

  void toggleSwitch(bool e, String val){
    setState((){
          if(val=="hochdruckReiniger"){
            if(e){
              hochdruckReiniger=true;
            }else{
              hochdruckReiniger=false;
            }
          }else if(val == "schaumBuerste"){
            if(e){
              schaumBuerste=true;
            }else{
              schaumBuerste=false;
            }
          }
      
    });
  }

  /*void setBackgroundColorMenu(Color backgroundColor){
    this.menuBackgroundColor = backgroundColor;
  }*/
  
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
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
                                      border: new Border(bottom: BorderSide(color: Colors.blueGrey)),
                                    ),
                      child:  Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 16.0,vertical: 10.0),
                                child:    Row(
                                                    crossAxisAlignment: CrossAxisAlignment.center,
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    mainAxisSize: MainAxisSize.max,
                                                    children: <Widget>[
                                                                        Padding(
                                                        padding: const EdgeInsets.all(8.0),
                                                        child: new Text("Hochdruckreinige vorhanden", style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16.0, color: Colors.white),)    
                                                      ),
                                                      Padding(
                                                        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical:0.0),
                                                        child: Switch(
                                                              value: hochdruckReiniger,
                                                              onChanged: (bool e) => toggleSwitch(e, 'hochdruckReiniger'),
                                                              activeColor: Colors.white,
                                                            ), 
                                                      ),

                                                    ],
                                                  )    
                              ),
            ),  



            Container(
                       decoration:  new BoxDecoration(
                                      border: new Border(bottom: BorderSide(color: Colors.blue[700])),
                                    ),
                      child:  Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 16.0,vertical: 10.0),
                                child:    Row(
                                                    crossAxisAlignment: CrossAxisAlignment.center,
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    mainAxisSize: MainAxisSize.max,
                                                    children: <Widget>[
                                                                        Padding(
                                                        padding: const EdgeInsets.all(8.0),
                                                        child: new Text("Schaumbürste vorhanden", style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16.0, color: Colors.white),)    
                                                      ),
                                                      Padding(
                                                        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical:0.0),
                                                        child: Switch(
                                                              value: schaumBuerste,
                                                              onChanged: (bool e) => toggleSwitch(e, 'schaumBuerste'),
                                                              activeColor: Colors.white,
                                                            ), 
                                                      ),

                                                    ],
                                                  )    
                              ),
            ), 

            Container(
                       decoration:  new BoxDecoration(
                                      border: new Border(bottom: BorderSide(color: Colors.blue[700])),
                                    ),
                      child:  Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 16.0,vertical: 10.0),
                                child:    Row(
                                                    crossAxisAlignment: CrossAxisAlignment.center,
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    mainAxisSize: MainAxisSize.max,
                                                    children: <Widget>[
                                                                        Padding(
                                                        padding: const EdgeInsets.all(8.0),
                                                        child: new Text("Schaumpistole vorhanden", style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16.0, color: Colors.white),)    
                                                      ),
                                                      Padding(
                                                        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical:0.0),
                                                        child: Switch(
                                                              value: schaumPistole,
                                                              onChanged: (bool e) => toggleSwitch(e, 'schaumPistole'),
                                                              activeColor: Colors.white,
                                                            ), 
                                                      ),

                                                    ],
                                                  )    
                              ),
            ), 

            Container(
                       decoration:  new BoxDecoration(
                                      border: new Border(bottom: BorderSide(color: Colors.blue[700])),
                                    ),
                      child:  Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 16.0,vertical: 10.0),
                                child:    Row(
                                                    crossAxisAlignment: CrossAxisAlignment.center,
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    mainAxisSize: MainAxisSize.max,
                                                    children: <Widget>[
                                                                        Padding(
                                                        padding: const EdgeInsets.all(8.0),
                                                        child: new Text("Fließend Wasser Vorhanden", style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16.0, color: Colors.white),)    
                                                      ),
                                                      Padding(
                                                        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical:0.0),
                                                        child: Switch(
                                                              value: fliessendWasser,
                                                              onChanged: (bool e) => toggleSwitch(e, 'fliessendWasser'),
                                                              activeColor: Colors.white,
                                                            ), 
                                                      ),

                                                    ],
                                                  )    
                              ),
            ), 

            Container(
                      child:  Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 16.0,vertical: 10.0),
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
                                                        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical:0.0),
                                                        child: Switch(
                                                              value: motorWaesche,
                                                              onChanged: (bool e) => toggleSwitch(e, 'motorWaesche'),
                                                              activeColor: Colors.white,
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
                          MaterialPageRoute(),
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