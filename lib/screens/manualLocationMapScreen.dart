import 'dart:async';
import 'dart:convert';

import 'package:deepblue/ViewModels/homeScreenState.dart';
import 'package:deepblue/screens/locatingScreen.dart';
import 'package:deepblue/screens/nameNewLocation.dart';
import 'package:deepblue/screens/registerLocationScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';
import 'package:location/location.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;


class manualLocationMapScreen extends StatefulWidget {
  @override

  _manualLocationMapScreenState createState() => new _manualLocationMapScreenState();
  
  
}

class _manualLocationMapScreenState extends State<manualLocationMapScreen>{


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

  
  void _showDialog(context){
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
 
  
  @override
  Widget build(BuildContext context) {

     
    _handleTap(LatLng latlng){
      setState(() {
        addLocation(latlng);
        //addMode = true;
      });
    }

    return new Scaffold(
        key: _scaffoldKey,
        backgroundColor: Colors.blue[900],
        appBar: new AppBar(
          title: new Text(headlineText, style: TextStyle(fontSize: 16.0),),
          backgroundColor: Colors.blue[900],
          centerTitle: true,
          leading: new IconButton(
            icon: new Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
              //Navigator.push(context, MaterialPageRoute(builder: (context) => LocatingScreen()),);
            },
          ),
        ),

        body: new FlutterMap(
          options: new MapOptions(
            center: new LatLng(51.378956, 10.672253),
            zoom: 6.0,
            onTap: _handleTap,
          ),
          layers: [
            new TileLayerOptions(
              urlTemplate: "https://api.tiles.mapbox.com/v4/"
                  "{id}/{z}/{x}/{y}@2x.png?access_token={accessToken}",
              additionalOptions: {
                'accessToken': 'pk.eyJ1IjoibGliZXJvOTMiLCJhIjoiY2ptNmtpNWJ0MGx0ZzNrbjNpMG45M2YxdiJ9.meI1vzcg8VkYPRUPizn6qw',
                'id': 'mapbox.streets',
              },
            ),
            new MarkerLayerOptions(markers: markers),
          ],
        ),

        bottomSheet: new Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container ( 
                  height: 70.0,
                  decoration: new BoxDecoration(
                    color: Colors.transparent,
                  ),
                  child:new Container (
                    decoration: new BoxDecoration(
                      color: Colors.blue[900],
                      borderRadius: new BorderRadius.only(
                        topLeft: const Radius.circular(10.0),
                        topRight: const Radius.circular(10.0),
                        bottomLeft: const Radius.circular(10.0),
                        bottomRight: const Radius.circular(10.0)
                      )
                    ),
                  
                  child:new Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 0.0),
                    child: new Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                                           
                                    Container(
                                      width: 200.0,
                                      child:new Padding(
                                          padding: const EdgeInsets.fromLTRB(0.0,0.0,10.0,0.0),
                                          child: Text("Wähle deine Position auf der Karte aus, um fortzufahren", 
                                            style: TextStyle(fontSize: 14.0, color: Colors.white),
                                            textAlign: TextAlign.left,
                                          ),
                                        ),
                                    ),


                                      new Padding(
                                        padding: const EdgeInsets.fromLTRB(0.0,0.0,0.0,0.0),
                                        child: new RaisedButton(
                                              
                                          child: const Text('Weiter'),
                                            color: Colors.white,
                                            textColor: Colors.blue[900],
                                            splashColor: Colors.blue[900],
                                            padding: EdgeInsets.symmetric(vertical: 10.0,horizontal: 30.0),
                                            onPressed: () {
                                                if(pointTapped){
                                                  Navigator.pop(context);
                                                  Navigator.push(context,MaterialPageRoute(builder: (context) => HomeScreen(selectedLocation)));  
                                                }else{
                                                  _showDialog(context);
                                                }                              
                                              },
                                            ),
                                      ),
                                                                      
                        ],
                      )
                    )
                  ) 
                )
              ),                             
        );     

  }

}
