import 'dart:async';
import 'dart:convert';

import 'package:deepblue/old/ViewModels/homeScreenState.dart';
import 'package:deepblue/old/ViewModels/registerNewLocationState.dart';
import 'package:deepblue/old/Views/mapScreenView.dart';
import 'package:deepblue/old/models/CoreFunctionsModel.dart';
import 'package:deepblue/old/models/RegisterNewLocationModel.dart';
import 'package:deepblue/old/models/nearLocationsModel.dart';
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

  LatLng tapHandler;

  Timer _reloadTimer;
  Color actionButtonColor;
  Color actionButtonIconColor = Colors.black;
  bool actionButtonToggled = false;

  Map<String, double> registerLocation;
  List<LatLng> tappedPoints = [];

  var washboxMap = null;
  bool showBoxInfo=false;
  bool registerLocationButtonAvailable = true;

  IconData actionButtonIcon;

  final addressInputController = TextEditingController();
  FocusNode addressInputFocusNode = new FocusNode();

  var flutterMapController = new MapController();
  
  RegisterNewLocationModel registerLocationClass = new RegisterNewLocationModel();

  final GlobalKey<ScaffoldState> scaffoldKey = new 
        GlobalKey<ScaffoldState>();

    PersistentBottomSheetController controller;

  @override
  void initState(){
    actionButtonColor = Colors.white;
    actionButtonIcon = Icons.add;
    printOnMap(widget.nearLocations.washboxen, widget.coreClass.washboxColor);
    printOnMap(widget.nearLocations.events, widget.coreClass.eventColor);
    printOnMap(widget.nearLocations.shootings, widget.coreClass.shootingColor);

    addressInputFocusNode.addListener(() {
       if (!addressInputFocusNode.hasFocus) {
         
          // TextField has lost focus
          geocodeLocation(addressInputController.text);
          registerLocationButtonAvailable = true;
       }else{
         registerLocationButtonAvailable = false;
       }
    });

    checkShowLocationCall();

    super.initState();
    
  }

  void checkShowLocationCall(){
    if(widget.coreClass.showMapLocation){
      print(scaffoldKey.currentState.toString());
      if(scaffoldKey.currentState.toString() != "null"){
        toggleBoxInfo("show", widget.coreClass.showLocationEntry, widget.coreClass.showLocationIconColor);
        flutterMapController.move(LatLng(double.parse(widget.coreClass.showLocationEntry["latitude"]), double.parse(widget.coreClass.showLocationEntry["longitude"])), 13);
        widget.coreClass.showMapLocation=false;
      }else{
        Future.delayed(const Duration(milliseconds: 500), () {
          checkShowLocationCall();
        });
      }
    }
  }

  void navigatorPushToHomeScreen(){
    Navigator.pop(context);
    Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen(widget.coreClass)));
  }

  

  void printOnMap(var map, Color iconColor){
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
                                toggleBoxInfo("show",map[i],iconColor);
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
      toggleBoxInfo("hide",null, Colors.transparent);
      boxInfoToggled = false;
    }else{
      if(!chooseLocationTapped){
        setState(() {
                chooseLocationTapped = true;
                containerFloatingActionButtonHeight=260;
                actionButtonColor = Colors.white;
                actionButtonIcon = Icons.close;
                actionButtonIconColor = Colors.black;
                actionButtonToggled = true;
        });
      }else{
        setState(() {
          chooseLocationTapped = false;
          containerFloatingActionButtonHeight = 65;
          actionButtonColor = Colors.white;
          actionButtonIcon = Icons.add;
          actionButtonIconColor = Colors.black;
          actionButtonToggled = false;
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
      
      tapHandler = new LatLng(widget.coreClass.getSelectedLocation()['latitude'], widget.coreClass.getSelectedLocation()['longitude']);
      addLocation(tapHandler); //initial cal for drawing thecurrent position cross
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
                                      height: 220.0,
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
                                                padding: const EdgeInsets.fromLTRB(20, 26, 20, 20),
                                                child: new Text(
                                                          'Klick auf die Map oder gib eine Adresse ein, '
                                                          'um $addLocationTypeName zur Karte hinzuzufügen',
                                                          textAlign: TextAlign.center,style: TextStyle(fontSize: 15.0, color: Colors.grey, fontWeight: FontWeight.w400, )
                                                        )
                                            ),

                                            new Padding(
                                                padding: const EdgeInsets.fromLTRB(30, 6, 30, 20),
                                                child: new TextField(
                                                  decoration: InputDecoration(
                                                    hintText: "Adresse suchen",
                                                    contentPadding: EdgeInsets.fromLTRB(10, 12, 10, 12),
                                                    border :new OutlineInputBorder(
                                                              borderSide: new BorderSide(color: Colors.grey,),
                                                              borderRadius: BorderRadius.all(Radius.circular(10))
                                                              
                                                              ),                                
                                                  ),
                                                  controller: addressInputController,
                                                  focusNode: addressInputFocusNode,
                                                  keyboardType: TextInputType.text,

                                                )
                                            ),

                                            new Row(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              mainAxisSize: MainAxisSize.min,
                                              children: <Widget>[
                                                new OutlineButton(
                                                  child: const Text('Abbrechen'),
                                                  textColor: Colors.grey[300],
                                                  highlightedBorderColor: Colors.red,
                                                  onPressed: () {
                                                    // Perform some action
                                                    toggleEditMode();
                                                  },
                                                ),

                                                new Padding(
                                                  padding: EdgeInsets.fromLTRB(40.0, 0.0, 40.0, 0.0)
                                                ),

                                                new RaisedButton(
                                              
                                                  child: const Text('Weiter'),
                                                  color: widget.coreClass.getColorSheme(getAddLocationType()),
                                                  textColor: Colors.white,
                                                  padding: EdgeInsets.symmetric(vertical: 10.0,horizontal: 30.0),
                                                  onPressed: () {
                                                    // Perform some action
                                                    if(registerLocationButtonAvailable){
                                                      Navigator.push(context,MaterialPageRoute(builder: (context) => RegisterNewLocation(registerLocationClass,widget.coreClass)));
                                                    }else{
                                                      addressInputFocusNode.unfocus();
                                                    }
                                                    
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

   void toggleBoxInfo(action,data,backgroundColor){
        ScaffoldState state = scaffoldKey.currentState;
        
        if(action == "show" && !addMode){
            print(data);
            if(this.mounted){
              setState(() {
                if(actionButtonToggled){
                  actionButtonToggle();
                }
                actionButtonColor=backgroundColor;
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
                                                        child: new Text(data["name"],textAlign: TextAlign.left,style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w600, color: Colors.black))
                                                      ),
                                                    ]
                                                  ),

                                                   
                                                  Offstage(
                                                    offstage: !(data["hochdruckReiniger"] == "1"),
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
                                                    offstage: !(data["schaumBuerste"] == "1"),
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
                                                    offstage: !(data["schaumPistole"] == "1"),
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
                                                    offstage: !(data["fliessend Wasser"] == "1"),
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
                                                    offstage: !(data["motorWaesche"] == "1"),
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
                                                    
                                                              Offstage(
                                                                offstage: (data["startTime"]==null),
                                                                child:
                                                                Row(
                                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                                  mainAxisSize: MainAxisSize.max,
                                                                  children: <Widget>[
                                                                    new Padding(
                                                                      padding: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 8.0),
                                                                      child: Icon(Icons.alarm_on, color: Colors.black),
                                                                    ),
                                                                    new Padding(
                                                                      padding: const EdgeInsets.fromLTRB(10.0, 2.0, 0.0, 8.0),
                                                                      child: new Text("${data["startTime"]}",textAlign: TextAlign.left,style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w400, color: Colors.black))
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),

                                                              Offstage(
                                                                offstage: (data["endTime"]==null),
                                                                child:
                                                                Row(
                                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                                  mainAxisSize: MainAxisSize.max,
                                                                  children: <Widget>[
                                                                    new Padding(
                                                                      padding: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 8.0),
                                                                      child: Icon(Icons.alarm_off, color: Colors.black),
                                                                    ),
                                                                    new Padding(
                                                                      padding: const EdgeInsets.fromLTRB(10.0, 2.0, 0.0, 8.0),
                                                                      child: new Text("${data["endTime"]}",textAlign: TextAlign.left,style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w400, color: Colors.black))
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),

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
                                                                    child: new Text("${data["durationText"]}",textAlign: TextAlign.left,style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w400, color: Colors.black))
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
                                                                    child: new Text("${data["distanceText"]}",textAlign: TextAlign.left,style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w400, color: Colors.black))
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
                                                            _launchMaps(data["latitude"], data["longitude"]);                                                          
                                                          },
                                                          child: new Container(
                                                            
                                                            height: 60.0,
                                                            decoration: new BoxDecoration(
                                                              color: backgroundColor,
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

   void geocodeLocation(String input){
     print("testinput: $input");

     var url = "https://maps.googleapis.com/maps/api/geocode/json?address="+
                input+"&key=AIzaSyCaFbeUE3tEoZyMf1KiF5RWnVSuvX2FId8";

    http.post(url, body: {})
        .then((response) {
          print("google Response ${response.body}");

          if (this.mounted){
            if(response.body != "null"){

              var nearestLocation;
              var nearestLocationsJson = "";

              nearestLocationsJson = response.body.toString();
              nearestLocation=json.decode(nearestLocationsJson);
              var tmplat = nearestLocation["results"][0]["geometry"]["location"]["lat"];
              var tmplng = nearestLocation["results"][0]["geometry"]["location"]["lng"];

              setState(() {
                print("$tmplat $tmplng");
                addLocation(LatLng(tmplat,tmplng));
                flutterMapController.move(LatLng(tmplat, tmplng), 13);

              });
      

            }
          }
        });
   }

  
  

}
