
import 'dart:async';
import 'package:deepblue/ViewModels/locatingScreenState.dart';
import 'package:flutter/material.dart';

class LocatingScreenView extends LocatingScreenState {
  @override
  Widget build(BuildContext context) {
  

  //getLocation();
  //getPosition();




    return Scaffold(
      backgroundColor: widget.coreClass.getHighlightColor(),
      appBar: AppBar(
        leading: Container(),
        title: Text(""),
        centerTitle: true,
        backgroundColor: widget.coreClass.getHighlightColor(),
        elevation: 0.0,
    ),




    body: new Center(
        child: Stack(        
            
          children: <Widget>[
             
          Column(
              mainAxisAlignment: MainAxisAlignment.start,
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
                                  padding: EdgeInsets.fromLTRB(40, 14, 40, 8),
                                  child:  Theme(
                                    data: new ThemeData(
                                      highlightColor: Colors.white,
                                      accentColor: Colors.grey,
                                    ),
                                    child: LinearProgressIndicator(
                                      valueColor: AlwaysStoppedAnimation(Colors.white),
                                      backgroundColor: Color(0xffc68100),
                                    ),
                                  )                       

                                ),
                              ],
                            ),
                          ),
                        ]
                      ),

                   
                     

                      Row(
                        children: <Widget>[
                            Expanded(
                              child:Padding(
                                padding: EdgeInsets.fromLTRB(40, 0, 40, 0),
                                child: Container(
                                  color: widget.coreClass.getHighlightColor(),
                                  height: 1.0,
                                )
                              )
                            ),
                        ],

                      ),



                      homeLocationWidget(),

                      

                      Container(
                        height: 60.0,
                      ),
                      
                      mapHintWidget(),

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
                                  Text("Karten Modus",style: TextStyle(color: widget.coreClass.getHighlightColor(), fontSize: 16.0, fontWeight: FontWeight.bold)),
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

  Widget mapHintWidget(){
    return  Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[

                Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 30.0),
                      child: AnimatedOpacity(
                        opacity: widget.coreClass.getManualMapHintStatus() ? 1 : 0,
                        duration: Duration(milliseconds: 500),
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.white, width: 2.0, ),
                            borderRadius: BorderRadius.all(Radius.circular(4.0)),
                            color: Colors.white,
                          ),
                          
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            mainAxisSize: MainAxisSize.max,
                            children: <Widget>[
                              
                              Padding(
                                padding: EdgeInsets.fromLTRB(20.0, 15, 0, 15),                   
                                child: Container(
                                  width: 210.0,
                                  color: Colors.transparent,
                                  child:new Padding(
                                    padding: const EdgeInsets.fromLTRB(0.0,0.0,0.0,0.0),
                                    child: Text("Verwende den Karten Modus, falls dein Standort über GPS nicht automatisch lokalisiert werden kann.", 
                                      style: TextStyle(fontSize: 12.0, color: widget.coreClass.getHighlightColor()),
                                      textAlign: TextAlign.left,
                                    ),
                                  ),
                                ),
                              ),
                              
                              GestureDetector(
                                onTap: (){
                                  hideHint();
                                },
                                child:Padding(
                                  padding: EdgeInsets.fromLTRB(10,0,10,0),
                                  child:Icon(Icons.close,size: 30.0,color: widget.coreClass.getHighlightColor()), 
                                )
                              )

                            ]
                          )
                        )
                      ) 
                    )            
                  
                )
                          
              ]
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
            padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 40.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[

               
                Container(
                    width: 25.0,
                    height: 25.0,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.white, width: 2.0),
                      borderRadius: BorderRadius.all(Radius.circular(4.0)),
                    ),
                    child:  Theme(
                      data: ThemeData(
                        unselectedWidgetColor: widget.coreClass.getHighlightColor(),         
                      ),
                      child: Checkbox(                   
                        value: setAsHomeLocation,
                        onChanged: (bool e) => toggleHomeLocationBox(e),
                        activeColor: widget.coreClass.getHighlightColor(),
                      ),
                    ),          
                ),
                
                Padding(
                  padding: EdgeInsets.only(left: 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Icon(Icons.home, color: Colors.white),
                        
                      
                      Padding(
                          padding: const EdgeInsets.fromLTRB(10.0,0.0,0.0,0.0),
                          child: Text("Neuer Heimat Standort", 
                            style: TextStyle(fontSize: 18.0, color: Colors.white, fontWeight: FontWeight.normal),
                            textAlign: TextAlign.left,
                          ),
                        ),
                      
                    ],
                  )
                ),
                              
              ]
            )
          )
        )
      ]
    );

  }
}