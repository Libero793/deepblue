
import 'package:deepblue/ViewModels/startScreenState.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';


class StartScreenView extends StartScreenState {

  @override 
  
  Widget build(BuildContext context){

    return Scaffold(
      backgroundColor: Colors.blue,

      body: new Center(
              child: Stack(                
                children: <Widget>[

                 new Container(
                  decoration: new BoxDecoration(
                    image: new DecorationImage(
                      image: new AssetImage("assets/images/image3.jpg"),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.max,
                          children: <Widget>[
                            
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[

                                  Padding(
                                    padding: EdgeInsets.fromLTRB(30, 100, 30, 0.0),
                                    child: Column(
                                      children: <Widget>[

                                        Container(
                                          width: double.infinity,
                                          height: 90.0,
                                          child: SvgPicture.asset("assets/images/logo_3edit.svg"),
                                        ),

                                        Container(
                                          color: Colors.white,
                                          height: 3.0,
                                          width: double.infinity,
                                        ),
                                        
                                        Padding(
                                          padding: EdgeInsets.fromLTRB(0.0, 15.0, 0.0, 0.0),
                                          child:  Text("The best App for your lowered Lifestyle", style: TextStyle(fontSize: 16.5,color: Colors.white, fontWeight: FontWeight.bold,),),
                                        ),
                                       

                                      ],
                                    )
                                    
                                   
                                  ),
                                 
                                  Expanded(
                                    child: Container(),
                                  ),

                                  Padding(
                                    padding: EdgeInsets.fromLTRB(30, 0, 30, 20),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[

                                        new OutlineButton(
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: <Widget>[
                                              Padding(
                                                padding: EdgeInsets.fromLTRB(0, 0, 5, 0),
                                                child: Icon(Icons.location_on,color: Colors.white,),
                                              ),                               
                                              Text('Aktueller Standort', style: TextStyle(fontSize: 16.0),),
                                            ]                                                 
                                          ),      
                                          padding: EdgeInsets.fromLTRB(0.0, 10.0, 0, 10.0),
                                          color: Colors.white,
                                          textColor: Colors.white,
                                          splashColor: Colors.blue[900],
                                          onPressed: () {
                                                              
                                          },
                                        ),
                                        

                                        Padding(
                                          padding: EdgeInsets.symmetric(horizontal: 0.0,vertical:20.0),
                                          child:
                                          new Row(
                                            children: <Widget>[

                                              Expanded(
                                                child: Container(
                                                  color: Colors.white,
                                                  height: 1.0,
                                                ),
                                              ),
                                              
                                              Padding(
                                                padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 10.0),
                                                child: Text("ODER", style: TextStyle(fontSize: 14.0,color: Colors.white),),
                                              ),
                                              

                                              Expanded(
                                                child: Container(
                                                  color: Colors.white,
                                                  height: 1.0,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),

                                        new OutlineButton(  
                                          padding: EdgeInsets.fromLTRB(0.0, 10.0, 0, 10.0),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: <Widget>[
                                              Padding(
                                                padding: EdgeInsets.fromLTRB(0, 0, 5, 0),
                                                child: Icon(Icons.home,color: Colors.white,),
                                              ),                               
                                              Text('Heimat Standort', style: TextStyle(fontSize: 16.0),),
                                            ]                                                 
                                          ),                                                
                                          color: Colors.blue[900],
                                          highlightColor: Colors.green,
                                          textColor: Colors.white,
                                          splashColor: Colors.blue[900],
                                          onPressed: () {
                                          },
                                        ),
                              
                                      ],
                                    ),
                                  )


                                ],
                              )
                              
                              
                            ),

                          
                        
                      ]
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}