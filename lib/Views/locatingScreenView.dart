
import 'dart:async';
import 'package:deepblue/ViewModels/locatingScreenState.dart';
import 'package:flutter/material.dart';

class LocatingScreenView extends LocatingScreenState {
  @override
  Widget build(BuildContext context) {
  

  //getLocation();
  //getPosition();




    return Scaffold(
      backgroundColor: Colors.blue,
      appBar: AppBar(
        title: Text(""),
        centerTitle: true,
        backgroundColor: Colors.blue,
        elevation: 0.0,
    ),




    body: new Center(
        child: Stack(        
            
          children: <Widget>[
             
          Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[

                Expanded(
                  child: new Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      new Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Padding(
                                padding: const EdgeInsets.fromLTRB(0.0,0.0,0.0,20.0),
                                child: Icon(Icons.location_off, size: 100.0, color: Colors.white,),
                            ),
                          
                        ],  
                      ),

                      new Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Padding(
                                padding: const EdgeInsets.fromLTRB(0.0,20.0,0.0,10.0),
                                child: Text("Standort suche läuft ...", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 26.0,)),
                            ),
                            
                          
                        ],  
                      ),
                      new Row(
                        children: <Widget>[
                          new Flexible(
                            child:Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                new Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 48.0),
                                  child:  LinearProgressIndicator()                        

                                ),
                              ],
                            ),
                          ),
                        ]
                      ),

                      new Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.max,
                        children: <Widget>[
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 45.0),
                              child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  mainAxisSize: MainAxisSize.max,
                                  children: <Widget>[
                                    Icon(Icons.info_outline,size: 40.0,color: Colors.white),                     
                                    Container(
                                      width: 230.0,
                                      color: Colors.blue,
                                      child:new Padding(
                                          padding: const EdgeInsets.fromLTRB(20.0,0.0,0.0,0.0),
                                          child: Text("Verwende den Karten Modus, falls dein Standort über GPS nicht automatisch lokalisiert werden kann.", 
                                            style: TextStyle(fontSize: 12.0, color: Colors.white),
                                            textAlign: TextAlign.left,
                                          ),
                                        ),
                                    )
                                  ]
                                )
                            )
                            
                          )
                          
                        ]
                      ),

                      homeLocationWidget(),
                      
                    ],
                  )
                )
              ]
          ),
              
  
         
          new Column(
            children: <Widget>[
              Expanded(
                child: Container(
                  
                  child: new Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        new Expanded(
                          child: new GestureDetector(
                            
                            onTap:(){
                              pushToManualLocationMap();                                                   
                            },
                              child: new Container(
                                color: Colors.white,
                                height: 60.0,
                                child: new Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Text("Karten Modus",style: TextStyle(color: Colors.blue, fontSize: 16.0, fontWeight: FontWeight.bold)),
                                ],
                                ),
                              )
                            ) 
                          )
                        ],
                  )
                )
              )
            ]
          )
       

          ],
        ),
      ),
    );

      
  }

  Widget homeLocationWidget(){
    
    return new Row(
      mainAxisAlignment: MainAxisAlignment.end,
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 45.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[

                Padding(
                  padding: EdgeInsets.fromLTRB(5, 0, 25, 0),
                  child: Container(
                    width: 30.0,
                    height: 30.0,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.white, width: 2.0),
                      borderRadius: BorderRadius.all(Radius.circular(4.0)),
                    ),
                    child:  Theme(
                      data: ThemeData(
                        unselectedWidgetColor: Colors.blue,         
                      ),
                      child: Checkbox(                   
                        value: setAsHomeLocation,
                        onChanged: (bool e) => toggleHomeLocationBox(e),
                        activeColor: Colors.blue,
                      ),
                    ),          
                  ),
                ),

                Icon(Icons.home, color: Colors.white),
                      
                Expanded(
                  child:new Padding(
                    padding: const EdgeInsets.fromLTRB(10.0,0.0,0.0,0.0),
                    child: Text("Neuer Heimat Standort", 
                      style: TextStyle(fontSize: 16.0, color: Colors.white, fontWeight: FontWeight.normal),
                      textAlign: TextAlign.left,
                    ),
                  ),
                )
              
              ]
            )
          )
        )
      ]
    );

  }
}