import 'dart:async';
import 'dart:convert';

import 'package:deepblue/ViewModels/homeScreenState.dart';
import 'package:deepblue/ViewModels/registerNewLocationState.dart';
import 'package:deepblue/Views/mapScreenView.dart';
import 'package:deepblue/models/CoreFunctionsModel.dart';
import 'package:deepblue/models/RegisterNewLocationModel.dart';
import 'package:deepblue/models/nearLocationsModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';
import 'package:location/location.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;


class MapScreen extends StatefulWidget {
  @override

  CoreFunctionsModel coreClass;
  NearLocations nearLocations;
  MapScreen(this.coreClass, this.nearLocations);

  MapScreenView createState() => new MapScreenView();
  
  
}

abstract class MapScreenState extends State<MapScreen>{



  bool addMode = false;
  bool addModeTapped = false;
  bool chooseLocationTapped = false;
  bool boxInfoToggled = false;
  String addLocationType;
  String headlineText = "Kartenübersicht";
  double containerFloatingActionButtonHeight = 65.0;
  var markers = <Marker>[];

  Timer _reloadTimer;
  Color actionButtonColor;
  Color actionButtonIconColor = Colors.black;

  Map<String, double> registerLocation;
  List<LatLng> tappedPoints = [];

  var washboxMap = null;
  bool showBoxInfo=false;

  IconData actionButtonIcon;
  
  RegisterNewLocationModel registerLocationClass = new RegisterNewLocationModel();

  final GlobalKey<ScaffoldState> scaffoldKey = new 
        GlobalKey<ScaffoldState>();

    PersistentBottomSheetController controller;

  
  void initState(){
    actionButtonColor = Colors.white;
    actionButtonIcon = Icons.add;
    printOnMap(widget.nearLocations.washboxen, "Waschboxen", widget.coreClass.washboxColor);
    printOnMap(widget.nearLocations.events, "Events", widget.coreClass.eventColor);
    printOnMap(widget.nearLocations.shootings, "Shootings", widget.coreClass.shootingColor);
  }

