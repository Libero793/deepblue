import 'dart:async';
import 'dart:convert';

import 'package:deepblue/ViewModels/homeScreenState.dart';
import 'package:deepblue/Views/manualLocationMapView.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';
import 'package:location/location.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;


class ManualLocationMap extends StatefulWidget {

  bool setAsHomeLocation;
  ManualLocationMap(this.setAsHomeLocation);

  @override
  ManualLocationMapView createState() => new ManualLocationMapView();
  
  
}

abstract class ManualLocationMapState extends State<ManualLocationMap>{


  bool pointTapped = false;
  String headlineText = "Kartenübersicht";
  double containerFloatingActionButtonHeight = 80.0;
  var markers = <Marker>[];

  Timer _reloadTimer;
  IconData actionButton = Icons.add;
  Color actionButtonColor = Colors.blue[900];
  Color actionButtonIconColor = Colors.white;

  var selectedLocation = <String,double> {};
  List<LatLng> tappedPoints = [];

  var washboxMap = null;
  bool showBoxInfo=false;
  


  final GlobalKey<ScaffoldState> _scaffoldKey = new 
        GlobalKey<ScaffoldState>();

    PersistentBottomSheetController controller;

  
  void doShowDialog(context){
    showDialog(
          context: context,
          builder: (BuildContext context) {
            // return object of type Dialog
            return AlertDialog(
              title: new Text("Bitte Standort wählen"),
              content: new Text("Du musst zuerst deinen Standort auf der Karte auswählen, bevor wir Waschboxen in deiner Nähe suchen können"),
              actions: <Widget>[
                // usually buttons at the bottom of the dialog
                new FlatButton(
                  child: new Text("Schliessen"),
                  onPressed:
                    ()=>Navigator.pop(context),
                ),
              ],
            );
          },
        );
  }

  void pushToHomeScreen(selectedLocation){
    Navigator.pop(context);
    Navigator.push(context,MaterialPageRoute(builder: (context) => HomeScreen(selectedLocation, widget.setAsHomeLocation)));  
  }


  void printWashboxesOnMap(var washboxMap){
    //print("${washboxMap[1]["latitude"]}");
    
    if(this.mounted){
      setState(() {
        for(int i=0;i<washboxMap.length;i++){
          print("$i");
          LatLng washbox = new LatLng(double.parse(washboxMap[i]["latitude"]),double.parse(washboxMap[i]["longitude"]));
          markers.add(
                new Marker(
                      width: 60.0,
                      height: 90.0,
                      point: washbox,
                      builder: (ctx) =>
                      new Container(
                          child: new GestureDetector(
                            onTap: (){
                                //_launchMaps("51.3703207","12.3652444");
                                //toggleBoxInfo("show",washboxMap[i]);
                            },
                            child: new Stack(
                            alignment: Alignment.topCenter,
                            overflow: Overflow.visible,
                            children: [
                                      new Positioned(
                                        top: 0.0,
                                        width: 60.0,
                                        height: 60.0,
                                            
                                            child: new Image.asset(
                                                'assets/images/locationWashbox.png',
                                                fit: BoxFit.cover,    
                                                ),
                                          ),                                                          
                                      ]
                            ),
                          )
                        ),
                      
                    )
          );
        }
      });
    }
    
  }

  
  void addLocation(latlng){
    
        print("tapped: $latlng");
        if(pointTapped){
          markers.removeLast();
        }
          markers.add(
            new Marker(
              width: 60.0,
              height: 60.0,
              point: latlng,
              builder: (ctx) =>
                  new GestureDetector(
                    onTap: (){
                           
                    },
                    child: new Container(
                      decoration: new BoxDecoration(
                        borderRadius: new BorderRadius.circular(0.0),
                        color: Colors.transparent,
                      ),
                      child: Column(
                        children: <Widget>[
                          Icon(Icons.my_location,color: Colors.blue[900],size: 60.0,),
                        ]
                      )
                      
                    ),
                  ),
            ),
          );
          
  
          
          
          setState(() {
            pointTapped = true;
            selectedLocation["longitude"] = latlng.longitude;
            selectedLocation["latitude"] = latlng.latitude;
          });
          
  }
 
  
 

}
