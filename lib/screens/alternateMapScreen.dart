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

  List<LatLng> tappedPoints = [];
  var markers;
  bool addMode = false;
  bool addModeTapped = false;
  IconData actionButton = Icons.add;

  

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
      if(addModeTapped){
        print("remove");
              setState(() {
                  tappedPoints.removeAt(tappedPoints.length-1);
                  addModeTapped=false;
              });
      }
      print("addmode: off");
    }else{
      addMode=true;
      print("addmode: on");
    }
  }
  
  void addLocation(latlng){
    
        print("mode: $addMode");
        print("tapped: $addModeTapped");

        if(addMode){
          if(addModeTapped){
            print("remove");
            tappedPoints.removeAt(tappedPoints.length-1);

          }

          tappedPoints.add(latlng);
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
  
  @override
  Widget build(BuildContext context) {
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
                      child: new Icon(Icons.my_location,color: Colors.blue,size: 60.0,),
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

        backgroundColor: Colors.blue[900],
        appBar: new AppBar(
          title: new Text("DeepBlue", style: TextStyle(fontSize: 16.0),),
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

        floatingActionButton: new Stack(
          children: <Widget>[
            Align(
              alignment: Alignment.bottomRight,
              child:new FloatingActionButton(
              tooltip: 'Increment',
              child: new Icon(actionButton),
              backgroundColor: Colors.blue, 
              onPressed: toggleEditMode,
              ), // 
            )
          ],
        ),
        

        );     
  }

}