  void navigatorPushToHomeScreen(){
    Navigator.pop(context);
    Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen(widget.coreClass)));
  }

  

  void printOnMap(var map,String type, Color iconColor){
    //print("${washboxMap[1]["latitude"]}");
    
    if(this.mounted){
      setState(() {
        for(int i=0;i<map.length;i++){
          print("$i");
          LatLng washbox = new LatLng(double.parse(map[i]["latitude"]),double.parse(map[i]["longitude"]));
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
                                toggleBoxInfo("show",map[i]);
                            },
                            child: new Stack(
                            alignment: Alignment.topCenter,
                            overflow: Overflow.visible,
                            children: [
                                      new Positioned(
                                        top: 0.0,
                                        width: 60.0,
                                        height: 60.0,
                                            
                                            child: Icon(Icons.place, color: iconColor, size: 60,),
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


  _launchMaps(lat,lng) async {

    print("launchMaps");
    String googleMapsAndroidUrl ='google.navigation:q=${lat},${lng}';
    String googleMapsIosUrl ='comgooglemaps://?q=<$lat>,<$lng>';
    String appleUrl = 'https://maps.apple.com/?sll=${lat},${lng}';

   
    /// Documentation :
    /// Google Maps in a browser: "http://maps.google.com/?q=<lat>,<lng>"
    /// Google Maps app on an iOS mobile device : "comgooglemaps://?q=<lat>,<lng>"
    /// Google Maps app on Android : "geo:<lat>,<lng>?z=<zoom>"
    /// You can also use "google.navigation:q=latitude,longitude"
    /// z is the zoom level (1-21) , q is the search query
    /// t is the map type ("m" map, "k" satellite, "h" hybrid, "p" terrain, "e" GoogleEarth)
    if (await canLaunch(googleMapsAndroidUrl)) {

      print('launching google Maps Android Navigation');
      await launch(googleMapsAndroidUrl);

    } else if (await canLaunch(googleMapsIosUrl)) {

      print('launching google Maps Ios Navigation');
      await launch(googleMapsIosUrl);

    } else if (await canLaunch(appleUrl)) {

      print('launching apple url');
      await launch(appleUrl);

    } else {
      throw 'Could not launch url';
    }

  }



  void actionButtonToggle(){
    if(boxInfoToggled){
      toggleBoxInfo("hide", null);
      boxInfoToggled = false;
    }else{
      if(!chooseLocationTapped){
        setState(() {
                chooseLocationTapped = true;
                containerFloatingActionButtonHeight=260;
                actionButtonColor = Colors.white;
                actionButtonIcon = Icons.close;
                actionButtonIconColor = Colors.black;
        });
      }else{
        setState(() {
          chooseLocationTapped = false;
          containerFloatingActionButtonHeight = 65;
          actionButtonColor = Colors.white;
          actionButtonIcon = Icons.add;
          actionButtonIconColor = Colors.black;
        });

      }
    }
    
  }

  void setAddLocationType(var type){
    addLocationType = type;
  }

  String getAddLocationType(){
    return addLocationType;
  }

  void toggleEditMode(){
    if(addMode){
      addMode=false;
      showHint("hide");
      if(addModeTapped){
        print("remove");
              setState(() {
                  markers.removeAt(markers.length-1);
                  addModeTapped=false;
              });
      }
      if (this.mounted){
        setState(() {
                headlineText="Kartenübersicht";
                containerFloatingActionButtonHeight = 290.0;
        });
      }

      print("addmode: off");
    }else{
      addMode=true;
      showHint("show");
      if (this.mounted){
        setState(() {
                headlineText="Location hinzufügen";
                containerFloatingActionButtonHeight = 0.0;
              });
      }
      
      LatLng handler = new LatLng(widget.coreClass.getSelectedLocation()['latitude'], widget.coreClass.getSelectedLocation()['longitude']);
      addLocation(handler); //initial cal for drawing thecurrent position cross
      print("addmode: on");
    }
  }
  
  void addLocation(latlng){
    
        print("mode: $addMode");
        print("tapped: $latlng");

        if(addMode){
          if(addModeTapped){
            print("remove");
            markers.removeAt(markers.length-1);

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
                          Icon(Icons.my_location,color: widget.coreClass.getColorSheme(addLocationType),size: 60.0,),
                        ]
                      )
                      
                    ),
                  ),
            ),
          );
          

           //     if (this.mounted){
         // setState(() {
            registerLocation["longitude"] = latlng.longitude;
            registerLocation["latitude"] = latlng.latitude;
            registerLocationClass.setLocation(registerLocation);
            registerLocationClass.setLocationType(getAddLocationType());

         // });}
          addModeTapped = true;
        }


  }

  void _showDialog(context){
    showDialog(
          context: context,
          builder: (BuildContext context) {
            // return object of type Dialog
            return AlertDialog(
              title: new Text("Alert Dialog title"),
              content: new Text("Alert Dialog body"),
              actions: <Widget>[
                // usually buttons at the bottom of the dialog
                new FlatButton(
                  child: new Text("Close"),
                  onPressed: () {
                    Navigator.pop(context);
                         Navigator.push(
                          context, 
                          MaterialPageRoute(builder: (context) => HomeScreen(widget.coreClass)),
                        );
                  },
                ),
              ],
            );
          },
        );
  }


  void showHint(action){
        ScaffoldState state = scaffoldKey.currentState;
        String addLocationTypeName;

        if(getAddLocationType() == "washbox"){
          addLocationTypeName = "eine Waschbox";
        }else if(getAddLocationType() == "shooting"){
          addLocationTypeName = "einen Foto Spot";
        }else if(getAddLocationType() == "event"){
          addLocationTypeName = "ein Event";
        }
        
        if(action == "show"){
          controller = state.showBottomSheet<Null>((BuildContext context) {
                           
                        return  Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container ( 
                                      height: 150.0,
                                      decoration: new BoxDecoration(
                                        color: Colors.transparent,
                                      ),
                                      child:new Container (
                                        decoration: new BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: new BorderRadius.only(
                                              topLeft: const Radius.circular(10.0),
                                              topRight: const Radius.circular(10.0),
                                              bottomLeft: const Radius.circular(10.0),
                                              bottomRight: const Radius.circular(10.0)
                                          )
                                        ),
                                        child: new Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: <Widget>[
                                            new Padding(
                                                padding: const EdgeInsets.all(16.0),
                                                child: new Text(
                                                          'Klick auf die Map '
                                                          'um $addLocationTypeName hinzuzufügen',
                                                          textAlign: TextAlign.center,style: TextStyle(fontSize: 18.0, color: Colors.black, fontWeight: FontWeight.w400)
                                                        )
                                            ),
                                            new Row(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              mainAxisSize: MainAxisSize.min,
                                              children: <Widget>[
                                                new OutlineButton(
                                                  child: const Text('Abbrechen'),
                                                  textColor: Colors.grey[300],
                                                  highlightedBorderColor: Colors.grey,
                                                  onPressed: () {
                                                    // Perform some action
                                                    toggleEditMode();
                                                  },
                                                ),

                                                new Padding(
                                                  padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0)
                                                ),

                                                new RaisedButton(
                                              
                                                  child: const Text('Weiter'),
                                                  color: widget.coreClass.getColorSheme(getAddLocationType()),
                                                  textColor: Colors.white,
                                                  padding: EdgeInsets.symmetric(vertical: 10.0,horizontal: 30.0),
                                                  onPressed: () {
                                                    // Perform some action
                                                    Navigator.push(context,MaterialPageRoute(builder: (context) => RegisterNewLocation(registerLocationClass,widget.coreClass)));
                                                  },
                                                ),
                                              ]
                                            )
                                            
          
                                        ],
                                      )
                                    ) 
                                  )
                          );                         
          },);
        }else if(action == "hide"){
          controller.close();
        }
   } 

   void toggleBoxInfo(action,washboxInfo){
        ScaffoldState state = scaffoldKey.currentState;
        
        
        
        if(action == "show" && !addMode){
            print(washboxInfo);
            if(this.mounted){
              setState(() {
                actionButtonToggle();
                actionButtonColor=widget.coreClass.washboxColor;
                actionButtonIcon = Icons.close;
                actionButtonIconColor = Colors.white;
                showBoxInfo=true;
                boxInfoToggled = true;
              });
            }
          controller = state.showBottomSheet<Null>((BuildContext context) {
                           
                        return  Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container ( 
                                      decoration: new BoxDecoration(
                                        color: Colors.transparent,
                                      ),
                                      child: new Container (
                                        decoration: new BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: new BorderRadius.only(
                                              topLeft: const Radius.circular(10.0),
                                              topRight: const Radius.circular(10.0),
                                              bottomLeft: const Radius.circular(10.0),
                                              bottomRight: const Radius.circular(10.0),
                                          )
                                        ),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: <Widget>[
                                            Padding(
                                            padding: const EdgeInsets.all(16.0),
                                            child:  new Column(
                                              mainAxisSize: MainAxisSize.min,
                                              mainAxisAlignment: MainAxisAlignment.start,               
                                              children: <Widget>[
                                                  new Row(
                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                    mainAxisSize: MainAxisSize.max,
                                                    children: <Widget>[
                                                      new Padding(
                                                        padding: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 16.0),
                                                        child: new Text(washboxInfo["name"],textAlign: TextAlign.left,style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w600, color: Colors.black))
                                                      ),
                                                    ]
                                                  ),
                                                  
                                                  Offstage(
                                                    offstage: !(washboxInfo["hochdruckReiniger"] == "1"),
                                                    child:new Row(
                                                      mainAxisAlignment: MainAxisAlignment.start,
                                                      children: <Widget>[
                                                        new Padding(
                                                          padding: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 8.0),
                                                          child: Icon(Icons.check, color: Colors.black),
                                                        ),
                                                        new Padding(
                                                          padding: const EdgeInsets.fromLTRB(10.0, 2.0, 0.0, 8.0),
                                                          child: new Text("Hochdruckreiniger",textAlign: TextAlign.left,style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w400, color: Colors.black))
                                                        ),

                                                        
                                                      ]
                                                    ),
                                                  ),

                                                  Offstage(
                                                    offstage: !(washboxInfo["schaumBuerste"] == "1"),
                                                    child:new Row(
                                                      mainAxisAlignment: MainAxisAlignment.start,
                                                      children: <Widget>[
                                                        new Padding(
                                                          padding: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 8.0),
                                                          child: Icon(Icons.check, color: Colors.black),
                                                        ),
                                                        new Padding(
                                                          padding: const EdgeInsets.fromLTRB(10.0, 2.0, 0.0, 8.0),
                                                          child: new Text("Schaumbürste",textAlign: TextAlign.left,style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w400, color: Colors.black))
                                                        ),

                                                        
                                                      ]
                                                    ),
                                                  ),

                                                  
                                                  Offstage(
                                                    offstage: !(washboxInfo["schaumPistole"] == "1"),
                                                    child:new Row(
                                                      mainAxisAlignment: MainAxisAlignment.start,
                                                      children: <Widget>[
                                                        new Padding(
                                                          padding: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 8.0),
                                                          child: Icon(Icons.check, color: Colors.black),
                                                        ),
                                                        new Padding(
                                                          padding: const EdgeInsets.fromLTRB(10.0, 2.0, 0.0, 8.0),
                                                          child: new Text("Schaumpistole",textAlign: TextAlign.left,style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w400, color: Colors.black))
                                                        ),

                                                        
                                                      ]
                                                    ),
                                                  ),

                                                  
                                                  Offstage(
                                                    offstage: !(washboxInfo["fliessend Wasser"] == "1"),
                                                    child:new Row(
                                                      mainAxisAlignment: MainAxisAlignment.start,
                                                      children: <Widget>[
                                                        new Padding(
                                                          padding: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 8.0),
                                                          child: Icon(Icons.check, color: Colors.black),
                                                        ),
                                                        new Padding(
                                                          padding: const EdgeInsets.fromLTRB(10.0, 2.0, 0.0, 8.0),
                                                          child: new Text("fließend Wasser",textAlign: TextAlign.left,style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w400, color: Colors.black))
                                                        ),

                                                        
                                                      ]
                                                    ),
                                                  ),

                                                  
                                                  Offstage(
                                                    offstage: !(washboxInfo["motorWaesche"] == "1"),
                                                    child:new Row(
                                                      mainAxisAlignment: MainAxisAlignment.start,
                                                      children: <Widget>[
                                                        new Padding(
                                                          padding: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 8.0),
                                                          child: Icon(Icons.check, color: Colors.black),
                                                        ),
                                                        new Padding(
                                                          padding: const EdgeInsets.fromLTRB(10.0, 2.0, 0.0, 8.0),
                                                          child: new Text("Motorwäsche",textAlign: TextAlign.left,style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w400, color: Colors.black))
                                                        ),

                                                        
                                                      ]
                                                    ),
                                                  ),
                                                  
                                                  
                                                  new Padding(
                                                    padding: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
                                                    child:new Column(
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    mainAxisSize: MainAxisSize.max,
                                                    children: <Widget>[

                                                              Row(
                                                                mainAxisAlignment: MainAxisAlignment.start,
                                                                mainAxisSize: MainAxisSize.max,
                                                                children: <Widget>[
                                                                  new Padding(
                                                                    padding: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 8.0),
                                                                    child: Icon(Icons.hourglass_empty, color: Colors.black),
                                                                  ),
                                                                  new Padding(
                                                                    padding: const EdgeInsets.fromLTRB(10.0, 2.0, 0.0, 8.0),
                                                                    child: new Text("Fahrtzeit: ${washboxInfo["durationText"]}",textAlign: TextAlign.left,style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w400, color: Colors.black))
                                                                  ),
                                                                ],
                                                              ),

                                                              Row(
                                                                mainAxisAlignment: MainAxisAlignment.start,
                                                                mainAxisSize: MainAxisSize.max,
                                                                children: <Widget>[
                                                                  new Padding(
                                                                    padding: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 8.0),
                                                                    child: Icon(Icons.golf_course, color: Colors.black),
                                                                  ),
                                                                  new Padding(
                                                                    padding: const EdgeInsets.fromLTRB(10.0, 2.0, 0.0, 8.0),
                                                                    child: new Text("Entfernung: ${washboxInfo["distanceText"]}",textAlign: TextAlign.left,style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w400, color: Colors.black))
                                                                  ),
                                                                ],
                                                              )
                                                    ]
                                                  )
                                                ),                                                   
                                              ],
                                            )
                                          ),

                                          
                                          new Row(
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    crossAxisAlignment: CrossAxisAlignment.end,
                                                    children: <Widget>[
                                                      new Expanded(
                                                        child: new GestureDetector(
                                                          onTap:(){
                                                            _launchMaps(washboxInfo["latitude"], washboxInfo["longitude"]);                                                          
                                                          },
                                                          child: new Container(
                                                            
                                                            height: 60.0,
                                                            decoration: new BoxDecoration(
                                                              color: widget.coreClass.washboxColor,
                                                              borderRadius: new BorderRadius.only(                                                                  
                                                                  bottomLeft: const Radius.circular(10.0),
                                                                  bottomRight: const Radius.circular(10.0),
                                                              ),
                                                            ),
                                                            child: new Row(
                                                            mainAxisAlignment: MainAxisAlignment.center,
                                                            crossAxisAlignment: CrossAxisAlignment.center,
                                                            children: <Widget>[
                                                              Text("Navigation starten",style: TextStyle(color: Colors.white, fontSize: 16.0, fontWeight: FontWeight.bold))
                                                            ],
                                                            ),
                                                          )
                                                        ) 
                                                      )
                                                    ],
                                          )
                                          
                                          ],
                                          
                                        )
                                      ) 
                                  )
                                );                         
          },);
        }else if(action == "hide"){
          if(this.mounted){
            setState(() {
              controller.close();
              showBoxInfo=false;
              boxInfoToggled = true;
              containerFloatingActionButtonHeight = 65;
              actionButtonColor = Colors.white;
              actionButtonIcon = Icons.add;
              actionButtonIconColor = Colors.black;
              
            });
          }
        }
   } 

  
  

}
