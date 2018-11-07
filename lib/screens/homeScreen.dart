import 'dart:async';
import 'dart:convert';
import 'package:deepblue/screens/alternateMapScreen.dart';
import 'package:deepblue/screens/locatingScreen.dart';
import 'package:flutter/material.dart';
import 'package:deepblue/models/CardItemModel.dart';
import 'package:location/location.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:deepblue/screens/registerLocationScreen.dart';
import 'package:geolocator/geolocator.dart' as gps;





class HomeScreen extends StatefulWidget {
  var positionMap = new Map<String,double>();
  HomeScreen(this.positionMap);

  @override
  _HomeScreenState createState() => new _HomeScreenState(positionMap);
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin{


  var cardIndex = 0;
  ScrollController scrollController;
  var currentColor = Colors.blue[900];
  var cardsList = [CardItemModel("Waschbär", Icons.local_car_wash,300, 0.83),
                   CardItemModel("Aral", Icons.local_gas_station,500, 0.24),
                   CardItemModel("Waschbox", Icons.local_car_wash,600, 0.24),
                   CardItemModel("Waschbox", Icons.local_car_wash,700, 0.24),
                   CardItemModel("Total", Icons.local_gas_station,3000, 0.32)];
                  
  var cardColors = [];

  AnimationController animationController;
  ColorTween colorTween;
  CurvedAnimation curvedAnimation;
  Future httpReturn;
  int nearLocationsCount = 0;


  bool currentWidget = true;
  Image image1;
  String nearestLocationsJson;
  bool httpRequestExecuted = false;

  var positionMap = new Map<String,double>();
  _HomeScreenState(this.positionMap);


  @override
  void initState() {
    super.initState();

    scrollController = new ScrollController();    
    
  }

 

  void httpRequest(var location)async {
    print("httploc ${location}");

    var url = "http://www.nell.science/deepblue/index.php";

    http.post(url, body: {"getWashingLocations":"true","key": "0", "latitude": location['latitude'].toString(), "longitude": location['longitude'].toString()})
        .then((response) {
      print("Response status: ${response.statusCode}");   
      print("Response body: ${response.body}");

      if (this.mounted){
        setState((){
                nearestLocationsJson = "";
                nearestLocationsJson = response.body.toString();
                nearLocationsCount=json.decode(nearestLocationsJson).length;
            });
      }

    });
    
  }

  void setCardColors() {
    print("list${cardsList.length}");
    for( var i=0; i < cardsList.length; i++){
      if(cardsList[i].distance <= 500){
        cardColors.add(Colors.blue[900]);
      }
      if(cardsList[i].distance <= 1000 && cardsList[i].distance >500){
        cardColors.add(Colors.green[700]);
      }
      if(cardsList[i].distance > 1001){
        cardColors.add(Colors.red[500]);
      }

      print("i$i");
    }
    
  }



  @override
  Widget build(BuildContext context) {
    //print("location${widget._currentLocation}");
    if(!httpRequestExecuted){
      httpRequest(positionMap);
      httpRequestExecuted=true;
    }
    
    setCardColors();
    return new Scaffold(
      backgroundColor: currentColor,
      appBar: new AppBar(
        title: new Text("DeepBlue", style: TextStyle(fontSize: 16.0),),
        backgroundColor: currentColor,
        centerTitle: true,
        leading: new IconButton(
          icon: new Icon(Icons.map),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AlternateMapScreen(positionMap)),
            );
          },
        ),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: new IconButton(
              icon: new Icon(Icons.add_box),
              onPressed: () {
                /*
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => RegisterLocationScreen()),
                );*/
              },
            )
          ),
        ],
        elevation: 0.0,
      ),
      /*
      drawer: new Drawer(
        child: new ListView(
          children: <Widget>[
            new DrawerHeader(
              child: new Text("Menu", style: TextStyle(fontSize: 30.0,color: Colors.white),),
              decoration: BoxDecoration(color: Colors.blue[900])
            ),
            new ListTile(
              title: new Text("Home"),
              onTap: () {},
            ),
            new Divider(),
            new ListTile(
              title: new Text("Map"),
              onTap: () {},
            ),
            new Divider(),
            new ListTile(
              title: new Text("Add Station"),
              onTap: () {},
            )
          ]
        )
      ),*/
      body: new Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 64.0, vertical: 32.0),
              child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      child: Icon(Icons.account_circle, size: 45.0, color: Colors.white,),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0.0,16.0,0.0,12.0),
                      child: Text("Good News", style: TextStyle(fontSize: 30.0, color: Colors.white, fontWeight: FontWeight.w400),),
                    ),
                    Text("We found "+"${nearLocationsCount}"+" Washing Stations next to your Location", style: TextStyle(color: Colors.white),),
                    Text("", style: TextStyle(color: Colors.white)),
                  ],
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                
                Container(
                  height: 350.0,
                  child: ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: cardsList.length,
                    controller: scrollController,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, position) {
                      return GestureDetector(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Card(
                            child: Container(
                              width: 250.0,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Icon(cardsList[position].icon, color: cardColors[position],),
                                        Icon(Icons.more_vert, color: Colors.grey,),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                                          child: Text("${cardsList[position].distance}"+"m", style: TextStyle(color: Colors.grey),),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                                          child: Text("${cardsList[position].cardTitle}", style: TextStyle(fontSize: 28.0),),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: LinearProgressIndicator(value: cardsList[position].taskCompletion,),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0)
                            ),
                          ),
                        ),
                        onHorizontalDragEnd: (details) {
                          

                          animationController = AnimationController(vsync: this, duration: Duration(milliseconds: 500));
                          curvedAnimation = CurvedAnimation(parent: animationController, curve: Curves.fastOutSlowIn);
                          animationController.addListener(() {
                            setState(() {
                              currentColor = colorTween.evaluate(curvedAnimation);
                            });
                          });

                          if(details.velocity.pixelsPerSecond.dx > 0) {
                            if(cardIndex>0) {
                              cardIndex--;
                              colorTween = ColorTween(begin:currentColor,end:cardColors[cardIndex]);
                            }
                          }else {
                            if(cardIndex<(cardsList.length-1)) {
                              cardIndex++;
                              colorTween = ColorTween(begin: currentColor,
                                  end: cardColors[cardIndex]);
                            }
                          }
                          setState(() {
                            scrollController.animateTo((cardIndex)*256.0, duration: Duration(milliseconds: 500), curve: Curves.fastOutSlowIn);
                          });

                          colorTween.animate(curvedAnimation);

                          animationController.forward( );

                        },
                      );
                    },
                  ),
                ),
              ],
            )
          ],
        ),
      ),
      //drawer: Drawer(),
    );

    
  }
}

 
