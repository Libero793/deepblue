import 'package:flutter/material.dart';
import 'package:deepblue/ViewModels/mapScreenState.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';

class MapScreenView extends MapScreenState{

  @override
  Widget build(BuildContext context) {
    registerLocation=widget.coreClass.getSelectedLocation();
    print("map register location$widget.currentLocation");
  
    _handleTap(LatLng latlng){
      setState(() {
        addLocation(latlng);
        //addMode = true;
      });
    }

    return new Scaffold(
        key: scaffoldKey,
        backgroundColor: widget.coreClass.getHighlightColor(),
        appBar: new AppBar(
          title: new Text(headlineText, style: TextStyle(fontSize: 16.0, color: Colors.black),),
          backgroundColor: Colors.white,
          centerTitle: true,
          leading: new IconButton(
            icon: new Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () {
              navigatorPushToHomeScreen();              
            },
          ),
        ),

        body: new FlutterMap(
          mapController: flutterMapController,
          options: new MapOptions(
            center: LatLng (widget.coreClass.getSelectedLocation()["latitude"], widget.coreClass.getSelectedLocation()["longitude"]),
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
            
            
          ],
        ),

        floatingActionButton:
            Offstage(
              offstage: false,
              child: new Container(
                height: containerFloatingActionButtonHeight,
                color: Colors.transparent,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    new Offstage(
                      offstage: !chooseLocationTapped,
                      child: Column(
                        children: <Widget>[

                          GestureDetector(
                            onTap: (){
                              setAddLocationType("washbox");
                              toggleEditMode();
                            },
                            child: Padding(
                              padding: EdgeInsets.only(bottom: 10),
                              child: Container(
                                width: 55,
                                height: 55,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(Radius.circular(27.5)),
                                  color: widget.coreClass.getWashboxColor(),
                                ),
                                child: Icon(
                                  Icons.local_car_wash,
                                  color: Colors.white,
                                  size: 30,
                                ),
                              ),
                            ),
                          ),

                          GestureDetector(
                            onTap: (){
                              setAddLocationType("shooting");
                              toggleEditMode();
                            },
                            child: Padding(
                            padding: EdgeInsets.only(bottom: 10),
                              child: Container(
                                width: 55,
                                height: 55,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(Radius.circular(27.5)),
                                  color: widget.coreClass.getShootingColor(),
                                ),
                                child: Icon(
                                  Icons.camera_alt,
                                  color: Colors.white,
                                  size: 30,
                                ),
                              ),
                            ),
                          ),

                          GestureDetector(
                            onTap: (){
                              setAddLocationType("event");
                              toggleEditMode();
                            },
                            child: Padding(
                              padding: EdgeInsets.only(bottom: 10),
                              child: Container(
                                width: 55,
                                height: 55,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(Radius.circular(27.5)),
                                  color: widget.coreClass.getEventColor(),
                                ),
                                child: Icon(
                                  Icons.star,
                                  color: Colors.white,
                                  size: 30,
                                ),
                              ),
                            ),
                          ),
                          
                        ],
                      ),
                    ),
                      
                    Column(
                      children: <Widget>[
                        
                        GestureDetector(
                          onTap: actionButtonToggle,
                          child: Padding(
                              padding: EdgeInsets.only(bottom: 0),
                              child: Container(
                                width: 55,
                                height: 55,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(Radius.circular(27.5)),
                                  color: actionButtonColor,
                                ),
                                child: Icon(
                                  actionButtonIcon,
                                  color: actionButtonIconColor,
                                  size: 30,
                                ),
                              ),
                            ),
                        )
                          
                      ]
                    ),
                      
                  ],
                ) 
              ),
            ),
        );     
  }
}