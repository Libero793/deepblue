import 'package:deepblue/screens/registerLocationSubScreens/setNewLocationScreen.dart';
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
              child: Text("Bitte Wähle aus um welche Art von Location es sich handelt, bei der Waschbox die du hinzufügen willst", 
                        style: TextStyle(fontSize: 14.0, color: Colors.white),
                     ),
            
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0,vertical: 20.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical:0.0),
                    child: new FloatingActionButton(
                      backgroundColor: Colors.white,
                      heroTag: null,
                      onPressed: () {},
                        child: Icon(
                          Icons.local_car_wash,
                          color: menuBackgroundColor,
                          size: 34.0,
                        )               
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: new Text("$pushedLocation", style: TextStyle(fontSize: 16.0, color: Colors.white),)    
                  ),
                ],
              )    
            ),  

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0,vertical: 20.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical:0.0),
                    child: new FloatingActionButton(
                      backgroundColor: Colors.white,
                      heroTag: null,
                      onPressed: () {},
                        child: Icon(
                          Icons.local_gas_station,
                          color: menuBackgroundColor,
                          size: 34.0,
                        )               
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: new Text("Tankstelle mit Waschboxen", style: TextStyle(fontSize: 16.0, color: Colors.white),)    
                  ),
                ],
              )    
            ),  



            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0,vertical: 20.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical:0.0),
                    child: new FloatingActionButton(
                      backgroundColor: Colors.white,
                      heroTag: null,
                      onPressed: () {},
                        child: Icon(
                          Icons.ev_station,
                          color: menuBackgroundColor,
                          size: 34.0,
                        )               
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: new Text("Ladestation mit Waschboxen", style: TextStyle(fontSize: 16.0, color: Colors.white),)    
                  ),
                ],
              )    
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
                          MaterialPageRoute(builder: (context) => SetNewLocationScreen()),
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