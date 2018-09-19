import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';
import 'package:location/location.dart';


class AlternateMapScreen extends StatefulWidget {
  @override
  Map<String, double> location;
  AlternateMapScreen(this.location);

  _AlternateMapScreenState createState() => new _AlternateMapScreenState(location);
  
  
}

class _AlternateMapScreenState extends State<AlternateMapScreen>{

  Map<String, double> location;
  _AlternateMapScreenState(this.location);

  
  @override
  Widget build(BuildContext context) {
    print("map register location$location");
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
            new MarkerLayerOptions(
              markers: [
                new Marker(
                  width: 80.0,
                  height: 80.0,
                  point: new LatLng(51.5, -0.09),
                  builder: (ctx) =>
                  new Container(
                    child: new FlutterLogo(),
                  ),
                ),
              ],
            ),
          ],
        ),
    );
    
  }

}
