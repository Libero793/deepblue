import 'package:deepblue/screens/nameNewLocation.dart';
import 'package:deepblue/screens/registerLocationScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';
import 'package:location/location.dart';
import 'package:url_launcher/url_launcher.dart';


class AlternateMapScreen extends StatefulWidget {
  @override
  Map<String, double> location;
  AlternateMapScreen(this.location);

  _AlternateMapScreenState createState() => new _AlternateMapScreenState(location);
  
  
}

class _AlternateMapScreenState extends State<AlternateMapScreen>{

  Map<String, double> location;
  _AlternateMapScreenState(this.location);
  Map<String, double> registerLocation;
  

  List<LatLng> tappedPoints = [];
  var markers;
  bool addMode = false;
  bool addModeTapped = false;
  IconData actionButton = Icons.add;
  Color actionButtonColor = Colors.blue[900];
  Color actionButtonIconColor = Colors.white;
  String headlineText = "Kartenübersicht";
  double containerFloatingActionButtonHeight = 80.0;

  final GlobalKey<ScaffoldState> _scaffoldKey = new 
        GlobalKey<ScaffoldState>();

    PersistentBottomSheetController controller;

  

  _launchMaps(lat,lng) async {


    print("launchMaps");
    var map_api="AIzaSyCaFbeUE3tEoZyMf1KiF5RWnVSuvX2FId8";
    String googleUrl =
      'https://maps.google.com/';
    if (await canLaunch(googleUrl)) {
      print('launching com googleUrl');
      await launch(googleUrl);
    }else{
      print("cant Launch");
    } 
  }

  toggleEditMode(){
    
    if(addMode){
      addMode=false;
      showHint("hide");
      if(addModeTapped){
        print("remove");
              setState(() {
                  tappedPoints.removeAt(tappedPoints.length-1);
                  addModeTapped=false;
              });
      }
      if (this.mounted){
      setState(() {
              actionButtonIconColor=Colors.white;
              headlineText="Kartenübersicht";
              containerFloatingActionButtonHeight = 80.0;
      });}

      print("addmode: off");
    }else{
      addMode=true;
      showHint("show");
      if (this.mounted){
      setState(() {
              actionButtonIconColor=Colors.transparent;
              headlineText="Station hinzufügen";
              containerFloatingActionButtonHeight = 0.0;
            });}



      
      LatLng handler = new LatLng(location['latitude'], location['longitude']);

      addLocation(handler);
      print("addmode: on");
    }
  }
  
  void addLocation(latlng){
    
        print("mode: $addMode");
        print("tapped: $latlng");

        if(addMode){
          if(addModeTapped){
            print("remove");
            tappedPoints.removeAt(tappedPoints.length-1);

          }

          tappedPoints.add(latlng);

           //     if (this.mounted){
         // setState(() {
            registerLocation["longitude"] = latlng.longitude;
            registerLocation["latitude"] = latlng.latitude;
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
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
  }


   void showHint(action){


      
       
        ScaffoldState state = _scaffoldKey.currentState;
        
        if(action == "show"){
          controller = state.showBottomSheet<Null>((BuildContext context) {
                           
                          return  Container ( 
                                      height: 150.0,
                                      decoration: new BoxDecoration(
                                        color: Colors.transparent,
                                      ),
                                      child:new Container (
                                        decoration: new BoxDecoration(
                                          color: Colors.blue[900],
                                          borderRadius: new BorderRadius.only(
                                              topLeft: const Radius.circular(10.0),
                                              topRight: const Radius.circular(10.0)
                                          )
                                        ),
                                        child: new Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: <Widget>[
                                            new Padding(
                                                padding: const EdgeInsets.all(16.0),
                                                child: new Text(
                                                          'Klick auf die Map '
                                                          'um eine neue Waschbox hinzuzufügen',
                                                          textAlign: TextAlign.center,style: TextStyle(fontSize: 18.0, color: Colors.white, fontWeight: FontWeight.w400)
                                                        )
                                            ),
                                            new Row(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              mainAxisSize: MainAxisSize.min,
                                              children: <Widget>[
                                                new OutlineButton(
                                                  child: const Text('Abbrechen'),
                                                  color: Colors.blue[900],
                                                  highlightColor: Colors.green,
                                                  textColor: Colors.white,
                                                  splashColor: Colors.blue[900],
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
                                                  color: Colors.white,
                                                  textColor: Colors.blue[900],
                                                  splashColor: Colors.blue[900],
                                                  padding: EdgeInsets.symmetric(vertical: 10.0,horizontal: 30.0),
                                                  onPressed: () {
                                                    // Perform some action
                                                    Navigator.push(context,MaterialPageRoute(builder: (context) => NameNewLocationScreen(registerLocation)));
                                                  },
                                                ),
                                              ]
                                            )
                                            
          
                                        ],
                                      )
                                      ) 
                          );                         
          },);
          

        }else if(action == "hide"){
          controller.close();
        }

        
        

     
   } 

  
  @override
  Widget build(BuildContext context) {
    registerLocation=location;
    print("map register location$location");
   

    markers = tappedPoints.map((latlng) {
            return new Marker(
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
            );
          }).toList();



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
            },
          ),
        ),

        body: new FlutterMap(
          options: new MapOptions(
            center: new LatLng(location["latitude"], location["longitude"]),
            zoom: 13.0,
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
            
            MarkerLayerOptions(
              markers: [
                new Marker(
                  width: 60.0,
                  height: 90.0,
                  point: new LatLng(51.3703207,12.3652444),
                  builder: (ctx) =>
                   new Container(
                      child: new GestureDetector(
                         onTap: (){
                            //_launchMaps("51.3703207","12.3652444");
                            _showDialog(context);
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
                  
                ),
              ],
            ),
            
          ],
        ),

        floatingActionButton:
              new Container(
                height: containerFloatingActionButtonHeight,
                child: new FloatingActionButton(
                        tooltip: 'Increment',
                        child: new IconTheme(
                                  data: new IconThemeData(
                                      color: actionButtonIconColor),
                                  child:  new Icon(actionButton),
                        ),
                        backgroundColor: actionButtonColor, 
                        onPressed: toggleEditMode,
                        ), // 
              ),
        );     
  }

}
