import 'package:flutter/material.dart';
import 'package:deepblue/ViewModels/mapScreenState.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';

class MapScreenView extends MapScreenState{

  @override
  Widget build(BuildContext context) {
    registerLocation=widget.currentLocation;
    print("map register location$widget.currentLocation");
  
    _handleTap(LatLng latlng){
      setState(() {
        addLocation(latlng);
        //addMode = true;
      });
    }

    return new Scaffold(
        key: scaffoldKey,
        backgroundColor: Colors.blue[900],
        appBar: new AppBar(
          title: new Text(headlineText, style: TextStyle(fontSize: 16.0),),
          backgroundColor: Colors.blue[900],
          centerTitle: true,
          leading: new IconButton(
            icon: new Icon(Icons.arrow_back),
            onPressed: () {
              navigatorPushToHomeScreen();              
            },
          ),
        ),

        body: new FlutterMap(
          options: new MapOptions(
            center: new LatLng(widget.currentLocation["latitude"], widget.currentLocation["longitude"]),
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
            
            /*
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
            ),*/
            
          ],
        ),

        floatingActionButton:
              new Container(
                height: containerFloatingActionButtonHeight,
                child: new FloatingActionButton(
                        tooltip: 'Increment',
                        child: new IconTheme(
                                  data: new IconThemeData(color: actionButtonIconColor),
                                  child:  new Icon(actionButton),
                        ),
                        backgroundColor: actionButtonColor, 
                        onPressed: actionButtonPressed,
                        ), // 
              ),
        );     
  }
}