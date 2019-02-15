import 'package:deepblue/ViewModels/manualLocationMapState.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';

class ManualLocationMapView extends ManualLocationMapState {

   @override
  Widget build(BuildContext context) {

     
    _handleTap(LatLng latlng){
      setState(() {
        addLocation(latlng);
      });
    }

    return new Scaffold(
        //key: _scaffoldKey,
        backgroundColor: widget.coreClass.getHighlightColor(),
        appBar: new AppBar(
          title: new Text(headlineText, style: TextStyle(fontSize: 16.0),),
          backgroundColor: widget.coreClass.getHighlightColor(),
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
                      color: widget.coreClass.getHighlightColor(),
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
                                            textColor: widget.coreClass.getHighlightColor(),
                                            splashColor: widget.coreClass.getHighlightColor(),
                                            padding: EdgeInsets.symmetric(vertical: 10.0,horizontal: 30.0),
                                            onPressed: () {
                                                if(pointTapped){
                                                  pushToHomeScreen(selectedLocation);
                                                  
                                                }else{
                                                  doShowDialog(context);
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