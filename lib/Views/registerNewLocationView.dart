import 'package:deepblue/ViewModels/registerNewLocationState.dart';
import 'package:flutter/material.dart';

class RegisterNewLocationView extends RegisterNewLocationState{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    print(widget.registerLocationClass.toString());
    print("uid: $finudid");
    return Scaffold(
      backgroundColor: widget.coreClass.getHighlightColor(),
      appBar: AppBar(
        title: Text(""),
        centerTitle: true,
        backgroundColor: widget.coreClass.getHighlightColor(),
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
                                border: new Border(bottom: BorderSide(color: Colors.blue[100])),
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
                                                              activeColor: widget.coreClass.getHighlightColor(),
                                                            ),
                                                        ),
                                                        
                                                      ),

                                                    ],
                                            )    
                            ),
            ),  



            Container(
                       decoration:  new BoxDecoration(
                                      border: new Border(bottom: BorderSide(color: Colors.blue[100])),
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
                                                              activeColor: widget.coreClass.getHighlightColor(),
                                                            ),
                                                        ),
                                                      ),

                                                    ],
                                                  )    
                              ),
            ), 

            Container(
                       decoration:  new BoxDecoration(
                                      border: new Border(bottom: BorderSide(color: Colors.blue[100])),
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
                                                              activeColor: widget.coreClass.getHighlightColor(),
                                                            ),
                                                        ), 
                                                      ),

                                                    ],
                                                  )    
                              ),
            ), 

            Container(
                       decoration:  new BoxDecoration(
                                      border: new Border(bottom: BorderSide(color: Colors.blue[100])),
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
                                                              activeColor: widget.coreClass.getHighlightColor(),
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
                                                              activeColor: widget.coreClass.getHighlightColor(),
                                                            
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
                       httpRequest();
                      },
                      child: new Container(
                        color: Colors.white,
                        height: 60.0,
                        child: new Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Text("Weiter",style: TextStyle(color: widget.coreClass.getHighlightColor(), fontSize: 16.0, fontWeight: FontWeight.bold))
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